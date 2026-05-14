require_relative 'looks_like'

#LooksLike.register(:date_uso, /[[:digit:]]{2}-(0?[1-9]|1[0-2])-[[:digit:]]{2}/)

#puts LooksLike.date?("2023-02-29", subset: :iso)
#puts LooksLike::GROUPS
#puts LooksLike.what("2023-02-29")

#puts "INPUT: picoCTF{h3ll0_w0rld}   | RESULT: #{LooksLike.what("picoCTF{h3ll0_w0rld}")}"
#puts LooksLike.what("hello")
#puts LooksLike.what("ἴος or ἰός")
puts LooksLike.what("2024-04-20")