require 'minitest/autorun'
require_relative '../lib/looks_like'

VALID_ASCII = ["2345", "hello", "World23", "hexcode", "ffccdd", "TogetherAsOne", "CAPITALIZED"]
INVALID_ASCII = ["��7���H��H��", "\n\t", "\0", "你好，世界"]

VALID_UNICODE = ["ἴος or ἰός", "δέκα", ";", "devnull", "��7���H��H��"]

VALID_NUMERICS = ["-12", "12", "+14", "24.5", "0.3333333", "-3.555"]
INVALID_NUMERICS = ["$2", "50kg", "ↂ", "ↅ", ".34", "abc", "1above", "--123", "1.2.4"]

VALID_TIMES = ["2:30:59 pm", "14:30:59", "14:30", "2:30am", "4:00pm", "12:30 AM"]
INVALID_TIMES = ["25:00:00", "2:30", "12:60:00", "notatime", "99:99"]

VALID_DATES = ["2026-05-13", "05/13/2026", "13.05.2026", "May 13, 2026"]
INVALID_DATES = ["notadate", "yesterday", "2026-13-14", "13/32/2026", "2026"]

VALID_IPS = ["192.168.1.1", "10.0.0.1", "127.0.0.1", "255.255.255.255", "2001:db8:3333:4444:5555:6666:7777:8888", "2001:0db8:0001:0000:0000:0ab9:C0A8:0102"]
INVALID_IPS = ["999.999.999.999", "192.168.1", "192.168.1.1.1", "localhost"]

VALID_URLS = ["https://github.com", "https://example.com", "https://sub.domain.co.uk/path?query=1", "http://example.com:8080"] #"ftp://files.example.com"]
INVALID_URLS = ["github.com", "://missing.scheme", "https://"]

VALID_ENCODED = ["Z29vZGJ5ZSBldmVyeW9uZQo=", "68656c6c6c6f20776f726c64", "1101000", "M5XW6ZDCPFSSAZLWMVZHS33OMU======", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0.KMUFsIDTnFmyG3nMiGM6H9FNFUROf3wh7SmqJp-QV30", "0x47"]
INVALID_ENCODED = ["abcd=", "together==", "deadbeefs"]

VALID_FLAGS = ["HTB{Ex4mp13_f14g}", "picoCTF{F1AG5AND5TUFF}", "THM{REDACTED}", "CTF{example_flag}", "FLAG{standard_flag}"]
INVALID_FLAGS = ["HTB{", "}HTB", "htb{lowercase}", "picoctf{found", "reversed}picoctf", "thm}nothing_here{"]



VALID_EMAILS = ["foo@bar.com", "user@example.com", "name.surname@company.co.uk"]#, "user+tag@gmail.com"]
INVALID_EMAILS = ["notanemail", "foo@", "@bar.com", "foo@bar is my email"]


describe LooksLike do
  describe "ascii?" do
    it "accepts valid ascii" do
      VALID_ASCII.each do |ascii|
        assert LooksLike.ascii?(ascii), "Expected #{ascii} to be valid"
      end
    end

    it "rejects invalid asciis" do
      INVALID_ASCII.each do |ascii|
        refute LooksLike.ascii?(ascii), "Expected #{ascii} to be invalid"
      end
    end
  end

  describe "unicode?" do
    it "accepts unicodes" do
      VALID_UNICODE.each do |unicode|
        assert LooksLike.unicode?(unicode), "Expected #{unicode} to be valid"
      end
    end
  end

  describe "numeric?" do
    it "accepts valid numerics" do
      VALID_NUMERICS.each do |numeric|
        assert LooksLike.numeric?(numeric), "Expected #{numeric} to be valid"
      end
    end

    it "rejects invalid numerics" do
      INVALID_NUMERICS.each do |numeric|
        refute LooksLike.numeric?(numeric), "Expected #{numeric} to be invalid"
      end
    end
  end

  describe "times?" do
    it "accepts valid times" do
      VALID_TIMES.each do |time|
        assert LooksLike.time?(time), "Expected #{time} to be valid"
      end
    end

    it "rejects invalid times" do
      INVALID_TIMES.each do |time|
        refute LooksLike.time?(time), "Expected #{time} to be invalid"
      end
    end
  end

  describe "date?" do
    it "accepts valid dates" do
      VALID_DATES.each do |date|
        assert LooksLike.date?(date), "Expected #{date} to be valid"
      end
    end

    it "rejects invalid dates" do
      INVALID_DATES.each do |date|
        refute LooksLike.date?(date), "Expected #{date} to be invalid"
      end
    end
  end

  describe "ip?" do
    it "accepts valid ips" do
      VALID_IPS.each do |ip|
        assert LooksLike.ip?(ip), "Expected #{ip} to be valid"
      end
    end

    it "rejects invalid ips" do
      INVALID_IPS.each do |ip|
        refute LooksLike.ip?(ip), "Expected #{ip} to be invalid"
      end
    end
  end

  describe "url?" do
    it "accepts valid urls" do
      VALID_URLS.each do |url|
        assert LooksLike.url?(url), "Expected #{url} to be valid"
      end
    end

    it "rejects invalid urls" do
      INVALID_URLS.each do |url|
        refute LooksLike.url?(url), "Expected #{url} to be invalid"
      end
    end
  end

  describe "encoded?" do
    it "accepts valid encoded" do
      VALID_ENCODED.each do |encoded|
        assert LooksLike.encoded?(encoded), "Expected #{encoded} to be valid"
      end
    end

    it "rejects invalid encoded" do
      INVALID_ENCODED.each do |encoded|
        refute LooksLike.encoded?(encoded), "Expected #{encoded} to be invalid"
      end
    end
  end
  

  describe "email?" do
    it "accepts valid emails" do
      VALID_EMAILS.each do |email|
        assert LooksLike.email?(email), "Expected #{email} to be valid"
      end
    end

    it "rejects invalid emails" do
      INVALID_EMAILS.each do |email|
        refute LooksLike.email?(email), "Expected #{email} to be invalid"
      end
    end
  end
  
  describe "flag?" do
    it "accepts valid flag" do
      VALID_FLAGS.each do |flag|
        assert LooksLike.flag?(flag), "Expected #{flag} to be valid"
      end
    end

    it "rejects invalid flag" do
      INVALID_FLAGS.each do |flag|
        refute LooksLike.flag?(flag), "Expected #{flag} to be invalid"
      end
    end
  end
end
