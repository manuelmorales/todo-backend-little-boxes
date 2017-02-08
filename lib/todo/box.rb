require 'little_boxes'

module Todo
  class Box
    include LittleBoxes::Box

    let(:rack_app) { |box| box.todos.rack_app }

    box(:todos) do
      let(:entity) { TodoEntity }

      let(:repo) { TodosRepo.new }.then do |repo, box|
        repo.new_todo = box.entity.method(:new)
      end

      let(:rack_app, &TodosHanamiRouter)

      box :endpoints do
        letc(:list) { ListTodosEndpoint.new }
      end
    end
  end
end
