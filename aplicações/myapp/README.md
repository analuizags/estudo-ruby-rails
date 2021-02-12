## Gerar aplicação Ruby on Rails para desenvolvimento

Com os arquivos desse diretório na raiz onde será sua aplicação, gere o aplicativo esqueleto do Rails usando:

```bash
  $ docker-compose run --no-deps web rails new . --force --database=postgresql
```

Se estiver usando o Linux, utilize o comando a seguir para dar permissão aos arquivos da pasta da aplicação, porque eles são executados como usuário root.
```bash
  $ sudo chown -R $USER:$USER .
```

Agora que tem um novo Gemfile, precisa construir a imagem novamente. (Isso, e alterações no `Gemfile` ou no `Dockerfile`, devem ser as únicas vezes em que precisará reconstruir.) Execute o comando para isso.
```bash
  $ docker-compose build
```

É preciso alterar o banco de dados e o nome de usuário para alinhar com os padrões definidos pela `postgres` imagem. Substituindo o conteúdo de `config/database.yml` pelo seguinte:
```yml
  default: &default
    adapter: postgresql
    encoding: unicode
    host: db
    username: postgres
    password: password
    pool: 5

  development:
    <<: *default
    database: myapp_development


  test:
    <<: *default
    database: myapp_test
```

Para inicializar o aplicativo:
```bash
  $ docker-compose up
```

Para criar o banco de dados, em outro terminal, execute:
```bash
  $ docker-compose run web rake db:create
```
<br/>

### Observações 
Os arquivos e configuração aqui apresentadas estão com configurações genéricas que podem ser alteradas a depender da demanda. São elas: 

- Nome da aplicação: `myapp`. (Aconselha-se ainda, ter o nome da pasta raiz com o mesmo nome da sua aplicação.)
- Porta para WEB: `3001`
- Versão do ruby: `2.3`
- Versão do Rails: `4.2.5`
- Banco de dados: `PostgreSQL`

<br/>

---
Informações obtidas no site oficial do Docker na página de [Início rápido: Compose e Rails](https://docs.docker.com/compose/rails/).