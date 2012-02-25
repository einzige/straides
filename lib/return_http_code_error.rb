# A custom exception for bubbling up HTTP errors and showing the correspending error pages.
class ReturnHttpCodeError < RuntimeError
  attr_accessor :render_options

  def initialize render_options
    @render_options = render_options
  end
end
