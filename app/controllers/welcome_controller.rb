class WelcomeController < ApplicationController
  def index
    set_meta_tags title: 'Welcome'
    set_meta_tags description: 'This is my blog, please click something.'
    if request.headers['X-PJAX']
      render :layout => 'pjax'
    end
  end
end
