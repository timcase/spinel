# A boxed receiver's match with an interpolated pattern, where a program
# class answers match too, goes through the boxed dispatch: the String arm
# stored a raw MatchData into the boxed slot and the C did not compile.
class Completion
  def match(key)
    "completion #{key}"
  end
end

def rate(out, key)
  m = out.match(/key:'#{Regexp.escape(key)}'\s+value:'(\d+)'/)
  m && m[1].to_i
end

outs = ["key:'clock.rate' value:'48000'", 1]
p rate(outs[0], "clock.rate")
p rate(outs[0], "clock.quantum")
p Completion.new.match("x")
o = [Completion.new, "id 7"][1]
p o.match(/id (#{7})/)[1]
