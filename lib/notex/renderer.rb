require 'notex/model'
require 'notex/document'
require 'notex/parser'

module Notex
  class Renderer
    FONTS_DIR = File.join(File.dirname(File.dirname(File.dirname __FILE__)), 'fonts')

    def self.render(code)
      code = Parser.parse code
      model = Model.new code

      doc_cmds, non_doc_cmds = model.commands.partition do |name, _, _|
        name.to_s == 'document'
      end

      #FIXME: this is style related
      options = {:left_margin	=> 2.cm,
                 :right_margin => 2.cm,
                 :top_margin => 2.cm,
                 :bottom_margin => 2.cm}

      options[:info] = {:CreationDate => Time.now,
                        :Creator => "Notex #{Notex::VERSION}",
                        :Producer => "Prawn #{Prawn::VERSION}"}

      doc_cmds.each do |name, args, block|
        options[args.first] = (args.size == 2 ? args[1] : args[1..-1])
      end

      document = Document.new(model, options)

      add_fonts document

      non_doc_cmds.each do |name, args, block|
        document.send name, *args, &block
      end

      document.render
    end

    private
    def self.add_fonts(document)
      Dir[File.join FONTS_DIR, '*.ttf'].group_by{|f| File.basename(f) =~ /(.*?)-/ and $1}.each do |font, files|
        font_map = files.inject(Hash.new) do |acc, file|
          if File.basename(file, 'ttf') =~ /.*?-([a-z_]+)/
            acc[$1.to_sym] = file
          end
          acc
        end
        document.font_families.update(font => font_map)
      end
    end
  end
end
