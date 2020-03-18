class Namespaces::ShowUserPage < ShowLayout
  needs user : User
  needs current_user : User | Nil
  needs repositories : RepositoryQuery
  quick_def page_title, @user.username
  quick_def page_title_template, render_template("namespaces/show_user_info.html.ecr")

  def content
    render_template "namespaces/user_repositories.html.ecr"
  end
end
