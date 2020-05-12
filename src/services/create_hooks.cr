class CreateHooks
  def initialize(@repo : Repository)
  end

  def create_all_hooks
    create_post_receive
  end

  def create_post_receive
    bash_content = <<-BASH
    #!/bin/bash
    cd ./../../../../
    while read oldrev newrev ref
    do
      lucky microgit.hooks --id=#{@repo.id} --oldrev=$oldrev --newrev=$newrev --ref=$ref
    done
    BASH
    add_to_file("post-receive") do |file|
      file.puts bash_content
    end
  end

  def add_to_file(name, &block)
    File.open("#{@repo.git_path}/hooks/#{name}", "w", File::Permissions::OtherExecute) do |file|
      yield file
    end
  end
end
