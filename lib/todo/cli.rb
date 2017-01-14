require 'thor'

module Todo
  class Cli < Thor
    desc 'test', 'Run the test suite'
    def test(*args)
      args = ['spec'] if args.empty?
      require 'rspec'
      exit(RSpec::Core::Runner.run(args))
    end
  end
end
