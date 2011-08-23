require_relative '../helper'
require 'termistat/tee_io'

class TestTeeIO < MiniTest::Unit::TestCase
  def setup
    @default = Termistat::Config.new
    @custom  = Termistat::Config.new(
      :position => :top_right,
      :align    => :left,
    )
  end

  def test_configuration
    assert_equal :top_right, @default.position
  end
end
