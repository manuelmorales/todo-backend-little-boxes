require 'little_boxes'

module Todo
  class DeleteAllTodosEndpoint
    include LittleBoxes::Configurable

    dependency :repo

    def call(env)
      repo.delete_all

      [200, {}, []]
    end
  end
end
