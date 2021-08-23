require 'rack'
require 'thin'

class TestApp
  def call(env)
    sleep(3)
    [
      200,
      { 'Content-Type' => 'text/html' },
      ['<h1>Hello</h1>']
    ]
  end
end

class MyMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    
    status, header, body = @app.call(env)
    
    body << "Current time is #{Time.now}"
    [status, header, body]
  end
end

Rack::Handler::Thin.run(
  MyMiddleware.new(TestApp.new)
)
