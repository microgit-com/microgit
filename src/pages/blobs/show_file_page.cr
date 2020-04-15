class Repositories::Blobs::ShowFilePage < ShowLayout
  needs repository : Repository
  needs repo : MicrogitGit
  needs path : String
  needs file : Git::TreeEntry | Nil
  needs file_content : String | Nil
  needs file_name : String
  needs current_user : User | Nil
  quick_def single_page, @file.try { |r| r.name }
  quick_def page_title, @file.try { |r| r.name }

  def content
    render_template "blobs/show.html.ecr"
  end
end
