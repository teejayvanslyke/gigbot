require 'digest'
require 'fileutils'

module Gigbot
  class Gig
    DATA_PATH = File.dirname(__FILE__) + '/../../data'

    def initialize(attributes = {})
      @title = attributes[:title]
      @url = attributes[:url]
      @created_at = attributes[:created_at]
      @source = Source.find(attributes[:source_id])
      @description = attributes[:description]
    end

    attr_reader :title, :url, :created_at, :source, :description
    attr_accessor :source

    def as_json
      {
        id: id,
        title: title,
        url: url,
        created_at: created_at,
        source_id: source.id,
        description: description,
      }
    end

    def id
      Digest::SHA1.hexdigest(url)
    end

    def save
      File.open(DATA_PATH + '/' + id + '.yml', 'w') {|f| f.write(YAML.dump(as_json))}
    end

    def to_s
      title
    end

    def self.clean!
      FileUtils.rm_rf Dir.glob(File.join(DATA_PATH, '*.yml'))
    end

    def self.all
      Dir[DATA_PATH + '/*.yml'].map {|path| from_yaml(path)}.sort_by(&:created_at).reverse
    end

    def self.each
      all.each {|gig| yield gig}
    end

    def self.find(id)
      from_yaml(DATA_PATH + '/' + id + '.yml')
    end

    def self.since(date)
      all.select {|gig| gig.created_at > date}
    end

    def self.from_yaml(yaml_path)
      data = YAML.load_file(yaml_path)
      new(data)
    end
  end
end
