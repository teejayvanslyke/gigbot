require 'rubygems'
require 'thor'
require 'date'

require_relative 'updater'
require_relative 'reader'

module Gigbot
  class CLI < Thor
    desc "update", "Updates jobs from all sources"
    def update
      Gigbot::Updater.run
    end

    desc "list", "Lists jobs from all sources"
    def list
      Gigbot::Reader.run
    end

    desc "today", "Lists jobs for past 24 hours"
    def today
      Gigbot::Reader.run(since: Time.now - (60 * 60 * 24))
    end

    map up: :update
    map ls: :list
  end
end
