# Straides

Better HTTP STatus coDES for RAIls!

Straides provides a convenient and more consistent way for handling error conditions 
in controllers.

Straides makes it possible, for example, to abort execution of a request in a before_filter.


# Usage

    # Stop controller execution and return the request with the given HTTP error.
    error 404 unless [condition]
    
    # Shorter version, integrated into loading for example a user object.
    user = User.find_by_username(params[:id]) || error 401

    
## Customizing the response

Straides returns reasonable default responses dependent on the request format.

* If the request returns HTML, it renders `public/[error code].html`, similar to what Rails does.
* If the request returns JSON, it leaves the response body empty by default.

These behaviors can be overridden by providing the call to `error` with the same parameters 
as you would give to [render](http://apidock.com/rails/ActionController/Base/render) in Rails.

    # Provide a custom error message in the response body.
    error 401, :text => 'Please log in first.'
    
    # Render a different file in the response body.
    error 404, :file => 'public/custom_404.html'
    
    # Render a custom JSON response.
    error 401, :json => { :code => 401, :message => 'Please log in first.' }
