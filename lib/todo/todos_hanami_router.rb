module Todo
  TodosHanamiRouter = lambda do |box|
    require 'hanami/router'

    Hanami::Router.new do
      get '/todos', to: box.endpoints.list
      options '/*', to: box.allow_cors_middleware.new
    end
  end
end
