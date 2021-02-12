## Executar aplicação com doker

```
  $ docker-compose build
  $ docker-compose up
```

## Popular banco de dados

Irá gerar dados aleatórios a partir da GEM Faker

```
  rake db:create db:migrate db:seed utils:seed
```