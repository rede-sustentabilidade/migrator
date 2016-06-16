
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
CREATE OR REPLACE FUNCTION public.is_admin() RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
        SELECT current_user = ANY(ARRAY['rs_role_admin_master', 'admin']);
    $$;


CREATE OR REPLACE FUNCTION public.api_insert_access_role() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
        BEGIN

            IF NOT public.is_admin() THEN
                RAISE EXCEPTION 'need to be admin'
            END IF;

            -- check if user has correct roles to access this function
            -- check if user has correct access to affiliated 

            INSERT INTO rs.regra_afiliados(user_id, city_id, state_id, access_level, role_name)
                VALUES (
                    (CASE WHEN public.is_admin() THEN NEW.user_id ELSE public.current_user_id() END),
                    NEW.city_id,
                    NEW.state_id,
                    NEW.access_level,
                    NEW.role_name
                );

            RETURN NEW;
        END;
    $$;


CREATE TRIGGER api_insert_access_role INSTEAD OF INSERT ON "1".filiados FOR EACH ROW EXECUTE PROCEDURE public.api_insert_access_role();
-- +goose StatementEnd


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

-- +goose StatementBegin
DROP FUNCTION public.is_admin();
DROP FUNCTION public.api_insert_access_roles();
-- +goose StatementEnd
