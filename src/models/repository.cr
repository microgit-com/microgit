class Repository < BaseModel
  table do
    column name : String
    column description : String?
    column slug : String
    column privated : Bool
    belongs_to user : User?
    belongs_to team : Team?
    belongs_to created_by : User
    has_many issues : Issue
    # polymorphic owner, associations: [:user, :team]
  end

  def namespace
    if user
      user.try { |u| u.namespace! }
    elsif team
      team.try { |t| t.namespace! }
    else
      nil
    end
  end

  def namespace_slug
    namespace.try { |n| n.slug } || ""
  end

  def git_url
    ["", namespace.try { |n| n.slug }, "#{slug}.git"].join("/")
  end

  def git_path
    path = [ENV["project_root"]? || FileUtils.pwd, "repositories", namespace.try { |n| n.slug }, "#{slug}.git"]
    path.join('/')
  end

  def remove_data
    FileUtils.rm_rf(git_path)
  end
end
