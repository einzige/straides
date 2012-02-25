require 'return_http_code_error'
require 'active_record'

class ApplicationController < ActionController::Base
  
  rescue_from(ReturnHttpCodeError) { |error| show_error(error) }

  
  protected

  # Makes the current action abort and return an HTTP error.
  def error status, render_options = {}
    render_options[:status] = status
    raise ReturnHttpCodeError, render_options
  end


  private
  
  # Outputs the given error to the client.
  def show_error error
    respond_to do |format|
      format.html do
        if (error.render_options.keys & [:file, :text, :json, :nothing]).empty?
          error.render_options[:file] = "public/#{error.render_options[:status]}.html"
        end
        render error.render_options
      end
      format.json do
        if (error.render_options.keys & [:file, :text, :json, :nothing]).empty?
          error.render_options[:text] = ''
        end
        render error.render_options
      end
    end
  end
end
