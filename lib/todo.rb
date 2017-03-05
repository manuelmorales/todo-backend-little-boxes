$LOAD_PATH << File.dirname(__FILE__)
require 'little_boxes'

module Todo
  autoload :VERSION, 'todo/version'

  Dir.glob('lib/todo/*.rb').each do |path|
    name = File.basename(path, '.rb')
    constant = name.split('_').collect(&:capitalize).join
    autoload constant, "todo/#{name}"
  end
end
