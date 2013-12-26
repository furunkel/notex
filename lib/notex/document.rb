require 'notex/document_properties'
require 'notex/section'
require 'notex/text_util'

module Notex
  class Document < Prawn::Document

    include DocumentProperties
    include Section

    def title(text, small_caps: true)
      text = TextUtil.small_caps(text, title_size, small_caps_factor) if small_caps
      self.text text, :align => :center, :size => title_size, :inline_format => true
      move_down title_skip
    end

    def author(text)
      move_up title_skip * 0.7
      self.text text, :align => :center, :size => author_size
      move_down author_skip
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
