module Todo
  TodosHanamiRouter = lambda do |box|
    require 'hanami/router'

    Hanami::Router.new do
      get '/todos', to: box.endpoints.list
    end
  end
end
