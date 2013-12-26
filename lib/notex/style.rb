require 'notex/bibliography'

module Notex
  module Style

    def self.style_attr(name, default_value)
      send :define_method, :"#{name}=" do |value|
        instance_variable_set :"@#{name}", value
      end

      send :define_method, :"#{name}" do |*args|
        attr = instance_variable_get(:"@#{name}") || default_value
        if attr.is_a?(Proc) || attr.is_a?(Method)
          self.instance_exec(*args, &attr)
        else
          attr
        end
      end
    end


    style_attr :title_size, 20
    style_attr :author_size, 18
    style_attr :title_skip, 10
    style_attr :title_skip_before, 12
    style_attr :author_skip, 15
    style_attr :normal_size, 12

    style_attr :small_caps_factor, 1.2

    style_attr :section_size, proc{|level| title_size - 4 - level * 1.4}
    style_attr :section_skip, proc{|level| [0, 12 - 3 * level].max + 5}

    style_attr :abstract_width, proc{ bounds.width * 0.8 }
    style_attr :abstract_title_size, 13
    style_attr :abstract_title_style, :bold
    style_attr :abstract_skip, 12
    style_attr :citation_style, Bibliography::CitationStyles.method(:alpha)
    style_attr :bibliography_style, :apa
    style_attr :bibliography_entry_skip, 10

  end
end
