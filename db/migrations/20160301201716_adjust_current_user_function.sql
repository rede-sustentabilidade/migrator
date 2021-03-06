
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
CREATE OR REPLACE FUNCTION public.current_user_id() RETURNS integer
LANGUAGE plpgsql
AS $function$
BEGIN
RETURN nullif(current_setting('postgrest.claims.user_id'), '')::integer;
EXCEPTION WHEN others THEN 
SET postgrest.claims.user_id TO '';
RETURN NULL::integer;
END
$function$;
-- +goose StatementEnd


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

-- +goose StatementBegin
CREATE OR REPLACE FUNCTION public.current_user_id()
RETURNS integer
LANGUAGE sql
AS $function$
SELECT nullif(current_setting('user_vars.user_id'), '')::integer;
$function$
;
-- +goose StatementEnd

