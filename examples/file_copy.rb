$:.unshift File.expand_path('../../lib', __FILE__)
require 'termistat'

class FileCopy
  include Termistat

  def simulate
    ('a'..'z').to_a.each_with_index do |letter, index|
      status_bar("%0.1f%% complete" % ((index / 26.to_f) * 100))
      puts "copying /path/to/file/#{ letter }..."
      sleep rand(0.5)
    end
  end
end

fc = FileCopy.new
fc.simulate
