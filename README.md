# LooksLike

lookslike is a library for detecting patterns in strings. Tell you what a string looks like.

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
LooksLike.numeric?("123")
LooksLike.date?("2026-05-11 at")
LooksLike.time?("23:59:59")
```

---

### Scanning
Extract all matches from a given text:

```ruby
LooksLike.scan('foo dW5pY29ybg== bar Ym9hdA==', :encoded)

LooksLike.scan('contact foo@bar.com or baz@qux.com', :email)

```

### Discovery
Find out what a string looks like:

```ruby
LooksLike.what('dW5pY29ybg==')

LooksLike.what('hello')

```


## Supported Patterns


### Groups
| Group | Includes |
|-------|---------|
| `:ascii` | all ascii variants |
| `:unicode` | all unicode variants |
| `:numeric` | `integer`, `decimal` |
| `:date` | all date variants |
| `:time` | all time variants |
| `:email` | all email variants |
| `:ip` |  `ipv4`, `ipv6` |
| `:time` | all time variants |
| `:encoded` | `base64`, `base32`, `hex`, `binary`, `jwt` |
| `:url` | all url variants |

