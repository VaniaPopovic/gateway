defmodule BooksApiWeb.Router do
  use BooksApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
      schema: BooksApiWeb.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: BooksApiWeb.Schema
  end

  # Add a catch-all route to redirect root to GraphiQL
  get "/", BooksApiWeb.PageController, :redirect_to_graphiql
end
