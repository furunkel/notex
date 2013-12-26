module Notex
  module Section
    def section(name = nil, text, level: 0)
      current_section[level] ||= 0
      current_section[level]  += 1

      size = section_size(level)
      self.text "#{current_section[0..level].compact.join('.')} #{text}", :size => size
      move_down section_skip(level)
    end

    def current_section
      @current_section ||= [] 
    end
  end
end
