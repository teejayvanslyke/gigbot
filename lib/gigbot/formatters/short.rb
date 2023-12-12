require_relative './base'

module Gigbot
  module Formatters
    class Short < Base
      def to_s
        [
          "job #{gig.id}".colorize(color: :yellow),
          "Title:  #{gig.title}",
          "URL:    #{gig.url}",
          "Source: #{gig.source.title}",
          "Date:   #{gig.created_at}"
        ].join("\n")
      end
    end
  end
end

