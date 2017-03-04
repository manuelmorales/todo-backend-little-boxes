module Todo
  class TodoEntity
    attr_accessor :title, :completed, :id, :order

    def initialize(attrs = {})
      @completed = false

      attrs.each do |key, value|
        send "#{key}=", value
      end
    end
  end
end
