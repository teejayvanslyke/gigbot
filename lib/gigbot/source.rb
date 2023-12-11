require 'yaml'
require 'open-uri'
require_relative './gig'
require_relative './parsers'
require 'pp'

module Gigbot
  class Source
    SOURCES_YAML = File.dirname(__FILE__) + '/sources.yml'
    attr_reader :url, :parser_name, :imported

    def initialize(url, parser_name)
      @url = url
      @parser_name = parser_name
      @imported = []
    end

    def parser_class
      Gigbot::Parsers[parser_name]
    end

    def parser
      @parser ||= parser_class.new(url)
    end

    def title
      @title ||= parser.title
    end

    def import
      @imported = []
      parser.parse do |gig|
        gig.source = self
        gig.save
        @imported << gig
      end
    end

    def self.each
      definitions = YAML.load_file(SOURCES_YAML)
      definitions.each do |definition|
        yield new(definition['url'], definition['parser'])
      end
    end
  end
end
