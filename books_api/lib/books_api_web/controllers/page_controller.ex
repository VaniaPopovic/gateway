defmodule BooksApiWeb.PageController do
  use BooksApiWeb, :controller

  def redirect_to_graphiql(conn, _params) do
    redirect(conn, to: "/api/graphiql")
  end
end
