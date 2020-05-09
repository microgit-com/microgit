class LinguistHelper
  include Caching
  def initialize(@repo : Repository)
  end

  def get_language_name(path, filename, blob, target)
    caching("language/#{path}") do
      micro_repo = MicrogitGit.new(@repo.not_nil!)
      ling_repo = Linguist::Repository.new(micro_repo.raw, target.target_id)
      detector = Linguist::Detector.new(ling_repo)
      detector.set_blob_git(blob.not_nil!, filename)
      if detector.language.nil?
        ""
      else
        return detector.language.not_nil!.name
      end
    end
  end
end
