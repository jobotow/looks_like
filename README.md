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

### Encodings
| Pattern | Example |
|---------|---------|
| `:base64` | `dW5pY29ybg==` |

### Characters
| Pattern | Example |
|---------|---------|
| `:alpha` | `hello` |
| `:digit` | `123` |
| `:alnum` | `hello123` |
| `:hex` | `68656c6c6f` |
| `:upper` | `HELLO` |
| `:lower` | `hello` |

### Numerics
| Pattern | Example |
|---------|---------|
| `:integer` | `123` |
| `:decimal` | `3.14` |

### Temporal
| Pattern | Example |
|---------|---------|
| `:date_iso` | `2026-05-11` |
| `:date_us` | `05/11/2026` |
| `:date_long` | `May 11, 2026` |
| `:date_short` | `11-05-26` |
| `:time_24` | `23:59:59` |
| `:time_12` | `11:59 PM` |
| `:time_zone` | `23:59 UTC` |

### Formats
| Pattern | Example |
|---------|---------|
| `:email_simple` | `foo@bar.com` |
| `:email_permissive` | `foo@bar.museum` |
| `:email_strict` | `foo@bar.com` |
| `:ipv4` | `192.168.1.1` |
| `:ipv6` | `2001:db8::1` |
| `:url` | `https://github.com` |
| `:phone_us` | `(123) 456-7890` |
| `:phone_intl` | `+44 7911 123456` |
| `:mac` | `00:1A:2B:3C:4D:5E` |
| `:uuid` | `550e8400-e29b-41d4-a716-446655440000` |
| `:credit_card` | `4111111111111111` |


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

