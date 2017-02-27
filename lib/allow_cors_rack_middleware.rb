module Todo
  class AllowCorsRackMiddleware
    BLANK_APP = -> (_) { [200, {'Content-Type' => 'text/plain'}, ['']] }

    def initialize(app = BLANK_APP)
      @app = app
    end

    def call(env)
      @app.call(env).tap do |resp|
        resp[1]['Access-Control-Allow-Headers'] = resp[1].keys.join(", ")
        resp[1]['Access-Control-Allow-Origin'] = '*'
      end
    end
  end
end
