module Notex
  class Parser
    # I want to keep this a simple as possible.
    # Yeah, yeah, this is not a real parser.
    def self.parse(text)
      text.gsub(/(?<=[a-z])\.\s+(.*?)(?:;|(?:\n\n)|\Z)/m){ " '#{$1}'\n"}
    end
  end
end
