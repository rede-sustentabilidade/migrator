
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

GRANT USAGE ON SCHEMA "1" TO anonymous, admin, web_user;
GRANT SELECT ON TABLE rs.afiliados TO web_user, admin;
GRANT SELECT ON TABLE rs.regra_afiliados TO web_user, admin;
GRANT ALL ON SCHEMA rs TO rede;
GRANT USAGE ON SCHEMA rs TO web_user, admin;

ALTER TABLE rs.afiliados
      ALTER COLUMN created_at SET DEFAULT now(),
      ALTER COLUMN updated_at SET DEFAULT now();

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

