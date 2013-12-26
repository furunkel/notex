module Notex
  module TextUtil
    def self.small_caps(text, size, factor)
      text.upcase.gsub(/(?:^|\s)([[:word:]])/) do |w|
        "<font size='#{size * factor}'>#{w}</font>"
      end
    end
  end
end
