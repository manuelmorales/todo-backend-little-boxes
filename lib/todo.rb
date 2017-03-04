$LOAD_PATH << File.dirname(__FILE__)

module Todo
  autoload :VERSION, 'todo/version'
  autoload :Cli, 'todo/cli'
  autoload :Box, 'todo/box'
  autoload :TodoEntity, 'todo/todo_entity'
  autoload :TodosRepo, 'todo/todos_repo'
  autoload :TodosApi, 'todo/todos_api'
  autoload :ListTodosEndpoint, 'todo/list_todos_endpoint'
  autoload :CreateTodoEndpoint, 'todo/create_todo_endpoint'
  autoload :DeleteTodoEndpoint, 'todo/delete_todo_endpoint'
  autoload :DeleteAllTodosEndpoint, 'todo/delete_all_todos_endpoint'
  autoload :TodosHanamiRouter, 'todo/todos_hanami_router'
  autoload :AllowCorsRackMiddleware, 'allow_cors_rack_middleware'
end
