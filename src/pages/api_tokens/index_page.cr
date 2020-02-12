class ApiTokens::IndexPage < MainLayout
  needs api_tokens : ApiTokenQuery
  quick_def page_title, "All"

  def content
    render_template "api_tokens/index.html.ecr"
  end
end
