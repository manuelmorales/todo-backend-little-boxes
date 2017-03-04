module Todo
  class AllowCorsRackMiddleware
    BLANK_APP = -> (_) { [200, {'Content-Type' => 'text/plain'}, ['']] }

    def initialize(app = BLANK_APP)
      @app = app
    end

    def call(env)
      resp = @app.call(env).dup
      resp[1] = headers = resp[1].dup

      headers = resp[1] = resp[1].dup

      if allow_headers = env['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']
        headers['Access-Control-Allow-Headers'] = allow_headers
      end

      if allow_methods = env['HTTP_ACCESS_CONTROL_REQUEST_METHOD']
        headers['Access-Control-Allow-Methods'] = allow_methods
      end

      headers['Access-Control-Allow-Origin'] = '*'

      resp
    end
  end
end
