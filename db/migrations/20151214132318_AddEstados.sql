
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin

CREATE TABLE IF NOT EXISTS rs.estados (
       id integer PRIMARY KEY,
       nome text NOT NULL,
       uf text NOT NULL,
       regiao text NOT NULL
);

CREATE UNIQUE INDEX unique_uf_idx ON rs.estados (uf);

INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('1', 'Acre', 'AC', 'Norte');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('2', 'Alagoas', 'AL', 'Nordeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('3', 'Amapá', 'AP', 'Norte');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('4', 'Amazonas', 'AM', 'Norte');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('5', 'Bahia', 'BA', 'Nordeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('6', 'Ceará', 'CE', 'Nordeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('7', 'Distrito Federal', 'DF', 'Centro-Oeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('8', 'Espírito Santo', 'ES', 'Sudeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('9', 'Goiás', 'GO', 'Centro-Oeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('10', 'Maranhão', 'MA', 'Nordeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('11', 'Mato Grosso', 'MT', 'Centro-Oeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('12', 'Mato Grosso do Sul', 'MS', 'Centro-Oeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('13', 'Minas Gerais', 'MG', 'Sudeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('14', 'Pará', 'PA', 'Nordeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('15', 'Paraíba', 'PB', 'Nordeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('16', 'Paraná', 'PR', 'Sul');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('17', 'Pernambuco', 'PE', 'Nordeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('18', 'Piauí', 'PI', 'Nordeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('19', 'Rio de Janeiro', 'RJ', 'Sudeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('20', 'Rio Grande do Norte', 'RN', 'Nordeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('21', 'Rio Grande do Sul', 'RS', 'Sul');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('22', 'Rondônia', 'RO', 'Norte');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('23', 'Roraima', 'RR', 'Norte');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('24', 'Santa Catarina', 'SC', 'Sul');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('25', 'São Paulo', 'SP', 'Sudeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('26', 'Sergipe', 'SE', 'Nordeste');
INSERT INTO rs.estados (id, nome, uf, regiao) VALUES ('27', 'Tocantins', 'TO', 'Norte');

-- +goose StatementEnd


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

-- +goose StatementBegin

DROP TABLE rs.estados;

-- +goose StatementEnd

