require "option_parser"
class HookReceiver < LuckyCli::Task
  summary "Updating data on repository"
  name "microgit.hooks"

  def call(args = ARGV)
    oldrev = ""
    newrev = ""
    ref = ""
    repo_id = 0
    OptionParser.parse(args) do |parser|
      parser.banner = "Usage: lucky microgit.hooks"
      parser.on("-or OLDREV", "--oldrev=OLDREV", "old revision") do |orn|
        oldrev = orn
      end
      parser.on("-nr NEWREV", "--newrev=NEWREV", "new revision") do |nr|
        newrev = nr
      end
      parser.on("-ref REF", "--ref=REF", "reference") do |nref|
        ref = nref
      end
      parser.on("-id ID", "--id=ID", "repo id") do |id|
        repo_id = id.to_i
      end
      parser.invalid_option do |flag|
        STDERR.puts "ERROR: #{flag} is not a valid option."
        STDERR.puts parser
        exit(1)
      end
      parser.missing_option do |option|
        STDERR.puts "ERROR: #{option} is missing a value"
        exit(1)
      end
    end

    File.open("./hooks.log", "w") do |file|
      file.puts "repoid: #{repo_id}"
      file.puts "test #{ref}"
    end
    puts "Saved a log for #{ref} for #{repo_id}"
    #HookWorker.async.perform(repo_id, oldrev, newrev, ref)
  end
end
