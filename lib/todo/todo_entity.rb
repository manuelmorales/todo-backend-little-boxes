module Todo
  class TodoEntity
    attr_accessor :title, :completed

    def initialize(attrs = {})
      attrs.each do |key, value|
        send "#{key}=", value
      end
    end
  end
end
