# Pattern Writing Guide For LooksLike
This guide explains how to write good patterns that work with LooksLike's matching system

## The Golden Rule: NO ANCHORS
**Never use `^`, `$`, `\A`, `\z` in your pattern**

### Why Should I Avoid Anchors?
LooksLike adds boundaries at runtime based on the `by:` parameter.
Defining your patterns without anchors makes LooksLike flexible matching system just work.

**Each `by:` parameter value and what it does**                     
**by: :word**  `/(?<!\S)(#{pattern})(?!\S)/`                
**by: :line**  `/^(#{pattern})$/`                   
**by: :exact** `/\A(#{pattern})\z/`                         
**by :free**   `/#{pattern}/`                   

## Pattern Naming Conventions
Naming should follow the `group_subset` naming rule
This is not just a style choice. It is what the library depends on for:
- Auto building `GROUPS` from `PATTERNS` or custom pattern
- Resolving group and subset in `register` at runtime
- Keeping `PATTERNS` as the single source of truth.

### Valid Names
```ruby
:date_iso_8601     # group: :date,    subset: :iso_8601
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

## PATTERN QUALITY GUIDELINES

### DO: Be Specific and Explicit Enough

- **Digits: Use** `[0-9]` **instead of** `\d`
- **Digits: Use** `[^0-9]` **instead of** `\D`
- **Hex: Use** `[A-Fa-f0-9]` **instead of** `\h`
- **Hex: Use** `[^A-Fa-f0-9]` **instead of** `\H`
- **Letters: Use** `[A-Za-z0-9_]`  **instead of** `\w`
- **Letters: Use** `[^A-Za-z0-9_]`  **instead of** `\W`
- **Quantifiers: State exact length when known** `[A-Za-z]{12}` **instead of** `[A-Za-z]+`
- **For patterns that needs unicodes, POSIX classes are useful for that**
- **Everything else if accepted**

## False Positive Or Limitations
Every pattern has its limitations or false positive risk.
Always tighten regex or document it.
A pattern that matches too broadly is worse than a missing pattern
**Ignore if regex tightening can't solve limitations**

```ruby
#hash_md5: 32 hex chars
# collides with: ntlm hashes
```

## Meta Format
Every pattern or group of patterns needs a meta comment above it
```ruby
# Author(s): @yourname
# Reviewed by: @reviewer (one or more)
# Limitations: describe known weakness (negligible if regex tightening can't solve it)
# Source: Link if borrowed or adapted
```
**Example**
```ruby
# ========== HASHES ===============
# Author: @new_contrib
# Source: www.no_ones_site.com
hash_md5: /[A-Fa-f0-9]{32}/,

# ============= BITCOIN ==========
# Author: @new_contrib
# Reviewed by: @contrib
# Source: www.no_ones_site.org
btc_bitcoin: /[13][a-km-zA-HJ-NP-Z1-9]{25,34}/,
```

## Bonus 
You can test your custom patterns before adding by:
```ruby
require 'looks_like'

LooksLike.register(:test_pattern, /your_regex_pattern/)

test_data = [
    "should_match",
    "not_a_match"
    "random_text",
    "run_against_pattern"
]

test_data.each do |text|
  result = LooksLike.extract(text, match: :test_pattern, by: :free)
  puts "#{text} => #{result}"
end
```