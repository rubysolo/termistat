require 'termistat/config'
require 'termistat/tee_io'
require 'termistat/version'

begin
  require 'ffi-ncurses'
rescue LoadError
  require 'rubygems'
  require 'ffi-ncurses'
end

module Termistat
  def status_bar(message)
    Termistat.status_bar message
  end

  class << self
    def status_bar(message)
      setup unless @stdscr
      m = formatted_message(message, config.align, status_bar_width)

      FFI::NCurses.wmove @status, 0, 0
      FFI::NCurses.waddstr @status, m
      FFI::NCurses.wrefresh @status
    end

    def config(&block)
      if block_given?
        c = Config.new
        c.instance_eval(&block)
        @config = c
      end

      @config ||= Config.new
    end

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
