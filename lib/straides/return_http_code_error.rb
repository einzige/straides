module Straides

  # A custom exception for bubbling up HTTP errors and showing the corresponding error pages.
  class ReturnHttpCodeError < RuntimeError
    attr_accessor :render_options

    # @constructor
    #
    # @param [ Hash ] render_options
    def initialize(render_options = {})
      @render_options = render_options
    end

    # Checks if error options contain any templates assigned to it.
    #
    # @return [ true, false ]
    def has_template?
      (render_options.keys & [:file, :text, :json, :nothing]).any?
    end
  end
end
