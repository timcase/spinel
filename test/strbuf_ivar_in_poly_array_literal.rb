# An ivar promoted to the shared String handle, read into a mixed Array
# literal, is boxed as its handle: boxed as the String's bytes, the
# sp_String * went into sp_box_str's const char * slot and the C did not
# compile. OptionParser#parse!, beside a runner that may be a Method, is
# what promotes the slot.
require "optparse"

class Controller
  def initialize(api_key:, runner: nil)
    @api_key = api_key
    @runner = runner || method(:spawn_run)
    @run = @runner.call(argv(1))
  end

  attr_reader :run

  def argv(n)
    ["-k", @api_key, n]
  end

  def spawn_run(argv)
    argv.join(" ")
  end
end

class Base
  def parse(argv)
    OptionParser.new do |o|
    end.parse!(argv)
  end
end

class Accept < Base
  def call(argv)
    parse(argv) do |o|
    end
  end
end

c = Controller.new(api_key: "secret")
p c.run
p c.argv(2)
p Accept.new.call(["rest"])
