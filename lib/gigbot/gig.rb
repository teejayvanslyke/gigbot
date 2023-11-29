require 'digest'

module Gigbot
  class Gig
    DATA_PATH = File.dirname(__FILE__) + '/../../data'

    def initialize(attributes = {})
      @id = attributes[:id]
      @title = attributes[:title]
      @url = attributes[:url]
      @created_at = attributes[:created_at]
    end

    attr_reader :id, :title, :url, :created_at

    def as_json
      {
        id: id,
        title: title,
        url: url,
        created_at: created_at,
      }
    end

    def save
      File.open(DATA_PATH + '/' + id + '.yml', 'w') {|f| f.write(YAML.dump(as_json))}
    end

    def self.all
      Dir[DATA_PATH + '/*.yml'].map {|path| from_yaml(path)}.sort_by(&:created_at).reverse
    end

    def self.each
      all.each {|gig| yield gig}
    end

    def self.since(date)
      all.select {|gig| gig.created_at > date}
    end

    def self.from_rss(rss_item)
      new(
        id: Digest::SHA1.hexdigest(rss_item.id),
        title: rss_item.title.strip,
        url: rss_item.url.strip,
        created_at: rss_item.published
      )
    end

    def self.from_yaml(yaml_path)
      data = YAML.load_file(yaml_path)
      new(data)
    end

  end
end
