class Repositories::Issues::IndexPage < MainLayout
  needs issues : IssueQuery
  needs repository : Repository
  quick_def page_title, "All"

  def content
    h1 "All Issues"
    render_issues
  end

  def render_issues
    ul do
      @issues.each do |issue|
        li do
          link issue.name, Show.with(@repository, issue)
        end
      end
    end
  end
end
