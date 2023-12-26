require 'rubygems'
require 'thor'
require 'date'

require_relative 'commands'

module Gigbot
  class CLI < Thor
    desc "update", "Updates jobs from all sources"
    method_option :verbose, type: :boolean, aliases: 'v'
    def update
      Gigbot::Commands::Update.run(options)
    end

    desc "list", "Lists jobs from all sources"
    def list
      Gigbot::Commands::List.run
    end

    desc "today", "Lists jobs for past 24 hours"
    def today
      Gigbot::Commands::List.run(since: Time.now - (60 * 60 * 24))
    end

    desc "clean", "Clears data"
    def clean
      Gigbot::Gig.clean!
    end

    desc "deep", "Fetches detailed metadata for all existing jobs"
    def deep
      Gigbot::Commands::Deep.run
    end

    desc "search", "Searches jobs by keyword"
    def search(query)
      Gigbot::Commands::List.run(query: query)
    end

    desc "show", "Show a full job listing"
    def show(sha)
      Gigbot::Commands::Show.run(sha)
    end

    map "up" => "update"
    map "ls" => "list"
  end
end
