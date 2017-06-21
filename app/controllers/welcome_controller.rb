class WelcomeController < ApplicationController
  def index
    @title = 'Welcome'
    @description = 'This is my blog, please click something.'
    if request.headers['X-PJAX']
      render :layout => 'pjax'
    end
  end
end
