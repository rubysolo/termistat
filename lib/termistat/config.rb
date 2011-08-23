module Termistat
  class Config
    def initialize(options={})
      @options = {
        :position => :top_right,
        :align    => :left,
      }.merge(options)
    end

    def method_missing(meth_id, *args)
      if @options.has_key?(meth_id)
        return @options[meth_id] if args.empty?
        @options[meth_id] = args.first
        self
      else
        raise NoMethodError.new(meth_id)
      end
    end
  end
end
