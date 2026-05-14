module LooksLike
  module Blocks
    #these regexes are kept as modules for readability.
    module Base
      DIGIT = '[[:digit:]]'
      BIN = '[01]'
      HEX = '[[:xdigit:]]'
      HEXBYTE = '[[:xdigit:]]{2}'
      HEXPREFIX= '(?:0x[[:xdigit:]]+)'
    end
      
    module Date
      YEAR  = '\d{4}'
      YEAR2 =  '\d{2}'
      MONTH30 = '(?:04|06|09|11)'
      MONTH31 = '(?:01|03|05|07|08|12)'
      FEB = '02'
      FEB_DAY =  '(?:0[1-9]|[12][0-9])'
      DAY30 =  '(?:0[1-9]|[12][0-9]|30)'
      DAY31 = '(?:0[1-9]|1\d|2\d|3[01])'
      
    end

    module Time
      HOUR24 = '(?:[01][0-9]|2[0-3])'
      HOUR12 = '(?:0?[1-9]|1[0-2])'
      MINUTE = '[0-5][0-9]'
      SECOND = '[0-5][0-9]'
      AMPM = '(?:AM|PM|am|pm)'
    end
    
    module Network
      OCTET = '(?:25[0-5]|2[0-4]\d|[01]?\d\d?)'
      HEXBYTE = '[[:xdigit:]]{2}'
    end

    module Encoded
      B64 = '[A-Za-z0-9+\/]'
      B64URL = '[A-Za-z0-0\-_]'
      #HEX = '[A-Fa-f0-9]'
    end
  end
end