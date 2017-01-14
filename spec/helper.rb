require 'rubygems'
require 'rspec'
require 'pry'

$LOAD_PATH.unshift File.expand_path('lib')
require 'todo'
include Todo

RSpec.configure do |c|
  c.color = true
  c.tty = true
  c.formatter = :documentation
  c.disable_monkey_patching!
end
