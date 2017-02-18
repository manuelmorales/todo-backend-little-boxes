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

      box(:racks) do
        let(:todos, &TodosHanamiRouter)
        let(:main) { |b| AllowCorsRackMiddleware.new(b.todos) }
        let(:allow_cors_middleware) { AllowCorsRackMiddleware }
      end

      let(:rack_app) { |b| b.racks.main }

      box :endpoints do
        letc(:list) { ListTodosEndpoint.new }
        letc(:create) { CreateTodoEndpoint.new }
      end
    end
  end
end
