require "sidekiq/cli"
require "shards"
require "./workers/**"

Mosquito::Runner.start
