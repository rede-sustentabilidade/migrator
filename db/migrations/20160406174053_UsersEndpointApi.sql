
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
create extension if not exists pgcrypto;

create or replace view "1".users as
       select
        id,
        username,
        ''::text as password
        from rs.users;

GRANT SELECT ON "1".users TO web_user, admin;
GRANT INSERT ON "1".users TO web_user, admin;
GRANT INSERT ON rs.users TO web_user, admin;
GRANT INSERT ON users TO web_user, admin;
GRANT USAGE ON SEQUENCE rs.users_id_seq TO web_user, admin;


CREATE OR REPLACE FUNCTION insert_api_users() RETURNS trigger 
       LANGUAGE plpgsql
       AS $$
          DECLARE
            v_user "1".users;
          BEGIN
            INSERT INTO rs.users (username, password) VALUES
                   (NEW.username, crypt(NEW.password, gen_salt('bf')));

            SELECT * FROM "1".users WHERE username = NEW.username INTO v_user;

            RETURN v_user; 
          END;
       $$;

CREATE TRIGGER insert_api_users INSTEAD OF INSERT ON "1".users FOR EACH ROW EXECUTE PROCEDURE public.insert_api_users();
-- +goose StatementEnd

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

-- +goose StatementBegin
DROP FUNCTION insert_api_users() CASCADE;
DROP VIEW "1".users;
-- +goose StatementEnd
