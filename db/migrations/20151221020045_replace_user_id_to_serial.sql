
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

alter table rs.users drop column id;
alter table rs.oauth_access_tokens drop column user_id;
alter table rs.oauth_authorization_codes drop column user_id;
alter table rs.oauth_refresh_tokens drop column user_id;

alter table rs.users add column id serial primary key;
alter table rs.oauth_access_tokens add column user_id int;
alter table rs.oauth_authorization_codes add column user_id int;
alter table rs.oauth_refresh_tokens add column user_id int;

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

-- id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
-- user_id uuid NOT NULL,
