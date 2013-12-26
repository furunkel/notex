module Notex
  module Section
    def section(text, level: 0, numbered: true)
      current_section[level] ||= 0
      current_section[level]  += 1

      size = section_size(level)
      number = if numbered 
        "#{current_section[0..level].compact.join('.')} "
      else
        ""
      end

      self.text "#{number}#{text}", :size => size
      move_down section_skip(level)
    end

    def current_section
      @current_section ||= [] 
    end
  end
end
