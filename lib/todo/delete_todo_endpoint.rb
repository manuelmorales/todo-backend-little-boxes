require 'little_boxes'

module Todo
  class DeleteTodoEndpoint
    include LittleBoxes::Configurable

    dependency :repo

    def call(env)
      id = env['router.params'][:id]

      if todo = repo.find(id)
        repo.delete todo

        [200, {}, []]
      else
        [404, {}, []]
      end
    end
  end
end
