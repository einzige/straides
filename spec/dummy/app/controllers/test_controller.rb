class TestController < ApplicationController

  def works
    render :text => 'works!'
  end
  
  def error_404
    error 404
  end
  
  def error_400
    error 400, :text => 'This was a bad request.'
  end
  
end
