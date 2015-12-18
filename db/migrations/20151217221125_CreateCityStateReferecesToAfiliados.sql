
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
CREATE INDEX regra_afiliados_idx ON rs.regra_afiliados (user_id, role_name, access_level, city_id, state_id);

ALTER TABLE rs.afiliados
      ADD COLUMN cidade_id integer,
      ADD COLUMN estado_id integer;

ALTER TABLE rs.afiliados
      ADD FOREIGN KEY (cidade_id)  REFERENCES rs.cidades(id),
      ADD FOREIGN KEY (estado_id)  REFERENCES rs.estados(id);

CREATE INDEX afiliados_region_idx ON rs.afiliados (user_id, cidade_id, estado_id);

UPDATE rs.afiliados a
       SET cidade_id = (
           SELECT c.id FROM rs.cidades c 
           WHERE lower(unaccent(c.nome)) = lower(unaccent(a.cidade))
           AND lower(c.uf) = lower(a.uf) LIMIT 1),
       estado_id = (
           SELECT e.id FROM rs.estados e 
           WHERE lower(e.uf) = lower(a.uf) LIMIT 1);
-- +goose StatementEnd


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

-- +goose StatementBegin
DROP INDEX rs.regra_afiliados_idx;
DROP INDEX rs.afiliados_region_idx;
ALTER TABLE rs.afiliados
      DROP COLUMN cidade_id,
      DROP COLUMN estado_id;
-- +goose StatementEnd

