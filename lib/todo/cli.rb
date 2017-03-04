require 'thor'

module Todo
  class Cli < Thor
    desc 'test', 'Runs the test suite'
    def test(*args)
      args = ['spec'] if args.empty?
      require 'rspec'
      exit(RSpec::Core::Runner.run(args))
    end

    desc 'start', 'Starts the Puma and any other required thread'
    def start(*args)
      box.app.start
    end

    private

    def box
      @box ||= Box.new
    end
  end
end
