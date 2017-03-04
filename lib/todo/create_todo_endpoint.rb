module Todo
  class CreateTodoEndpoint
    include LittleBoxes::Configurable

    dependency :repo
    dependency :entity

    def call(env)
      body_params = JSON.parse(env['rack.input'].read)
      todo = entity.new body_params
      repo.save todo

      [
        201,
        {'Content-Type' => 'application/json', 'Location' => "/todos/#{todo.id}"},
        [{title: todo.title, completed: todo.completed, order: todo.order}.to_json]
      ]
    end
  end
end
