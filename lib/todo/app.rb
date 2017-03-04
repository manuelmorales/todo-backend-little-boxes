module Todo
  class App
    include LittleBoxes::Configurable

    dependency :cfg

    def start
      require 'puma/cli'
      args = ['-p', cfg[:port].to_s]
      Puma::CLI.new(args).run
    end
  end
end
