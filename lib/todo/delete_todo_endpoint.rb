require 'little_boxes'

module Todo
  class DeleteTodoEndpoint
    include LittleBoxes::Configurable

    dependency :repo

    def call(env)
      id = env['router.params'][:id]
      repo.delete id

      [200, {}, []]
    end
  end
end
