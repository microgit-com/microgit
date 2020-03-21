class Namespaces::MembersPage < ShowLayout
  needs team : Team
  needs current_user : User | Nil
  needs members : Array(User)
  quick_def page_title, @team.name
  #quick_def page_title_template, render_template("namespaces/show_user_info.html.ecr")

  def content
    render_template "namespaces/team_members.html.ecr"
  end
end
