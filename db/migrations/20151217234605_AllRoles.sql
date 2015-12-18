
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
CREATE OR REPLACE FUNCTION public.is_owner_or_admin(bigint) RETURNS boolean
       LANGUAGE sql
       STABLE
       AS $$
          SELECT
          current_user_id() = $1
          OR current_user = 'rs_role_admin_master';
       $$;

CREATE ROLE rs_role_admin_master NOLOGIN;
CREATE ROLE rs_role_afiliado NOLOGIN;
CREATE ROLE rs_role_coord_organizacao NOLOGIN;
CREATE ROLE rs_role_coord_executiva NOLOGIN;
CREATE ROLE rs_role_coord_geral NOLOGIN;
CREATE ROLE rs_role_coord_formacao NOLOGIN;
CREATE ROLE rs_role_coord_comunicacao NOLOGIN;
CREATE ROLE rs_role_coord_acao_institucional NOLOGIN;
CREATE ROLE rs_role_coord_politicas_pub NOLOGIN;
CREATE ROLE rs_role_coord_movimentos_sociais NOLOGIN;
CREATE ROLE rs_role_coord_ativismo NOLOGIN;
CREATE ROLE rs_role_coord_relacoes_int NOLOGIN;
CREATE ROLE rs_role_coord_vogal_executiva NOLOGIN;
-- +goose StatementEnd

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

-- +goose StatementBegin
DROP FUNCTION IF EXISTS public.is_owner_or_admin(integer);

DROP ROLE rs_role_admin_master;
DROP ROLE rs_role_afiliado;
DROP ROLE rs_role_coord_organizacao;
DROP ROLE rs_role_coord_executiva;
DROP ROLE rs_role_coord_geral;
DROP ROLE rs_role_coord_formacao;
DROP ROLE rs_role_coord_comunicacao;
DROP ROLE rs_role_coord_acao_institucional;
DROP ROLE rs_role_coord_politicas_pub;
DROP ROLE rs_role_coord_movimentos_sociais;
DROP ROLE rs_role_coord_ativismo;
DROP ROLE rs_role_coord_relacoes_int;
DROP ROLE rs_role_coord_vogal_executiva;
-- +goose StatementEnd
