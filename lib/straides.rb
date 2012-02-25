require 'straides/return_http_code_error'
require 'straides/version'

module Straides
  def self.included(base)
    class << base
      rescue_from ReturnHttpCodeError, &show_error

      protected

      # Makes the current action abort and return an HTTP error.
      #
      # @param [ Integer ] status
      # @param [ Hash ] render_options
      def error(status, render_options = {})
        render_options[:status] = status
        raise ReturnHttpCodeError, render_options
      end

      private

      # Outputs the given error to the client.
      #
      # @param [ Straides::ReturnHttpCodeError ] error
      def show_error error
        respond_to do |format|
          if (error.render_options.keys & [:file, :text, :json, :nothing]).empty?
            format.json do
              error.render_options[:text] = '' # NOTE(SZ): :nothing => true?
            end
            format.html do
              error.render_options[:file] = "public/#{error.render_options[:status]}.html"
            end
          end
          render error.render_options
        end
      end
    end
  end
end
