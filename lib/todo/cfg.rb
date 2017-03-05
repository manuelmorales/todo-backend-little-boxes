require 'dotenv'

module Cfg
  extend self

  def load
    Dotenv.load unless ENV['RACK_ENV'] == 'production'

    {}.tap do |cfg|
      cfg[:url] = ENV['URL'] || 'http://localhost:9292'
      cfg[:port] = ENV['PORT'] || 9292
    end
  end
end
