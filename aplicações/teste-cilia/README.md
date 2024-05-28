## Cilia - Projeto de Avaliação - Desenvolvedor Ruby on Rails

O projeto foi desenvolvido a partir de uma imagem [Docker](https://docs.docker.com/engine/install/ubuntu/), então este seria o único requisito para executá-lo.

Primeiro, vamos construir a imagem executando o seguinte comando:
```bash
$ docker compose build
```

Após isso, podemos inicializar o aplicativo. Este comando também iniciará o servidor Rails:
```bash
$ docker compose up
```

Com os containers do web e banco de dados rodando, precisamos criar o banco de dados, executar as migrações e carregar os dados iniciais. Execute:
```bash
$ docker compose run web rake db:create db:migrate db:seed
```

O comando anterior gerou alguns dados básicos, incluindo um usuário admin, responsável por cadastrar produtos e gerenciar vendas, e um cliente. Ambos podem ser acessados com a senha `123456` e os emails `admin@email.com` e `cliente1@email.com`. Além disso, dois produtos foram cadastrados para facilitar a primeira compra.

Pronto! Basta acessar o [localhost](http://localhost:3001/) na porta 3001 e navegar pelo sistema.

Para rodar os testes unitários basta entrar no container web:
```
$ docker exec -it teste-cilia-web-1 bash
$ bundle exec rspec
```

### Permissões

|          | Venda                                                   | Produto | Cliente                                    | Endereço | Telefone |
|----------|---------------------------------------------------------|---------|--------------------------------------------|----------|----------|
| **Admin**| listar, visualizar, cancelar, finalizar                 | todas   | listar, ativar                             | nenhuma  | nenhuma  |
| **Cliente**| listar, visualizar, cancelar, cadastrar, editar       | nenhuma | visualizar, cadastrar, editar, desativar   | todas    | todas    |

### Observações

As tecnologias usadas nesse projeto estão nas seguintes versões (para detalhes das bibliotecas, acesse o arquivo `Gemfile`):

- Nome da aplicação: `teste-cilia`
- Porta para WEB: `3001`
- Versão do Ruby: `2.7`
- Versão do Rails: `5.2`
- Banco de dados: `PostgreSQL`

---

### Considerações pessoais

Aqui estão algumas considerações pessoais que poderiam melhorar o projeto, mas não foram implementadas devido ao prazo estipulado para entrega:

- Para melhorar o uso da informação de preço, utilizaria a `gem money`, que facilita a conversão de moedas e possui alguns helpers para formatação de preço.
- Utilizar a `gem pundit` para gerenciar a autorização para níveis diferentes de usuários.
- Em um cenário de produção, armazenaria as imagens no S3.
- Incluir testes unitários para os filtros de cliente, produtos e vendas (app/finders/).
- Nem todas as traduções possíveis foram feitas.
- Apenas o controller de `sales` foi testado com `assigns`. Seria útil testar os demais controllers com essa abordagem.
- Como utilizei duas autenticações (_admin_ e _customer_), a autenticação no mesmo controller ficou complexa. Eu usaria `namespace` (_Admin::Sales_ e _Admin::Customers_) ou até _scopes_ com um `User` gerenciando as permissões com `pundit` e `policies`.
