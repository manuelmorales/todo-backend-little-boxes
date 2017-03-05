module Todo
  class TodoEntity
    attr_accessor :title, :completed, :id, :order

    def initialize(attrs = {})
      @completed = false
      self.attributes = attrs
    end

    def attributes=(attrs)
      attrs.each do |key, value|
        method(:"#{key}=").call value
      end
    end
  end
end
