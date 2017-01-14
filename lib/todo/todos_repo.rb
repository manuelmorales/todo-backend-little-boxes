require 'little_boxes'

module Todo
  class TodosRepo
    include LittleBoxes::Configurable

    dependency :store

    def save(todo)
      todo.id = SecureRandom.uuid

      store[todo.id] = {
        title: todo.title,
        completed: todo.completed,
      }
    end

    def find(id)
      if data = store[id]
        OpenStruct.new data
      end
    end
  end
end
