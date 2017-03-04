require 'json'

module Todo
  class ListTodosEndpoint
    include LittleBoxes::Configurable

    dependency :repo
    dependency :serialize

    def call(env)
      all = repo.find_all

      [
        200,
        {'Content-Type' => 'application/json'},
        [all.map{ |t| serialize.(t) }.to_json]
      ]
    end
  end
end
