
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
CREATE OR REPlACE VIEW "1".access_roles AS
       SELECT
        pr.rolname AS name
       FROM pg_catalog.pg_roles pr
       WHERE pr.rolname ~* 'rs_role';

GRANT SELECT ON "1".access_roles TO admin, web_user;
-- +goose StatementEnd


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back


-- +goose StatementBegin
DROP VIEW "1".access_roles;
-- +goose StatementEnd
