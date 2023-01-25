# Cityfood

## Preoject Scope & Features
- DB is using postgress
- Inital data is imported by api call to [json-api-data](https://data.sfgov.org/resource/jjew-r69b.json), which is initalized by [DB seed](./priv/repo/seeds.exs). This can also be refreshed by manually calling `DataFetcher.refresh_data()`.
- [Home page](http://localhost:4001/) is the list view of all food-trucks. 
  ![list-view-landing-page](./docs/list_view.jpg)
  - filters: cities, cold-truck or not, day-of-week
  - clear all
  - `map view`
  ![list-view-landing-page](./docs/map_view.jpg)
- Other genernic operations, view/edit/delete of cities & food-trucks. 


## Setup 
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4001`](http://localhost:4001) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
