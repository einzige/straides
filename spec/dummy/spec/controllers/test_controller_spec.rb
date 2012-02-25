require 'spec_helper'

describe TestController do

  it 'works' do
    get :works
    response.should be_success
    response.body.should == 'works!'
  end
  
  it 'can throw a 404 error' do
    get :error_404
    response.code.should == '404'
  end
  
  it 'can throw custom errors with custom bodies' do
    get :error_400
    response.code.should == '400'
    response.body.should == 'This was a bad request.'
  end
end
