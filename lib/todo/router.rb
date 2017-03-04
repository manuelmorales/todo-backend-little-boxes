module Todo
  class Router
    include LittleBoxes::Configurable

    dependency :server_url

    def todo_url(todo)
      "#{server_url}/todos/#{todo.id}"
    end
  end
end
