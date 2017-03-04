require 'little_boxes'

module Todo
  class TodosRepo
    include LittleBoxes::Configurable

    dependency(:store) { {} }
    dependency(:new_todo) { OpenStruct.method(:new) }

    def save(todo)
      todo.id = SecureRandom.uuid

      store[todo.id] = {
        title: todo.title,
        completed: todo.completed,
        order: todo.order,
      }
    end

    def find(id)
      if data = store[id]
        new_todo.(data)
      end
    end

    def find_all
      store.values.map(&new_todo)
    end

    def delete(id)
      store.delete(id)
    end

    def delete_all
      store.clear
    end
  end
end
