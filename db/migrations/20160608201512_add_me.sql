
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
CREATE OR REPLACE VIEW "1".me AS
       SELECT
        json_build_object(
          'id', a.user_id,
          'name', a.nome,
          'email', a.email
        ) as me
       FROM rs.afiliados a
       WHERE a.user_id = public.current_user_id();

GRANT SELECT ON "1".me TO web_user, admin;
-- +goose StatementEnd


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

-- +goose StatementBegin
DROP VIEW "1".me;
-- +goose StatementEnd
