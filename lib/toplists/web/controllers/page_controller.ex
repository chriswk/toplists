defmodule Toplists.Web.PageController do
  use Toplists.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
