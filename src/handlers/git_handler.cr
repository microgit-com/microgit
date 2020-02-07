class HTTP::GitHandler
  include HTTP::Handler

  def call(context)
    logger = Logger.new(STDOUT)
    logger.info "path: #{context.request.path}"
    if /[-\/\w\.]+\.git/.match(context.request.path)

      logger.info "headers: #{context.request.headers}"
      if context.request.headers.has_key?("Authorization")
        _, enc = context.request.headers["Authorization"].split
        username, password = Base64.decode_string(enc).split(":")
        if authorized?(username, password)
          context.request.headers.delete("Authorization")
          git = GitServer.new(context)
          git.call
        end
      end
      context.response.respond_with_status(HTTP::Status.new(403), "Forbidden")
    else
      call_next(context)
    end
  end

  private def authorized?(username, password)
    SignInUserGit.new(Avram::Params.new({"username" => username, "password" => password})).submit do |operation, authenticated_user|
      return true if authenticated_user
      return false unless authenticated_user
    end
  end

end
