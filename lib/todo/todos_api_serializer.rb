module Todo
  class TodosApiSerializer
    include LittleBoxes::Configurable

    dependency :todo_path

    def call(todo)
      {
        id: todo.id,
        title: todo.title,
        completed: todo.completed,
        order: todo.order,
        url: todo_path.(todo),
      }
    end
  end
end
