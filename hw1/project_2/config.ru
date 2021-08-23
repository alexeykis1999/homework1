require 'thin'

app = -> (env) do
  sleep(3)
  [
    200,
    { 'Content-Type' => 'text/html' },
    ['<h1>Hello</h1>']
  ]
end
# class TestApp
#   def call(env)
#     sleep(3)
#     [
#       200,
#       { 'Content-Type' => 'text/html' },
#       ['<h1>Hello</h1>']
#     ]
#   end
# end

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

use TimeLoggingMiddleware
run app
# TODO: 1) create 1 or 2 middlewares for app; 2) move app class and middlewares to separated files
