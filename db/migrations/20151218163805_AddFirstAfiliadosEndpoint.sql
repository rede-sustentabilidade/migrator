
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
CREATE OR REPLACE FUNCTION public.all_rs_roles() RETURNS name[]
       LANGUAGE sql
       AS $$
          SELECT array_agg(rolname)
          FROM pg_roles
          WHERE rolname ~ 'rs_role_.*';
       $$;

CREATE OR REPLACE VIEW "1".filiados AS
    SELECT
        a.user_id,
        a.birthday,
        a.nome_mae,
        a.nacionalidade,
        a.cep,
        a.endereco,
        a.bairro,
        a.cidade,
        a.uf,
        a.telefone_residencial,
        a.telefone_celular,
        a.telefone_comercial,
        a.contribuicao,
        a.titulo_eleitoral,
        a.zona_eleitoral,
        a.secao_eleitoral,
        a.cpf,
        a.ativista,
        a.escolaridade,
        a.local_trabalho,
        a.created_at,
        a.updated_at,
        a.numero,
        a.complemento,
        a.filiado_outros_quais,
        a.cadidatura_quais,
        a.cargo_eletivo_quais,
        a.cargo_confianca_quais,
        a.ativista_quais,
        a.status,
        a.candidato_cargo,
        a.candidato_motivo,
        a.candidato_base,
        a.candidato_estatuto,
        a.candidato_antecedentes,
        a.filiado_partido_quais,
        a.foi_candidato_quais,
        a.atual_anterior_eleito_quais,
        a.leu_manifesto,
        a.sexo,
        a.quer_ser_candidato,
        a.filiado_partido,
        a.foi_candidato,
        a.atual_anterior_eleito,
        a.cargo_confianca,
        a.voluntario,
        a.leu_estatuto,
        a.quem_abonou,
        a.quando_abonou,
        a.nome,
        a.email,
        a.fullname,
        a.filiaweb
    FROM rs.afiliados a
    WHERE public.can_access_with_roles(public.all_rs_roles(), a.cidade_id, a.estado_id)
        OR public.is_owner_or_admin(a.user_id);

GRANT SELECT ON "1".filiados TO admin, web_user;
-- +goose StatementEnd


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

-- +goose StatementBegin
DROP FUNCTION public.all_rs_roles();
DROP VIEW "1".filiados;
-- +goose StatementEnd
