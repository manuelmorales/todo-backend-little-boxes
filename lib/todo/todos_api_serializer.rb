module Todo
  class TodosApiSerializer
    def dump(todo)
      {
        id: todo.id,
        title: todo.title,
        completed: todo.completed,
        order: todo.order,
      }
    end
  end
end
