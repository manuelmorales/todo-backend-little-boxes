$LOAD_PATH << File.dirname(__FILE__)

module Todo
  autoload :Cli, 'todo/cli'
  autoload :Box, 'todo/box'
end
