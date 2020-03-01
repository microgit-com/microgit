class Commits::ShowPage < MainLayout
  needs repository : Repository
  needs repo : MicrogitGit
  needs commit : Git::Commit
  needs diff : Git::Diff
  include DiffHelper

  def content
    render_template "repositories/repo_links.html.ecr"
    render_template "commits/show.html.ecr"
  end
end
