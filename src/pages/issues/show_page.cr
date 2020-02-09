class Repositories::Issues::ShowPage < MainLayout
  needs issue : Issue
  needs repository : Repository

  def content
    h1 @issue.name
    render_issue_fields
  end

  def render_issue_fields
    ul do
      li do
        text "name: "
        strong @issue.name.to_s
      end
      li do
        text "description: "
        strong @issue.description.to_s
      end
      li do
        text "author: "
        strong @issue.author.to_s
      end
      li do
        text "assignee: "
        strong @issue.assignee.to_s
      end
    end
  end
end
