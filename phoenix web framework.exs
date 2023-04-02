defmodule MyApp.Router do
  use Phoenix.Router

  scope "/", MyApp do
    pipe_through :browser

    get "/", PageController, :index
    resources "/posts", PostController
  end
end

defmodule MyApp.PostController do
  use MyApp.Web, :controller

  def index(conn, _params) do
    posts = MyApp.Post.all()
    render(conn, "index.html", posts: posts)
  end
end
