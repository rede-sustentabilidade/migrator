
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin

CREATE OR REPLACE VIEW "1".states AS
       SELECT
        e.id AS id,
        e.nome AS name,
        e.uf AS abbr,
        e.regiao AS region,
        COUNT(DISTINCT c.id) AS total_cities
       FROM rs.estados e
       JOIN rs.cidades c ON c.estado_id = e.id
       GROUP BY e.id;

CREATE OR REPLACE VIEW "1".cities AS
       SELECT
        c.id AS id,
        c.estado_id AS state_id,
        c.codigo AS code,
        c.nome AS name,
        c.uf AS state_abbr
       FROM rs.cidades c;

GRANT SELECT ON "1".cities TO admin, web_user, anonymous;
GRANT SELECT ON "1".states TO admin, web_user, anonymous;

-- +goose StatementEnd


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

-- +goose StatementBegin
DROP VIEW "1".states;
DROP VIEW "1".cities;
-- +goose StatementEnd

