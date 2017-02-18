module Todo
  class TodoEntity
    attr_accessor :title, :completed, :id

    def initialize(attrs = {})
      attrs.each do |key, value|
        send "#{key}=", value
      end
    end
  end
end
