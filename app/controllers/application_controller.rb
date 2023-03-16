class ApplicationController < ActionController::Base
   
  before_action :authenticate
  def authenticate
    if !user_signed_in? && (params[:action]!="new" && params[:controller]!="devise")&& (params[:action]!="create" && params[:controller]!="devise")
        
      redirect_to new_user_session_path
    end
  end
    
end
