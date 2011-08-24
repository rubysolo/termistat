# Termistat

Termistat displays an ncurses-based status bar atop your STDOUT.

## Scenario:

You have a long-running process that writes detailed log information to
standard output.  You would like to also be able to determine overall
progress at a glance.  You could scatter status lines among the log
lines, but that's messy and can be hard to find.  You could ditch the
detail output and display status only, but then you lose the sense of
what's going on at the detail level.

## The Solution

Termistat gives you the best of both worlds.  You still have your
detailed information, but you also have a status bar overlay with which
you can display summary information.

## Screenshot

Here's what termistat looks like in action:

![screenshot](https://github.com/rubysolo/termistat/raw/master/examples/file_copy.png)


## Installation:

    gem install termistat

## Usage:

Include the module in your class, and you get a `status_bar` method.

    class VerboseProcess
      include Termistat

      def perform
        1000.times do |index|
          status_bar progress(index / 1000.0)
          $stdout.puts "This is normal log entry number #{ index }"

          # do some hard work
          sleep(rand(10))
        end
      end

      def progress(pct)
        "status: %0.2f% complete" % (pct * 100)
      end
    end

Don't want to or can't include?  No problem, you can use the module
method.

    class VerboseProcess
      def perform
        1000.times do |index|
          Termistat.status_bar progress(index / 1000.0)
          $stdout.puts "This is normal log entry number #{ index }"

          # do some hard work
          sleep(rand(10))
        end
      end

      def progress(pct)
        "status: %0.2f complete" % pct
      end
    end

## Configuration:

Termistat provides a default configuration that will display your status
bar in the top right corner of your terminal.  Using the configuration
DSL, you can position the status bar to your liking.

    Termistat.config do
      position :top
      align    :center
    end

*TODO*
* actual implementation for alignment config option
* color support

## Requirements

* ffi-ncurses gem
* ncurses (tested with homebrew-installed ncurses)

## License

The MIT License (MIT)
Copyright (c) 2011 Solomon White

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
