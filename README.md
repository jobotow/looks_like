# LooksLike

A ruby library for detecting patterns in strings. Tell you what a string looks like.

## Installation

```bash
gem install looks_like
```

## Usage

### Detection
Checks if a string matches a pattern anywhere:

```ruby
require 'looks_like'

LooksLike.encoded?('dW5pY29ybg==')
LooksLike.email?("foo@bar.com")
LooksLike.ip?("192.168.1.1")
LooksLike.url?("https://github.com")
LooksLike.date?("Wed, 15 May 2026")
```

### Format Narrowing
When you need to be specific about which variant
```ruby
require 'looks_like'

LooksLike.encoded?('dW5pY29ybg==', subset: :base64)
LooksLike.ip?("192.168.1.1", subset: :v4)
LooksLike.date?("2026-05-11", subset: :iso_8601)
```

---

### Scanning
Extract all matches from a given text:

```ruby
require 'looks_like'

LooksLike.extract('foo dW5pY29ybg== bar Ym9hdA==', match: :encoded)

LooksLike.extract('contact foo@bar.com or baz@qux.com', match: :email)

```

### Discovery
Find out what a string looks like:

```ruby
require 'looks_like'

LooksLike.what('dW5pY29ybg==')

LooksLike.what('hello')

```

### Extensibility
Adding patterns to or overwriting existing groups
```ruby
require 'looks_like'

LooksLike.register(:date_hijri, /[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}/)
LooksLike.date?("1/5/1445", subset: :hijri)
```

---

### LooksLike.want_more?([READ_DOCUMENTATION](DOCUMENTATION.md))

---

## Best Use Cases
**As a classifier**
```ruby
require 'looks_like'

LooksLike.what('dW5pY29ybg==')
# => {:unicode=>[:print, :graph], :encoded=>[:base64, :base64_url]}
```

**As a filter**
```ruby
require 'looks_like'

#...
next unless LooksLike.date?(value)
Date.parse(value)
```

**As an extractor**
```ruby
require 'looks_like'

LooksLike.extract(File.read("my_file.txt"))
```

**As a detector**
```ruby
require 'looks_like'

LooksLike.contains?(log, match: :flag)
# => true
```

**As a recon helper**
```ruby
require 'looks_like'

LooksLike.extract(log, match: [:ip, :cve, :phone])
# => true
```


## Design Philosophy
`looks_like` quickly finds plausible patterns in text using lightweight regex, so you can decide what to do next, whether you are classifying one unknown value, scanning a file for patterns, filtering a pipeline, or doing recon on untrusted output.

For strict validation(MX Validation, etc.), consider purpose-built libraries like **valid_email2** or **Phonelib**

