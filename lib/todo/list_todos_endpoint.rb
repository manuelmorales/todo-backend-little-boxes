module Todo
  class ListTodosEndpoint
    include LittleBoxes::Configurable

    dependency :repo

    def call(env)
      all = repo.find_all

      [
        200,
        {'Content-Type' => 'application/json'},
        [all.map{ |t| {title: t.title, completed: t.completed} }.to_json]
      ]
    end
  end
end
