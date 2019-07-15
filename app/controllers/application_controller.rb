class ApplicationController < Sinatra::Base
  

  register Sinatra::ActiveRecordExtension

  configure do
  	set :views, "app/views"
    set :public_dir, "public"
    #enables sessions as per Sinatra's docs. Session_secret is meant to encript the session id so that users cannot create a fake session_id to hack into your site without logging in. 
    enable :sessions
    set :session_secret, "secret"
   # set :short_url_list, []
  end 
#----------------------------------------------------------------------
  # Renders the home or index page
  get '/' do
  #  byebug
    @page_address="/urls"

    erb :home  , layout: :'/layouts/my_layout'
  end
#------------------------------------------------------------------------

  post "/urls" do
   
  
   unless @url= Url.find_by(url:params["url"],user_id: session[:user_id])
    @url=Url.create(url:params["url"] ,click_count: 0,user_id: session[:user_id] )
   end
    @enter=true
    @error=@url.errors.messages[:url][0] +" :"+ params["url"] unless @url.valid?  
    @urls=Url.where(user_id:session[:user_id])
    @url_list=@urls
  #  byebug
   erb :home,layout: :'/layouts/my_layout' 
 
  
  end

#-----------------------------------------------------------------------------------

  #redirection
   get '/:url' do
   @url=Url.find_by(short_url:'<%= ENV['DATABASE_URL'] %>'+params["url"])
  # byebug
    unless @url.nil?
      @url.click_count += 1
      @url.save
    #  byebug 
      redirect @url.url
    else
      raise Sinatra::NotFound
    end
   end

#---------------------------------------------------------------------------------
  # Renders the sign up/registration page in app/views/registrations/signup.erb
  get '/registrations/signup' do
    erb :'/registrations/signup' , layout: :'/layouts/my_layout'
  end

  # Handles the POST request when user submits the Sign Up form. Get user info from the params hash, creates a new user, signs them in, redirects them. 
  post '/registrations' do
   user = User.new(name: params["name"], email: params["email"])
   #byebug
   user.password= params["password"]
   user.save
   session[:user_id] = user.id 
   redirect 'users/home'
  end
  
 # Renders the view page in app/views/sessions/login.erb
 get '/sessions/login' do
 # byebug
    unless session[:user_id]
    erb :'/sessions/login', layout: :'/layouts/my_layout'
    else
    redirect 'users/home'
    end
end


  # Handles the POST request when user submites the Log In form. Similar to above, but without the new user creation.
  post '/sessions' do
    user = User.find_by(email: params["email"])
   # byebug
    if user.password==params["password"]
    # unless user.nil?
    session[:user_id] = user.id
    redirect 'users/home' 
    else
      redirect 'sessions/login' 
    end
  end
#----------------------------------------------------------------------------------
  get '/users/new_url' do
    #byebug
    # users=User.includes(:url)
    @user=User.find_by(id:session[:user_id])
    @page_address="/user_urls"
    @url_list=@user.urls.last(3)
    erb :'/users/new_url',layout: :'/layouts/my_layout'
  end

  post '/user_urls' do
    unless @url= Url.find_by(url:params["url"],user_id: session[:user_id])
     @url=Url.create(url:params["url"] ,click_count: 0,user_id: session[:user_id] )
    end
    @error=@url.errors.messages[:url] unless @url.valid?  
    @user=User.find_by(id:session[:user_id])
    @url_list=@user.urls.last(3)
    erb :'/users/new_url',layout: :'/layouts/my_layout' 
 
end
#-----------------------------------------------------------------------------------------  

  get '/urls/update/:id' do
    #byebug
    @user=User.find_by(id:session[:user_id])
    @page_address='/urls/update'

    @url=Url.find_by(id:params["id"])
    @url_id=@url.id
    erb :'/users/update_url',layout: :'/layouts/my_layout'
  end

  
  post '/urls/update' do
    
    @user=User.find_by(id:session[:user_id])
    @url=@user.urls.find_by(id:params["url_id"])
    
    @url.url= params["url"]
    @url.save
   # byebug
    if @url.valid?  
    @url_list=@user.urls
    redirect'/users/index'
    else
    @error=@url.errors.messages[:url][0]+ " :"+ params["url"]
    erb :'/users/update_url',layout: :'/layouts/my_layout'
    end
 
  end
#------------------------------------------------------------------------------------------
 get "/urls/delete/:id" do
  url=Url.find_by(id:params["id"])
  byebug
  url.destroy
  @user=User.find_by(id:session[:user_id])
  @url_list=@user.urls
  erb :'/users/index',layout: :'/layouts/my_layout'
  end
#-------------------------------------------------------------------------------------------
  get '/users/index' do
 #  byebug
  @user=User.find_by(id:session[:user_id])
  @url_list=@user.urls
  erb :'/users/index',layout: :'/layouts/my_layout'
  end 
#-----------------------------------------------------------------------------------------------
  # Logs the user out by clearing the sessions hash.
  get '/sessions/logout' do
    session.clear
    redirect '/'
  end
  # Renders the user's individual home/account page. 
  get '/users/home' do
    @user = User.find(session[:user_id])
    erb :'/users/home', layout: :'/layouts/my_layout'
  end
  
end
