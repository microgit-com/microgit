class Repository < BaseModel
  table do
    column name : String
    column description : String?
    column slug : String
    column privated : Bool
    belongs_to user : User
  end

  def git_url
    ["", user.slug, "#{slug}.git"].join("/")
  end

  def git_path
    path = [ENV["project_root"]? || FileUtils.pwd, "repositories", user.slug, "#{slug}.git"]
    path.join('/')
  end

  def remove_data
    FileUtils.rm_rf(git_path)
  end
end
