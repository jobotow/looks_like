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
LooksLike.date?("2026-05-11")
```

### Format Narrowing
When you need to be specific about which variant
```ruby
LooksLike.encoded?('dW5pY29ybg==', subset: :base64)
LooksLike.ip?("192.168.1.1", subset: :v4)
LooksLike.date?("2026-05-11", subset: :iso)
```

---

### Scanning
Extract all matches from a given text:

```ruby
LooksLike.scan('foo dW5pY29ybg== bar Ym9hdA==', match: :encoded)

LooksLike.scan('contact foo@bar.com or baz@qux.com', match: :email)

```

### Discovery
Find out what a string looks like:

```ruby
LooksLike.what('dW5pY29ybg==')

LooksLike.what('hello')

```

### Extensibility
Adding patterns to existing groups
```ruby
LooksLike.register(:date_hijri, /[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}/)
LooksLike.date?("1/5/1445", subset: :hijri)
```

---

### LooksLike.want_more?([READ_DOCUMENTATION](DOCUMENTATION.md))

---

## Design Philosophy
`looks_like` is about classifications, not validation. It answers question `"what does this string look like"` not whether it's strictly valid. It is best suited for:
- Classifying unknown strings.
- Scanning unstructured text for patterns
- Extending with domain-specific patterns at runtime.

For strict validation, consider purpose-built libraries like **valid_email2** or **Phonelib**

