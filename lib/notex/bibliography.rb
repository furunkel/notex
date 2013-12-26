require 'bibtex'
require 'citeproc'


class CiteProc::Format::Notex < CiteProc::Format::Default
  def initialize
    super
  end

  def name; "Notex style"; end

  def finalize
    content = @tokens.map(&:content).join.gsub('--', '-')

    unless @styles.empty?
      @styles.each_pair do |style, value|
        case
        when style == 'font-weight' && value == 'bold'
          content = "<b>#{content}</b>"
        when style == 'font-style' && value == 'italic'
          content = "<i>#{content}</i>"
        else
          #FIXME
          content = content
        end
      end
    end

    [prefix, content, suffix].reject(&:nil?).join      
  end
end

module Notex
  module Bibliography
    module CitationStyles
      def self.id(entry, index)
        "[#{index}]"
      end

      def self.alpha(entry, index)
        "[#{entry.author.map{|a| a.last[0..2]}.join('')}#{entry.year.to_s[-2..-1]}]"
      end
    end

    def bibliography(filename)
      bib = BibTeX.open(filename)
      section 'References', numbered: false
      bib.each_with_index do |entry, index|
        p citation_style(entry, index)
        self.text citation_style(entry, index)
        self.text CiteProc.process(entry.to_citeproc, :style => bibliography_style, :format => :notex), :inline_format => true
        move_down bibliography_entry_skip
      end
    end
  end
end
