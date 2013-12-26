require 'notex/style'
require 'notex/section'
require 'notex/text_util'
require 'notex/bibliography'

require 'text/hypen'

module Notex
  class Document < Prawn::Document

    include Style
    include Section
    include Bibliography

    def initialize(model, options)
      @model = model
      super(options)
    end

    def title(text, small_caps: true)
      move_down title_skip_before
      text = TextUtil.small_caps(text, title_size, small_caps_factor) if small_caps
      self.text text, :align => :center, :size => title_size, :inline_format => true
      move_down title_skip
    end

    def author(text)
      move_up title_skip * 0.7
      self.text text, :align => :center, :size => author_size
      move_down author_skip
    end

    def abstract(text)
      self.text 'Abstract', :align => :center, :size => abstract_title_size, :style => abstract_title_style
      span(abstract_width, :position => :center) do
        self.text TextUtil.text(text), :inline_format => true
      end
      move_down abstract_skip
    end

    def hyphenated_text(text,  width)
      hyphen = Text::Hyphen.new
      text.each_line do |line|
        words = line.split(' ')
        words.each do |draw_text|
      end
    end

    def method_missing(method, *args, &block)
      if method =~ /(?:sub)+section/
        section(*args, level: method.to_s.scan(/sub/).count)
      else
        super
      end
    end
  end
end 
