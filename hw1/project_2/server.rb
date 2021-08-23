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

class TimeLoggingMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    before = Time.now.to_i
    status, header, body = @app.call(env)
    after = Time.now.to_i

    body << "Done at #{after - before} seconds."
    [status, header, body]
  end
end

Rack::Handler::Thin.run(
  TimeLoggingMiddleware.new(TestApp.new)
)
