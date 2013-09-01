class SessionsController < ApplicationController

  def new
    #logger.debug "params: #{params.inspect}"
    #services = ['youtube', 'tumblr', 'google_oauth2', 'twitter', 'github', 'facebook', 'vimeo'] # TODO extract from OmniAuth.config
    #links = services.sort.map{|service| "<li style='margin: 15px;'><a href='/auth/#{service}'>#{service}</a></li>" }
    #render :text => "Authenticate with: <ul style='font-size: 20pt;'>#{links.join}</ul>", :layout => true
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
    #render :text => "<pre>"+request.env["omniauth.auth"].to_yaml+"</pre>"
  end

  def failure
    flash[:notice] = 'Oops! Login failure!'
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
