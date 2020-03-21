class LuckyForbiddenError < Lucky::Error
  include Lucky::RenderableError

  getter context

  def initialize(@context : HTTP::Server::Context)
    super "Forbidden"
  end

  def renderable_status : Int32
    403
  end

  def renderable_message : String
    "You have no access to this. Sorry!"
  end
end
