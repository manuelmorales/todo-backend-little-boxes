require 'json'

module Todo
  class ShowTodoEndpoint
    include LittleBoxes::Configurable

    dependency :repo
    dependency :serialize

    def call(env)
      id = env['router.params'][:id]

      if todo = repo.find(id)
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
