module Notex
  module TextUtil
    def self.small_caps(text, size, factor)
      text.upcase.gsub(/(?:^|\s)([[:word:]])/) do |w|
        "<font size='#{size * factor}'>#{w}</font>"
      end
    end

    def self.text(text)
      text.gsub(/(?<=^|[[:punct:]]|[[:space:]])\*(.+?)\*(?=$|[[:punct:]]|[[:space:]])/, '<i>\1</i>')
          .gsub(/(?<=^|[[:punct:]]|[[:space:]])\*\*(.+?)\*\*(?=$|[[:punct:]]|[[:space:]])/, '<b>\1</b>')
          .gsub(/(?<=^|[[:punct:]]|[[:space:]])_(.+?)_(?=$|[[:punct:]]|[[:space:]])/, '<u>\1</u>')

    end
  end
end
