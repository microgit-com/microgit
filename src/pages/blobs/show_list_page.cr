class Repositories::Blobs::ShowListPage < ShowLayout
  needs repository : Repository
  needs repo : MicrogitGit
  needs path : String
  needs branch_name : String
  needs file : Git::TreeEntry | Nil
  needs tree : Git::Tree | Nil
  needs file_name : String
  needs current_user : User | Nil
  quick_def single_page, @file.try { |r| r.name }
  quick_def page_title, @file.try { |r| r.name }

  def content
    render_template "repositories/simple_files.html.ecr"
  end
end
