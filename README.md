# ElixirRestApi

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

`/api/users/signup` and `/api/users/signin` are available.

On both signup and signin you should send a json payload containing the email and the password.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
  
NOTE: You probably don't have a postgres server set up so here you go, paste this into a file named docker-compose.yml and execute `docker-compose up -d`. Attach to the container and create a db named `elixir_rest_api` if you get errors saying no such db when trying to exec migrations or run the app.

```
version: '3'
services:
  mydb:
    image: postgres
    environment:
      POSTGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
      POSTGRES_DB: elixir_rest_api
    volumes:
    - db-data:/var/lib/postgresql/data
    ports:
    - 5432:5432

volumes:
  db-data:
    driver: local
