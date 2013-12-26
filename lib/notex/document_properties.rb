module Notex
  module DocumentProperties

    def self.document_property(name, default_value)
      send :define_method, :"#{name}=" do |value|
        instance_variable_set :"@#{name}", value
      end

      send :define_method, :"#{name}" do |*args|
        prop = instance_variable_get(:"@#{name}") || default_value
        if prop.is_a? Proc
          self.instance_exec(*args, &prop)
        else
          prop
        end
      end
    end


    document_property :title_size, 22
    document_property :author_size, 20
    document_property :title_skip, 10
    document_property :author_skip, 15
    document_property :normal_size, 12
    document_property :small_caps_factor, 1.2
    document_property :section_size, proc{|level| title_size - 4 - level * 1.4}
    document_property :section_skip, proc{|level| [0, 12 - 3 * level].max + 5}

  end
end
