require "sinatra"
require "sinatra/contrib"
require "sinatra/reloader" if development?
require "pg"
require "sinatra/cookies"
require_relative "controllers/frames_controller.rb"
require_relative "models/frame.rb"


use Rack::MethodOverride
run FramesController
