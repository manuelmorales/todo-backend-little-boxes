require 'json'

module Todo
  class ListTodosEndpoint
    include LittleBoxes::Configurable

    dependency :repo
    dependency :serializer

    def call(env)
      all = repo.find_all

      [
        200,
        {'Content-Type' => 'application/json'},
        [all.map{ |t| serializer.dump(t) }.to_json]
      ]
    end
  end
end
