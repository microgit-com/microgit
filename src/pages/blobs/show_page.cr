class Repositories::Blobs::ShowPage < ShowLayout
  needs repository : Repository
  needs repo : MicrogitGit
  needs file : Git::TreeEntry | Nil
  needs file_content : String | Nil
  needs file_name : String
  needs current_user : User | Nil
  quick_def single_page, @file_name
  quick_def page_title, @file_name

  def content
    render_template "blobs/show.html.ecr"
  end
end
