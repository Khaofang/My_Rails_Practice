class WelcomeController < ApplicationController
  def index
    if request.headers['X-PJAX']
      render :layout => false
    end
  end
end
