require 'yaml'
require 'open-uri'
require_relative './gig'
require_relative './parsers'
require 'pp'

module Gigbot
  class Source
    SOURCES_YAML = File.dirname(__FILE__) + '/sources.yml'
    attr_reader :url, :parser_name, :title, :imported

    def initialize(url, parser_name, title)
      @url = url
      @parser_name = parser_name
      @title = title
      @imported = []
    end

    def parser_class
      Gigbot::Parsers[parser_name]
    end

    def parser
      @parser ||= parser_class.new(url)
    end

    def id
      Digest::SHA1.hexdigest(url)
    end

    def import
      @imported = []
      parser.parse do |params|
        gig = Gig.new(params.merge(source_id: self.id))
        gig.save
        @imported << gig
      end
    end

    def import_deep(gig)
      parser.parse_deep(gig) do |params|
        gig.update_attributes(params)
        gig.save
      end
    end

    def self.all
      definitions = YAML.load_file(SOURCES_YAML)
      definitions.map do |definition|
        new(definition['url'], definition['parser'], definition['title'])
      end
    end

    def self.each
      all.each do |source|
        yield source
      end
    end

    def self.find(id)
      all.find {|source| source.id == id}
    end
  end
end
