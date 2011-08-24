require 'termistat/config'
require 'termistat/tee_io'
require 'termistat/version'

begin
  require 'ffi-ncurses'
rescue LoadError
  require 'rubygems'
  require 'ffi-ncurses'
end

#
# Termistat is a status bar for your terminal
#
# :title:Termistat

module Termistat
  #
  # The +status_bar+ instance method initializes the status bar if necessary
  # and displays your message.
  #
  # === Parameters
  # * message = the messge you want to display
  #
  # === Example
  #  include Termistat
  #  status_bar "37% complete"
  #
  def status_bar(message)
    Termistat.status_bar message
  end

  class << self
    #
    # the +status_bar+ class method initializes the status bar if necessary
    # and displays your message.
    #
    # === Parameters
    # * message = the messge you want to display
    #
    # === Example
    #  Termistat.status_bar "37% complete"
    #
    def status_bar(message)
      setup unless @stdscr
      m = formatted_message(message, config.align, status_bar_width)

      FFI::NCurses.wmove @status, 0, 0
      FFI::NCurses.wattr_set @status, FFI::NCurses::A_NORMAL, 1, nil
      FFI::NCurses.waddstr @status, m
      FFI::NCurses.wrefresh @status
    end

    #
    # +config+ either returns the active configuration or (when a block is
    # passed), sets up the configuration DSL.  See Termistat::Config for
    # supported parameters and options.
    #
    # === Example
    #  Termistat.config do
    #    align :left
    #  end
    #
    def config(&block)
      if block_given?
        c = Config.new
        c.instance_eval(&block)
        @config = c
      end

      @config ||= Config.new
    end

    #:enddoc:
    def config=(config)
      @config = config
    end

    def setup
      # set up ncurses standard screen
      @stdscr = FFI::NCurses.initscr
      FFI::NCurses.scrollok @stdscr, 1

      # set up ncurses status bar
      @height, @width = FFI::NCurses.getmaxyx(@stdscr)

      @status = FFI::NCurses.newwin(*status_bar_params)
      FFI::NCurses.scrollok @status, 0

      # set up colors
      FFI::NCurses.start_color
      background = FFI::NCurses::Color.const_get(config.background.to_s.upcase)
      foreground = FFI::NCurses::Color.const_get(config.foreground.to_s.upcase)
      FFI::NCurses.init_pair(1, foreground, background)

      # hide cursor
      FFI::NCurses.curs_set 0

      # redirect stdout
      $stdout = TeeIO.new do |msg|
        FFI::NCurses.addstr msg
        FFI::NCurses.refresh

        FFI::NCurses.touchwin @status
        FFI::NCurses.wrefresh @status
      end

      at_exit do
        FFI::NCurses.endwin

        output = $stdout.string
        $stdout = STDOUT
        puts output
      end
    end

    def status_bar_params
      case config.position
      when Array
        config.position
      when :top
        [1, @width, 0, 0]

      when :top_right
        x = @width / 2
        w = @width - x
        [1, w, 0, x]

      when :top_left
        x = @width / 2
        w = @width - x
        [1, w, 0, 0]

      end
    end

    def status_bar_width
      status_bar_params[1]
    end

    def formatted_message(string, alignment, width)
      return string.center(width) if :center === alignment
      "%#{ :left === alignment ? '-' : '' }#{ width }s" % string
    end
  end
end
