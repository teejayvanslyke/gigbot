module Gigbot
  module Helpers
    module StringHelpers
      def textify_html_summary(summary)
        IO.popen("w3m -T text/html -dump -cols 80", mode="r+") do |io|
          io.write(summary)
          io.close_write
          return io.read
        end
      end
    end
  end
end

