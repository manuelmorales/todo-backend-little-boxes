module Todo
  class Router
    include LittleBoxes::Configurable

    dependency :server_url
    dependency :allow_cors_middleware
    dependency :todos

    def todo_url(todo)
      "#{server_url}/todos/#{todo.id}"
    end

    def build_rack
      allow_cors_middleware.new(todos_router)
    end

    private

    def todos_router
      require 'hanami/router'

      Hanami::Router.new.tap do |r|
        r.get '/todos', to: todos.list
        r.get '/todos/:id', to: todos.show
        r.post '/todos', to: todos.create
        r.patch '/todos/:id', to: todos.update
        r.delete '/todos/:id', to: todos.delete
        r.delete '/todos', to: todos.delete_all
        r.options '/*', to: allow_cors_middleware.new
      end
    end
  end
end
