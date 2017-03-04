module Todo
  class CreateTodoEndpoint
    include LittleBoxes::Configurable

    dependency :repo
    dependency :entity
    dependency :serialize

    def call(env)
      body_params = JSON.parse(env['rack.input'].read)
      todo = entity.new body_params
      repo.save todo

      [
        201,
        {'Content-Type' => 'application/json', 'Location' => "/todos/#{todo.id}"},
        [serialize.(todo).to_json]
      ]
    end
  end
end
