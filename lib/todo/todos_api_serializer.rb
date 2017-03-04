module Todo
  class TodosApiSerializer
    include LittleBoxes::Configurable

    dependency :todo_url

    def call(todo)
      {
        id: todo.id,
        title: todo.title,
        completed: todo.completed,
        order: todo.order,
        url: todo_url.(todo),
      }
    end
  end
end
