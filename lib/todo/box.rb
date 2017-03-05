require 'little_boxes'

module Todo
  class Box
    include LittleBoxes::Box

    letc(:app) { App.new }
    let(:cfg) { Cfg.load }

    box(:rack) do
      letc(:router) { Router.new }.then do |router, box|
        router.server_url = box.cfg[:url]
        router.todos = box.todos.endpoints
      end

      let(:main) { |box| box.router.build_rack }
      let(:allow_cors_middleware) { AllowCorsRackMiddleware }
    end

    box(:todos) do
      let(:entity) { TodoEntity }

      let(:repo) { TodosRepo.new }.then do |repo, box|
        repo.new_todo = box.entity.method(:new)
      end

      box :endpoints do
        letc(:show) { ShowTodoEndpoint.new }
        letc(:list) { ListTodosEndpoint.new }
        letc(:create) { CreateTodoEndpoint.new }
        letc(:update) { UpdateTodoEndpoint.new }
        letc(:delete) { DeleteTodoEndpoint.new }
        letc(:delete_all) { DeleteAllTodosEndpoint.new }

        letc(:serialize) { TodosApiSerializer.new }
        let(:todo_url) { |box| box.rack.router.method(:todo_url) }
      end
    end
  end
end
