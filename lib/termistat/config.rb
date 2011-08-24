module Termistat
  #
  # The configuration class and DSL for Termistat
  #
  class Config
    def initialize(options={}) #:notnew:
      @options = {
        :position   => :top_right,
        :align      => :left,
        :foreground => :white,
        :background => :blue,
      }.merge(options)
    end

    #
    # position of the status bar on the terminal
    #
    # === Supported Options
    # * +:top_left+ : left half of top line
    # * +:top+ : full top line
    # * +:top_right+ : right half of top line
    #
    def position(position=nil)
      @options[:position] = position unless position.nil?
      @options[:position]
    end

    #
    # alignment of text within the status bar
    #
    # === Supported Options
    # * +:left+
    # * +:center+
    # * +:right+
    #
    def align(align=nil)
      @options[:align] = align unless align.nil?
      @options[:align]
    end

    #
    # color of foreground (text)
    #
    # === Supported Options
    # * +:black+
    # * +:red+
    # * +:green+
    # * +:yellow+
    # * +:blue+
    # * +:magenta+
    # * +:cyan+
    # * +:white+
    #
    def foreground(color=nil)
      @options[:foreground] = color unless color.nil?
      @options[:foreground]
    end

    #
    # color of background
    #
    # === Supported Options
    # * +:black+
    # * +:red+
    # * +:green+
    # * +:yellow+
    # * +:blue+
    # * +:magenta+
    # * +:cyan+
    # * +:white+
    #
    def background(color=nil)
      @options[:background] = color unless color.nil?
      @options[:background]
    end
  end
end
