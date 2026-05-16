# LooksLike
A ruby library for detecting patterns in strings. It tells you what a string looks like

**Without much ado, lets hop right into getting our hands dirty**
## Module Methods
### Group Methods
```ruby
LooksLike.{group}?(text, subset: nil) =>  true || false
```
Returns `true` if `text` matches any pattern in `group` group. Pass `subset:` to narrow to a specific subset

#### Parameters
`text`(String): the string to test
`subset:`(Symbol, optional): a subset within a group

#### Examples
```ruby
require 'looks_like'

LooksLike.email?("foo@bar.com")   # => true
LooksLike.date?("2026-05-11")     # => true
LooksLike.date?("2026-05-11", subset: :iso_8601)  # => true
LooksLike.date?("2026-05-11", subset: :eu) # => false
```

---

### Classification Method
```ruby
require 'looks_like'

LooksLike.what(text) => Hash
```
Returns a hash `{group: [:subsets] }` of every group and subset `text` matches. Useful when type of `text` is unknown

#### Parameters
`text`(String): the string to classify

#### Examples
```ruby
require 'looks_like'

LooksLike.what("foo@bar.com")
# => {:unicode=>[:print, :graph], :email=>[:basic]}

LooksLike.what("2026-05-11")
# => {:unicode=>[:print, :graph], :phone=>[:local], :date=>[:iso_8601]}

LooksLike.what("hello")
# => {:ascii=>[:alpha, :alphanum, :lower], :unicode=>[:alpha, :alphanum, :lower, :print, :graph]}

LooksLike.what("ἴος or ἰός")
# => {:unicode=>[:print]}
```

---

### Extracting Method
```ruby
LooksLike.extract(text, match: nil, by: :word) => Array | Hash
```
Extracts all  matches of a pattern from a string by defined boundary

#### Parameters
`text`(String): Text to scan
**Match could either be a Symbol a Hash or an Array**
`match:`(nil): Scan all groups
`match:`(Symbol): The group to scan for
`match:`(Hash): `{ group: :subset }` to narrow a specific subset
`match:`(Array): multiple groups, returns a Hash of results per group

`by:`(Symbol, optional): How boundaries are applied
- `:word`: space delimited tokens (default)
- `:line`: line boundaries
- `:free`: No boundaries, anywhere in string
- `:exact`: Entire `text` must match.


#### Examples
```ruby
require 'looks_like'

LooksLike.extract("contact foo@bar.com or baz@qux.com", match: :email)
# => ["foo@bar.com", "baz@qux.com"]

LooksLike.extract("dump bG9va3NfbGlrZQo= and abc123", match: {encoded: :base64})
# => ["dump", "", "bG9va3NfbGlrZQo=", "abc1"]

LooksLike.extract("foo@bar.com uses ip 192.168.1.1", match: [:email, :ip])
# => {:email=>["foo@bar.com"], :ip=>["192.168.1.1"]}

LooksLike.extract("foo@bar.com uses ip 192.168.1.1", match: [:email, :ip])
# => {:email=>[], :ip=>[]}

```

---

### Registration Method
```ruby
LooksLike.register(name, pattern) => nil
```
Registers a new pattern at runtime. If the group does not exist it is created automatically, includeing its `?` detection method

#### Parameters
`name`(Symbol): pattern name following the `group_subset` convention
`pattern`(Regexp): the patten to register

#### Examples
```ruby
require 'looks_like'

LooksLike.register(:date_hijri, /[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}/)
LooksLike.date?("1/5/1445", match: :hijri)  # => true


LooksLike.register(:crypto_bitcoin, /[13][a-km-zA-HJ-NP-Z1-9]{25,34}/)
LooksLike.register(:crypto_p2pkh, /[3][a-km-zA-HJ-NP-Z1-9]{25,34}/)
LooksLike.crypto?("3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy")  # => true
```

---

### Constants
```ruby
LooksLike::PATTERNS => Hash
```
A flat hash of all registered patterns keyed by `group_subset` name.
Accessible directly if raw regex access is needed

#### Example
```ruby
require 'looks_like'

LooksLike::PATTERNS[:ip_v4]
# => (?-mix:(?:(?:25[0-5]|2[0-4][[:digit:]]|[01]?[[:digit:]][[:digit:]]?)\.){3}(?:25[0-5]|2[0-4][[:digit:]]|[01]?[[:digit:]][[:digit:]]?)*)
```

---
```ruby
LooksLike::GROUPS => Hash
```
A nested hash of groups of their subsets, auto-built from `PATTERNS`
Updated automatically when `register` is called
```ruby
require 'looks_like'

LooksLike::GROUPS[:date]
# => {:iso_8601=>[:date_iso], :us=>[:date_us], :eu=>[:date_eu], :long=>[:date_long], :short=>[:date_short]}
```

---

### Contains? Method
```ruby
LooksLike.contains?(text, match: nil) => true || false
```
Checks if a pattern exists anywhere within the string. Unlike the `?` detection methods which require a full string match, `contains?` matches substrings.

#### Parameters
`text`(String): The string to search within
**Match could either be a Symbol a Hash or an Array**
`match:`(Symbol): The group to scan for
`match:`(Hash): `{ group: :subset }` to narrow a specific subset
`match:`(Array): multiple groups, returns a Hash of results per group

#### Examples
```ruby
require 'looks_like'

LooksLike.contains?("contact foo@bar.com or baz@qux.com", match: :email)
# => true

LooksLike.contains?("dump bG9va3NfbGlrZQo= and abc123", match: {encoded: :base64})
# => true

LooksLike.contains?("foo@bar.com uses ip 192.168.1.1", match: [:email, :ip])
# => true

LooksLike.contains?("hello world", match: :email)
# => false
```

#### Difference from `?` methods
```ruby
require 'looks_like'

LooksLike.email?("contact foo@bar.com or baz@qux.com")
# => false
LooksLike.contains?("contact foo@bar.com or baz@qux.com", match: :email)
# => true
```

## Conventions
`group_subset` **naming rule**
Every pattern in `PATTERNS` must follow the `group_subset` naming convention. This is not just a style choice. It is what the library depends on for:
- Auto building `GROUPS` from `PATTERNS`
- Resolving group and subset in `register` at runtime
- Keeping `PATTERNS` as the single source of truth.

### Valid Names
```ruby
:date_iso_8601      # group: :date,    subset: :iso_8601
:email_basic   # group: :email,   subset: :basic
:encoded_jwt   # group: :encoded  subset: :jwt
```

### Invalid Names
```ruby
:ipv4      # No underscore (can't resolve group and subset)
:base64    # No group prefix
:email     # No subset
```
Patterns that don't follow will either be raised or silently missclassified

---

## EXAMPLES
### Classify an unknown CSV column
```ruby
require 'looks_like'

rows.each do |row|
  row.each do |field|
    puts "#{field} looks like: #{LooksLike.what(field)}"
  end
end
```

---

### Scanning file
```ruby
require 'looks_like'

file = File.read("file.txt")
emails = LooksLike.extract(file, match: :email)
ips = LooksLike.extract(file, match: :ip)
tokens = LooksLike.extract(file, match: :encoded)

puts "Found #{emails.length} emails, #{ips.length} IPs, #{tokens.length} tokens"
```

---

### Flag Hunting
```ruby
require 'looks_like'

output = `./challenge.txt`
flags = LooksLike.extract(output, match: :flag)
puts flags.first
```

---

### Runtime Extensions
```ruby
require 'looks_like'

LooksLike.register(:crypto_bitcoin, /[13][a-km-zA-HJ-NP-Z1-9]{25,34}/)
LooksLike.register(:crypto_p2pkh, /[3][a-km-zA-HJ-NP-Z1-9]{25,34}/)
LooksLike.register(:crypto_p2sh, /[1][a-km-zA-HJ-NP-Z1-9]{25,34}/)

puts LooksLike.crypto?("3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy")

addresses  = LooksLike.extract(user_input, match: :crypto)
```

Built-in patterns can also be overwritten
```ruby
require 'looks_like'

puts LooksLike.date?("23-02-29", subset: :iso_8601)
# => false

LooksLike.register(:date_iso_8601, /[[:digit:]]{2}-(0?[1-9]|1[0-2])-[[:digit:]]{2}/)
puts LooksLike.date?("23-02-29", subset: :iso_8601)
# => LooksLike: overwriting existing pattern date_iso_8601
# => true
```




## Supported Patterns


## Built-in Groups
| Group | Includes |
|-------|---------|
| `:ascii` | `:digit`, `:alpha`, `:upper`, `:lower`, `:alphanum`, `:hex`, `:punct` |
| `:unicode` | `:digit`, `:alpha`, `:upper`, `:lower`, `:alphanum`, `:punct`, `:print`, `:graph` |
| `:encoded` | `:base64`, `:base6url`, `:base32`, `:hex`, `:binary`, `:jwt` |
| `:flag` | `:standard`, `:ctf`, `:htb`, `:thm`, `:picoctf` |
| `:date` | `:iso_8601`, `:us`, `:eu`, `:long`, `:short` |
| `:time` | `:h12`, `:h24`, `:zone` |
| `:phone` | `:local`, `:us`, `:intl` |
| `:numeric` | `:integer`, `:decimal` |
| `:network` | `:mac`, `:uuid` |
| `:card` | `credit` |
| `:email` | `:basic` |
| `:ip` |  `:v4`, `:v6` |
| `:url` | `:http`|









