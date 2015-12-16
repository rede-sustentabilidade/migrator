
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
CREATE TYPE access_level_kind AS ENUM (
       'municipal',
       'estadual',
       'nacional'
);

CREATE SEQUENCE regra_afiliados_id_seq
       START WITH 1
       INCREMENT BY 1
       NO MINVALUE
       NO MAXVALUE
       CACHE 1;

CREATE TABLE rs.regra_afiliados (
       id bigint PRIMARY KEY DEFAULT nextval('regra_afiliados_id_seq'::regclass),
       role_name name NOT NULL,
       access_level access_level_kind NOT NULL,
       user_id bigint REFERENCES rs.afiliados(user_id),
       city_id integer,
       state_id integer
);
-- +goose StatementEnd


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

-- +goose StatementBegin
DROP TYPE access_level_kind;
DROP TABLE rs.regra_afialiados;
-- +goose StatementEnd

