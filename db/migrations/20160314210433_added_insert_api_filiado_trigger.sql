
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
CREATE OR REPLACE FUNCTION public.api_insert_filiado() RETURNS TRIGGER
    LANGUAGE plpgsql 
    AS $$
        DECLARE
            v_filiado_id numeric;
            v_filiado "1".filiados;
        BEGIN
            INSERT INTO rs.afiliados (user_id, birthday, nome_mae, nacionalidade, 
                cep, numero, complemento, endereco, bairro, cidade, uf, telefone_residencial, 
                telefone_celular, telefone_comercial, contribuicao, 
                titulo_eleitoral, zona_eleitoral, secao_eleitoral, cpf, 
                ativista, escolaridade, local_trabalho, created_at,
                filiado_outros_quais, cadidatura_quais, cargo_eletivo_quais, 
                cargo_confianca_quais, ativista_quais, status, candidato_cargo,
                candidato_motivo, candidato_base, candidato_estatuto, 
                candidato_antecedentes, filiado_partido_quais, foi_candidato_quais,
                atual_anterior_eleito_quais, leu_manifesto, sexo, quer_ser_candidato, 
                filiado_partido, foi_candidato, atual_anterior_eleito, cargo_confianca, 
                voluntario, leu_estatuto, quem_abonou, quando_abonou, nome, email, fullname,
                filiaweb)
                (SELECT 
                    NEW.user_id as user_id,
                    NEW.birthday as birthday, 
                    NEW.nome_mae as nome_mae, 
                    NEW.nacionalidade as nacionalidade, 
                    NEW.cep as cep, 
                    NEW.numero as numero, 
                    NEW.complemento as complemento, 
                    NEW.endereco as endereco, 
                    NEW.bairro as bairro, 
                    NEW.cidade as cidade, 
                    NEW.uf as uf, 
                    NEW.telefone_residencial as telefone_residencial, 
                    NEW.telefone_celular as telefone_celular, 
                    NEW.telefone_comercial as telefone_comercial, 
                    NEW.contribuicao as contribuicao, 
                    NEW.titulo_eleitoral as titulo_eleitoral, 
                    NEW.zona_eleitoral as zona_eleitoral, 
                    NEW.secao_eleitoral as secao_eleitoral, 
                    NEW.cpf as cpf, 
                    NEW.ativista as ativista, 
                    NEW.escolaridade as escolaridade, 
                    NEW.local_trabalho as local_trabalho, 
                    now() as created_at, 
                    NEW.filiado_outros_quais as filiado_outros_quais, 
                    NEW.cadidatura_quais as cadidatura_quais, 
                    NEW.cargo_eletivo_quais as cargo_eletivo_quais, 
                    NEW.cargo_confianca_quais as cargo_confianca_quais, 
                    NEW.ativista_quais as ativista_quais, 
                    NEW.status as status, 
                    NEW.candidato_cargo as candidato_cargo,
                    NEW.candidato_motivo as candidato_motivo, 
                    NEW.candidato_base as candidato_base, 
                    NEW.candidato_estatuto as candidato_estatuto, 
                    NEW.candidato_antecedentes as candidato_antecedentes, 
                    NEW.filiado_partido_quais as filiado_partido_quais, 
                    NEW.foi_candidato_quais as foi_candidato_quais,
                    NEW.atual_anterior_eleito_quais as atual_anterior_eleito_quais, 
                    NEW.leu_manifesto as leu_manifesto, 
                    NEW.sexo as sexo, 
                    NEW.quer_ser_candidato as quer_ser_candidato, 
                    NEW.filiado_partido as filiado_partido, 
                    NEW.foi_candidato as foi_candidato, 
                    NEW.atual_anterior_eleito as atual_anterior_eleito, 
                    NEW.cargo_confianca as cargo_confianca, 
                    NEW.voluntario as voluntario, 
                    NEW.leu_estatuto as leu_estatuto, 
                    NEW.quem_abonou as quem_abonou, 
                    NEW.quando_abonou as quando_abonou, 
                    NEW.nome as nome, 
                    NEW.email as email, 
                    NEW.fullname as fullname,
                    NEW.filiaweb as filiaweb)
            RETURNING user_id INTO v_filiado_id;

            SELECT * FROM "1".filiados WHERE user_id = v_filiado_id INTO v_filiado;

            RETURN v_filiado;
        END;
    $$;

    CREATE TRIGGER api_insert_filiado INSTEAD OF INSERT ON "1".filiados FOR EACH ROW EXECUTE PROCEDURE public.api_insert_filiado();

    GRANT INSERT ON "1".filiados TO web_user;
    GRANT INSERT ON rs.afiliados TO web_user;
-- +goose StatementEnd

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

-- +goose StatementBegin
DROP FUNCTION public.api_insert_filiado() CASCADE;

REVOKE INSERT ON "1".filiados FROM web_user;
REVOKE INSERT ON rs.afiliados FROM web_user;
-- +goose StatementEnd

