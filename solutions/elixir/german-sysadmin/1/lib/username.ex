defmodule Username do
  def sanitize(~c""), do: ~c""
  def sanitize([char | tail]) do
    case char do
      char when char >= ?a and char <= ?z -> [char | sanitize(tail)]
      ?_ -> [char | sanitize(tail)]
      ?ä -> ~c"ae" ++ sanitize(tail)
      ?ö -> ~c"oe" ++ sanitize(tail)
      ?ü -> ~c"ue" ++ sanitize(tail)
      ?ß -> ~c"ss" ++ sanitize(tail)
      _-> sanitize(tail)
    end
  end
end
