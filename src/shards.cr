# Load .env file before any other config or app code
require "lucky_env"
LuckyEnv.load?(".env")

# Require your shards here
require "avram"
require "avram_scoped_id"
require "lucky"
require "carbon"
require "authentic"
require "jwt"
require "kilt"
require "git"
require "markd"
require "sluggr"
require "lucky_encrypted"
require "git_diff_parser"
require "redis"
require "lucky_can"
require "linguist"
require "mosquito"
