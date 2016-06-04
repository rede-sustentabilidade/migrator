
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
CREATE OR REPLACE VIEW "1".user_access_roles AS
       SELECT
        ra.id AS role_access_id,
        ra.user_id,
        ra.role_name AS role_name,
        ra.access_level,
        ra.city_id,
        ra.state_id
       FROM rs.regra_afiliados ra
       WHERE public.is_owner_or_admin(ra.user_id);

GRANT SELECT ON "1".user_access_roles TO admin, web_user;
-- +goose StatementEnd


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

-- +goose StatementBegin
DROP VIEW "1".user_access_roles;
-- +goose StatementEnd

