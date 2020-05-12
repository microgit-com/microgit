class CreateHooks
  def initialize(@repo : Repository)
  end

  def create_all_hooks
    create_post_receive
  end

  def create_post_receive
    bash_content = <<-BASH
    #!/bin/bash
    while read oldrev newrev ref
    do
      ./../../../../lucky microgit.hooks -id #{@repo.id} -or $oldrev -nr $newrev -ref $ref
    done
    BASH
    File.open("#{@repo.git_path}/hooks/post-receive", "w") do |file|
      file.puts bash_content
    end
  end
end
