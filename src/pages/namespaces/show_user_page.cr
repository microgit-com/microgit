class Namespaces::ShowUserPage < MainLayout
  needs user : User
  quick_def page_title, @user.username

  def content
    render_template "namespaces/show_user.html.ecr"
  end
end
