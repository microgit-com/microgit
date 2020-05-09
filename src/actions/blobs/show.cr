class Repositories::Blobs::Show < RepositoryAction
  get "/:namespace_slug/:repository_slug/blob/:branch_name/:path" do
    begin
      repo = MicrogitGit.new(@repository.not_nil!)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end

    filename = path.split("/").last

    target = Git::Branch.lookup(repo.raw, branch_name)

    file = nil
    file_content = nil
    raise Lucky::RouteNotFoundError.new(context) if repo.raw.empty?
    unless repo.raw.empty?
      file = repo.find_file(path)
      raise Lucky::RouteNotFoundError.new(context) if file.nil?
    end
    if file.not_nil!.type != LibGit::OType::TREE

      blob = repo.find_file_blob(path)
      if !blob.nil?
        linguist = LinguistHelper.new(@repository.not_nil!)
        lang = linguist.get_language_name(path, filename, blob, target)
        filename = lang
        file_content = if !blob.binary?
          blob.content
        end
      end

      html ShowFilePage, repo: repo, repository: @repository.not_nil!, path: path, file: file, file_content: file_content, file_name: filename
    else
      file_list = repo.tree_by_path(path, branch_name)
      html ShowListPage, repo: repo, repository: @repository.not_nil!, path: path, file: file, tree: file_list, file_name: filename, branch_name: branch_name
    end
  end
end
