require_relative '../helper'
require 'termistat/tee_io'

class TestTeeIO < MiniTest::Unit::TestCase
  def test_callback
    @capture = nil
    @tee_io = Termistat::TeeIO.new {|msg| @capture = msg }
    @tee_io.print "foo"
    assert_equal "foo", @capture
  end

  def test_output_is_recorded
    @tee_io = Termistat::TeeIO.new {|*args|}
    @tee_io.puts "foo"
    assert_equal "foo\n", @tee_io.string
  end
end
