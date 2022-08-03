defmodule BusiApiWeb.Router do
  use BusiApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BusiApiWeb do
    pipe_through :api
    post "/users/signup", UserController, :create
    post "/users/signin", UserController, :signin
  end

  pipeline :auth do
    plug BusiApiWeb.Auth.Pipeline
  end

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", BusiApiWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end

end
