require 'little_boxes'

module Todo
  class Box
    include LittleBoxes::Box

    box(:todos) do
      let(:store) { Hash.new }

      let(:entity) do
        Struct.new :description, :done
      end
    end
  end
end
