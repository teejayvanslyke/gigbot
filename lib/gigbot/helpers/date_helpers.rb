module Gigbot
  module Helpers
    module DateHelpers
      def dehumanize_date(humanized_date)
        parts = humanized_date.split(' ')
        quantity = if parts[0].strip == 'a' then 1 else parts[0].to_i end
        unit = parts[1]

        seconds = case unit
                  when /hour/
                    60 * 60
                  when /day/
                    60 * 60 * 24
                  when /week/
                    60 * 60 * 24 * 7
                  when /month/
                    60 * 60 * 24 * 30
                  end

        Time.now - (quantity * seconds)
      end
    end
  end
end
