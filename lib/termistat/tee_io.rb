require 'stringio'

module Termistat
  #
  # TeeIO wraps a StringIO object such that writes to the IO can trigger events
  # immediately, but the entirety of the string is available later.
  #
  # initialize method takes a block that will be called on every write.
  #
  class TeeIO < StringIO
    # create a new TeeIO object
    #
    # == Example
    #  $stdout = TeeIO.new {|str| STDOUT.puts str.reverse }
    #
    def initialize(&block)
      @io = StringIO.new
      @callback = block
    end

    def write(chars)
      @io.write(chars)
      @callback.call(chars)
    end

    def string
      @io.string
    end
  end
end
