
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


INSERT INTO rs.roles (id, level, name, description, superuser) VALUES (
  1,
  0,
  'admin',
  'Administrador',
  TRUE
);


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
