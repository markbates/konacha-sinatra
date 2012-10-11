require "konacha-sinatra/version"

require 'ostruct'
require 'active_support'
require 'active_support/core_ext'
require 'capybara/poltergeist'
require 'sprockets'
require 'rack'

require "konacha-sinatra/rails/engine"

require "konacha"
require 'sinatra/base'

load File.expand_path(File.join('tasks', 'konacha.rake'), File.dirname(__FILE__))

# Load Konacha models and rake tasks:
$:.each do |path|
  if (/\/konacha\-[\.\d]*\//).match(path)
    $konacha_lib_path = path
    Dir.glob(File.join(path, '..', 'app', 'models', '**', '*.rb')).each do |m|
      require m
    end
    Dir.glob(File.join(path, 'tasks', '*.rake')) do |m|
      load m
    end
    break
  end
end

require "konacha-sinatra/konacha/konacha"
require "konacha-sinatra/konacha/specs_controller"
require "konacha-sinatra/konacha/engine"

module Konacha

  def self.load!
    options = Konacha::Engine.config.konacha
    options.spec_dir    ||= "spec/javascripts"
    options.port        ||= 3500
    options.driver      ||= :selenium
    options.assets_path ||= 'assets'
    yield options if block_given?
    options.application ||= Konacha::Engine.application
  end
  
end