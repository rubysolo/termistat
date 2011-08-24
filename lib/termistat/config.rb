module Termistat
  class Config
    def initialize(options={})
      @options = {
        :position => :top_right,
        :align    => :left,
      }.merge(options)
    end

    def position(position=nil)
      @options[:position] = position unless position.nil?
      @options[:position]
    end

    def align(align=nil)
      @options[:align] = align unless align.nil?
      @options[:align]
    end
  end
end
