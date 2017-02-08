require 'little_boxes'

module Todo
  class Box
    include LittleBoxes::Box

    box(:todos) do
      let(:entity) do
        Struct.new :description, :done
      end

      let(:repo) { TodosRepo.new }

      let(:api) { }
    end

    let(:rack_app) do |box|
      require 'hanami/router'

      Hanami::Router.new do
        get '/todos', to: -> (env) do
          all = box.todos.repo.find_all

          [
            200,
            {'Content-Type' => 'application/json'},
            [all.map{ |t| {title: t.title, completed: t.completed} }.to_json]
          ]
        end
      end
    end
  end
end
