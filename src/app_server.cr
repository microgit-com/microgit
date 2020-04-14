class AppServer < Lucky::BaseAppServer
  def middleware : Array(HTTP::Handler)
    [
      Lucky::ForceSSLHandler.new,
      Lucky::HttpMethodOverrideHandler.new,
      Lucky::LogHandler.new,
      Lucky::SessionHandler.new,
      Lucky::FlashHandler.new,
      HTTP::GitHandler.new,
      Lucky::ErrorHandler.new(action: Errors::Show),
      Lucky::StaticFileHandler.new("./public", true, false),
      HTTP::FileGlobHandler.new,
      Lucky::RouteHandler.new,
      Lucky::RouteNotFoundHandler.new,
    ] of HTTP::Handler
  end

  def protocol
    "http"
  end

  def listen
    # Learn about bind_tcp: https://tinyurl.com/bind-tcp-docs
    server.bind_tcp(host, port, reuse_port: false)
    server.listen
  end
end
