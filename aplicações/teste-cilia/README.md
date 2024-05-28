## Gerar aplicação Ruby on Rails para desenvolvimento
<br />

Para construir a imagem do docker, execute o seguinte comando.
```bash
  $ docker compose build
```

Agora vamos inicializar o aplicativo:
```bash
  $ docker compose up
```

Inicialmente o container não tem banco de dados criado, então oara criar o banco de dados execute:
```bash
  $ docker compose run web rake db:create db:migrate
```

Pronto! Basta acessar o [localhost](http://localhost:3001/) na porta 3001.
<br/>

### Observações
As tecnologias usadas nesse projeto estão nas seuintes versões (para saber das bibliotecas, acesse o arquivo `Gemfile`): 

- Nome da aplicação: `teste-cilia`
- Porta para WEB: `3001`
- Versão do ruby: `2.7`
- Versão do Rails: `5.2`
- Banco de dados: `PostgreSQL`
