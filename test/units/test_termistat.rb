require_relative '../helper'
require 'termistat'

class Included
  include Termistat
end

class TestTermistat < MiniTest::Unit::TestCase
  def setup
    Termistat.config = nil
    @included = Included.new
  end

  def test_status_bar_method
    assert @included.respond_to?(:status_bar)
  end

  def test_ncurses_initialization
    # @included.status_bar "hello"
  end

  def test_default_configuration
    assert_equal :top_right, Termistat.config.position
  end

  def test_configuration
    Termistat.config do
      position :top_left
      align    :center
    end

    assert_equal :top_left, Termistat.config.position
  end

  def test_text_alignment
    assert_equal "foo       ", Termistat.formatted_message("foo", :left, 10)
    assert_equal "       foo", Termistat.formatted_message("foo", :right, 10)
    assert_equal "   foo    ", Termistat.formatted_message("foo", :center, 10)
  end

end
