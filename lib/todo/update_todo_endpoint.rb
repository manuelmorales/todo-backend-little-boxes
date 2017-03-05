module Todo
  class UpdateTodoEndpoint
    include LittleBoxes::Configurable

    dependency :repo
    dependency :entity
    dependency :serialize

    def call(env)
      params = JSON.parse(env['rack.input'].read)
      id = env['router.params'][:id]

      if todo = repo.find(id)
        todo.attributes = params
        repo.save todo

        [
          200,
          {'Content-Type' => 'application/json'},
          [serialize.(todo).to_json]
        ]
      else
        [404, {}, []]
      end
    end
  end
end
