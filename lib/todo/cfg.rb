module Cfg
  extend self

  def load
    defaults.merge(options)
  end

  private

  def defaults
    { port: 9292, url: 'http://localhost:9292' }
  end

  def options
    if File.exist? path
      require 'yaml'
      YAML.load(File.read path)
    else
      {}
    end
  end

  def path
    File.expand_path '../../../config.yml', __FILE__
  end
end
