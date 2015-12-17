
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
CREATE UNIQUE INDEX role_aclv_user_uix ON rs.regra_afiliados(user_id, access_level, role_name);

CREATE OR REPLACE FUNCTION public.current_user_id() RETURNS integer
       LANGUAGE sql
       AS $$
            SELECT nullif(current_setting('user_vars.user_id'), '')::integer;
       $$;

CREATE OR REPLACE FUNCTION public.current_user_roles() RETURNS name[]
       LANGUAGE sql
       AS $$
          SELECT array_agg(DISTINCT role_name) 
          FROM rs.regra_afiliados 
          WHERE user_id = current_user_id();
       $$;

CREATE OR REPLACE FUNCTION public.current_user_max_access_level_for_roles(role_names name[]) RETURNS access_level_kind
       LANGUAGE sql
       AS $$
          SELECT max(access_level)::access_level_kind
          FROM rs.regra_afiliados 
          WHERE user_id = current_user_id()
          AND role_name = ANY(role_names);
       $$;

CREATE OR REPLACE FUNCTION public.current_user_max_access_level_for_roles_region(role_names name[], cid integer, sid integer) RETURNS access_level_kind
       LANGUAGE sql
       AS $$
          SELECT max(access_level)::access_level_kind
          FROM rs.regra_afiliados 
          WHERE user_id = current_user_id()
          AND role_name = ANY(role_names)
          AND (state_id = sid OR city_id = cid);
       $$;

CREATE OR REPLACE FUNCTION public.can_access_with_roles(role_names name[], cid integer, sid integer) RETURNS boolean
       LANGUAGE plpgsql
       AS $$
          BEGIN
            -- if user not have any role should return false
            IF NOT (SELECT (current_user_roles() && role_names)) THEN
               RETURN false;
            END IF;

            -- if has nacional access should return true
            IF current_user_max_access_level_for_roles(role_names) = 'nacional'::access_level_kind THEN
               RETURN true;
            END IF;

            -- if user has access to state
            IF current_user_max_access_level_for_roles_region(role_names, null, sid)  >= 'estadual'::access_level_kind THEN
               RETURN true;
            END IF;

            -- if user has access to city
            IF current_user_max_access_level_for_roles_region(role_names, cid, null)  >= 'municipal'::access_level_kind THEN
               RETURN true;
            END IF;

            RETURN false;
          END;
       $$;

-- +goose StatementEnd

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back


-- +goose StatementBegin
DROP FUNCTION public.current_user_id();
DROP FUNCTION public.current_user_roles();
DROP FUNCTION public.current_user_max_access_level_for_roles(role_names name[]);
DROP FUNCTION public.current_user_max_access_level_for_roles_region(role_names name[], city_id integer, state_id integer);
DROP FUNCTION public.can_access_with_roles(role_name name[], city_id integer, state_id integer);
DROP INDEX rs.role_aclv_user_uix;
-- +goose StatementEnd
