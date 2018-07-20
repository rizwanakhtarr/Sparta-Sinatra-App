class FramesController < Sinatra::Base
set :root, File.join(File.dirname(__FILE__), '..')
set :views, Proc.new { File.join(root, "views") }

configure :development do
  register Sinatra::Reloader
end

helpers Sinatra::Cookies

enable :sessions

# INDEX
  get "/" do
    unless cookies[:visited]
      @show_message = true

      response.set_cookie(:visited, :value => 1, :expires => Time.now + (10))
    end
    @frame = "All Frame posts"
    @frames = Frame.all
    erb :"frames/index"
  end

  # NEW
  get "/new" do
    @frame = Frame.new
    @frame.frame_id = ""
    erb :"frames/new"
  end

  # # SHOW
   get "/:frame_id" do
  #
   frame_id = params[:frame_id].to_i
  #
  #   if(!session[:posts])
  #     session[:posts] = []
  #   end
  #
  #   if(!session[:posts].include?(id))
  #     session[:posts].push(id)
  #   end
  #
  #
  #
  #   puts "the user has visited #{session[:posts]}"
  #
  @frame = Frame.find(frame_id)
  erb :"frames/show"
  #
  end
  #
  # # CREATE
  post "/" do
  frame = Frame.new

    frame.name = params[:name]
    frame.description = params[:description]
    frame.price = params[:price]
    frame.save

   redirect "/"
  end
  #
  # # EDIT
  get "/:frame_id/edit" do
    frame_id = params[:frame_id].to_i
    @frame = Frame.find(frame_id)
    erb :"frames/edit"
  #
   end
  #
  # # UPDATE
  put "/:frame_id" do
    frame_id = params[:frame_id].to_i
    frame = Frame.find(frame_id)
    frame.name = params[:name]
    frame.description = params[:description]
    frame.price = params[:price]
    frame.save

    redirect "/"
   end
  #
  # # DESTROY
  delete "/:frame_id" do
    frame_id = params[:frame_id].to_i
    Frame.destroy(frame_id)
    redirect "/"

  end


end
