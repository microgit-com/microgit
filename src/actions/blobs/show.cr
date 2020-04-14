class Repositories::Blobs::Show < RepositoryAction
  get "/:namespace_slug/:repository_slug/blob/:branch_name/:path" do
    begin
      repo = MicrogitGit.new(@repository.not_nil!)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end

    languages = Linguist::LanguageContainer.new

    filename = path.split("/").last
    lang = languages.find_by_extension(filename)
    filename = lang.first.name

    file = nil
    file_content = nil
    unless repo.raw.empty?
      file = repo.find_file(path)
      file_content = repo.find_file_blob(path).try { |r| r.content }
    end
    html ShowPage, repo: repo, repository: @repository.not_nil!, file: file, file_content: file_content, file_name: filename
  end
end
