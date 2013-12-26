module Notex
  class Model
    attr_reader :commands

    NODE_COMMANDS = [:circle, :rectangle, :rounded_rectangle, :line_to]
    NODE_COMMANDS.each do |cmd|
      define_method cmd do |*args|
        if args.first.is_a? Symbol
          id = args.shift
          node_ids[id] = [cmd, args]
        end
        @commands << [cmd, args]
      end
    end

    def initialize(code)
      @commands = []
      instance_eval code
      @commands.freeze
      self.freeze
    end

    def north(node_id, p = 0.5)
      cmd, args = node_ids[node_id]
      case cmd
      when :rectangle
        args
      end
    end

    def method_missing(method, *args, &block)
      @commands << [method, args, block]
    end

    private
    def node_ids
      @node_ids ||= {}
    end
  end
end
