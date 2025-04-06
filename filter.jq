if type == "object" then
  to_entries | sort_by(.key|ascii_upcase) | from_entries
else
  .
end
