require 'grape'
require 'little_boxes'

module Todo
  class TodosApi < Grape::API
    include LittleBoxes::Dependant

    class_dependency :repo

    format :json

    helpers do
      def repo
        options[:for].repo
      end
    end

    get '/todos' do
      repo.all
    end
  end
end
