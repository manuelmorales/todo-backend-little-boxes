module Todo
  class DeleteTodoEndpoint
    include LittleBoxes::Configurable

    dependency :repo

    def call(env)
      id = env['PATH_INFO'].split('/').last.to_i
      repo.delete id

      [200, {}, []]
    end
  end
end
