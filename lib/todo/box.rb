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
  end
end
