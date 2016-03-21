## Install

Need to use (goose)[https://bitbucket.org/liamstask/goose] to handle with migrations, basicaly ```go get bitbucket.org/liamstask/goose/cmd/goose```

Edit the ```db/dbconf.yml.sample``` to ```db/dbconf.yml``` and change the database configurations

if you arealdy have the first struct of database, need to insert first version at versions table:

```sql
insert into goose_db_version (version_id, is_applied) values (20151211161856, true)
```

## Usage

See at (goose page)[https://bitbucket.org/liamstask/goose]] for more details

## Start Server Postgrest

```bash
postgrest postgres://postgrest@127.0.0.1/rs-api-new -a anon  -p 3333 -j chave_jwt_token -s 1
```
