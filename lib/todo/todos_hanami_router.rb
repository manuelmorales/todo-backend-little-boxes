module Todo
  TodosHanamiRouter = lambda do |box|
    require 'hanami/router'

    Hanami::Router.new do
      get '/todos', to: box.endpoints.list
      get '/todos/:id', to: box.endpoints.show
      post '/todos', to: box.endpoints.create
      delete '/todos/:id', to: box.endpoints.delete
      delete '/todos', to: box.endpoints.delete_all
      options '/*', to: box.allow_cors_middleware.new
    end
  end
end
