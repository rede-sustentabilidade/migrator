
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

CREATE SEQUENCE roles_id_seq;

CREATE TABLE IF NOT EXISTS rs.roles (
    id bigint NOT NULL DEFAULT nextval('roles_id_seq'),
    level smallint NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(255) NOT NULL,
    superuser boolean DEFAULT FALSE,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    created_by bigint
);

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;
ALTER TABLE ONLY roles ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
ALTER TABLE ONLY roles ADD CONSTRAINT created_by_fkey FOREIGN KEY (created_by)
    REFERENCES afiliados(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


INSERT INTO rs.roles (id, level, name, description, superuser) VALUES (1, 0, 'admin', 'Administrador', TRUE);
INSERT INTO rs.roles (id, level, name, description, superuser) VALUES (2, 1, 'coord_organizacao', 'Coordenador de Organização', FALSE);
INSERT INTO rs.roles (id, level, name, description, superuser) VALUES (3, 1, 'coord_executiva', 'Coordenador da Executiva', FALSE);
INSERT INTO rs.roles (id, level, name, description, superuser) VALUES (4, 1, 'coord_geral', 'Coordenador Geral', FALSE);
INSERT INTO rs.roles (id, level, name, description, superuser) VALUES (5, 1, 'coord_formacao', 'Coordenador de Formação', FALSE);
INSERT INTO rs.roles (id, level, name, description, superuser) VALUES (6, 1, 'coord_comunicacao', 'Coordenador de Comunicação', FALSE);
INSERT INTO rs.roles (id, level, name, description, superuser) VALUES (7, 1, 'coord_acao_institucional', 'Coordenador de Ação Institucional', FALSE);
INSERT INTO rs.roles (id, level, name, description, superuser) VALUES (8, 1, 'coord_politicas_publicas', 'Coordenador de Políticas Públicas', FALSE);
INSERT INTO rs.roles (id, level, name, description, superuser) VALUES (9, 1, 'coord_movimentos_sociais', 'Coordenador de Movimentos Sociais', FALSE);
INSERT INTO rs.roles (id, level, name, description, superuser) VALUES (10, 1, 'coord_ativismo', 'Coordenador de Ativismo', FALSE);
INSERT INTO rs.roles (id, level, name, description, superuser) VALUES (11, 1, 'coord_relacoes_internacionais', 'Coordenador de ', FALSE);
INSERT INTO rs.roles (id, level, name, description, superuser) VALUES (12, 1, 'coord_vogal_executiva', 'Coordenador de Vogal Executiva', FALSE);
INSERT INTO rs.roles (id, level, name, description, superuser) VALUES (13, 100, 'filiado', 'Filiado', FALSE);
INSERT INTO rs.roles (id, level, name, description, superuser) VALUES (14, 1000, 'usuario', 'Usuário Não Filiado', FALSE);
INSERT INTO rs.roles (id, level, name, description, superuser) VALUES (15, 10000, 'anonimo', 'Usuário Anônimo', FALSE);


CREATE TABLE IF NOT EXISTS rs.link_roles_afiliados (
    role_id bigint,
    afiliado_id bigint,
    params json
);

ALTER TABLE ONLY link_roles_afiliados
    ADD CONSTRAINT link_roles_afiliados_pkey PRIMARY KEY (role_id, afiliado_id);
ALTER TABLE ONLY link_roles_afiliados ADD CONSTRAINT role_id_fkey FOREIGN KEY (role_id)
    REFERENCES roles(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY link_roles_afiliados ADD CONSTRAINT afiliado_id_fkey FOREIGN KEY (afiliado_id)
    REFERENCES afiliados(user_id) ON UPDATE CASCADE ON DELETE CASCADE;



CREATE SEQUENCE permissions_id_seq;

CREATE TABLE IF NOT EXISTS rs.permissions (
    id bigint NOT NULL DEFAULT nextval('permissions_id_seq'),
    role_id bigint NOT NULL,
    type character varying(255) NOT NULL,
    resource character varying(255) NOT NULL,
    params json
);

ALTER SEQUENCE permissions_id_seq OWNED BY permissions.id;
ALTER TABLE ONLY permissions ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY permissions ADD CONSTRAINT role_id_fkey FOREIGN KEY (role_id)
    REFERENCES roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

DROP TABLE link_roles_afiliados;
DROP TABLE permissions;
DROP TABLE roles;
