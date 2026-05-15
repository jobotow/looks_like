require_relative 'looks_like'

#LooksLike.register(:date_iso_8601, /[[:digit:]]{2}-(0?[1-9]|1[0-2])-[[:digit:]]{2}/)

#puts LooksLike.date?("23-02-29", subset: :iso_8601)
#puts LooksLike::GROUPS
#puts LooksLike.what("2023-02-29")

#puts "INPUT: picoCTF{h3ll0_w0rld}   | RESULT: #{LooksLike.what("picoCTF{h3ll0_w0rld}")}"
#puts LooksLike.what("hello")
#puts LooksLike.what("ἴος or ἰός")
#puts LooksLike.what("$200")
#puts LooksLike.what("CVE-2013-5685")
#pp LooksLike.extract("SEkK")
#pp LooksLike.extract("dump bG9va3NfbGlrZQo= and abc123")
#pp LooksLike.extract("v2.0.0 hello", by: :word)
#puts LooksLike.what("v2.0.0")
#pp LooksLike.extract("foo@bar.com uses ip 192.168.1.1", match: [:email, :ip], by: :line)

puts LooksLike.what("Wed, 15 May 2026")