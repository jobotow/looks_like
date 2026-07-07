module LooksLike


    #these regexes are kept as blocks for false positives
  BASE_HEXBYTE = '[[:xdigit:]]{2}'
  BASE_HEXPREFIX= '(?:0x[[:xdigit:]]+)'

  DATE_YEAR4  = '\d{4}'
  DATE_YEAR2 =  '\d{2}'
  DATE_MONTH30 = '(?:04|06|09|11)'
  DATE_MONTH31 = '(?:01|03|05|07|08|12)'
  DATE_MONTHNAME31 = '(?:Jan|Mar|May|Jul|Aug|Oct|Dec|January|March|May|July|August|October|December)'
  DATE_MONTHNAME30 = '(?:Apr|Jun|Sep|Nov|April|June|September|November)'
  DATE_FEBMONTH = 'Feb'
  DATE_FEB = '02'
  DATE_FEB_DAY =  '(?:0[1-9]|[12][0-9])'
  DATE_DAY30 =  '(?:0[1-9]|[12][0-9]|30)'
  DATE_DAY31 = '(?:0[1-9]|1\d|2\d|3[01])'
  DATE_DAYNAME = '(?:Mon|Tue|Wed|Thu|Fri|Sat|Sun|mon|tue|wed|thu|fri|sat|sun|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday)'
      
  TIME_HOUR24 = '(?:[01][0-9]|2[0-3])'
  TIME_HOUR12 = '(?:0?[1-9]|1[0-2])'
  TIME_MIN_SEC = '[0-5][0-9]' # same as sec
  TIME_AMPM = '(?:AM|PM|am|pm)'

  NETWORK_OCTET = '(?:25[0-5]|2[0-4]\d|[01]?\d\d?)'

  ENCODED_B64 = '[A-Za-z0-9+\/]'
  ENCODED_B64URL = '[A-Za-z0-9\-_]'
 
  CURRENCY_NAME =  '(?:AFN|ARS|AWG|AUD|AZN|BSD|BHD|BBD|BDT|BYN|BZD|BMD|BOB|BAM|BWP|BGN|
    BRL|BND|KHR|CAD|KYD|CLP|CNY|COP|CRC|CUP|CZK|DKK|DOP|XCD|EGP|USD|BTC|EUR|FKP|FJD|GHS|GHC|GIP|GTQ|
    GGP|GYD|HKD|HUF|ISK|INR|IDR|IRR|IMP|ILS|JMD|JPY|JEP|KZT|KES|KPW|KRW|KGS|KWD|LAK|LBP|LRD|MKD|MYR|
    MUR|MXN|MNT|MAD|MZN|NAD|NPR|ANG|NZD|NIO|NGN|NOK|OMR|PKR|PAB|PYG|PEN|PHP|PLN|QAR|RON|RUB|SHP|SAR|
    RSD|SCR|SGD|SBD|SOS|ZAR|LKR|SEK|CHF|SRD|SYP|TWD|THB|TTD|TRY|TVD|UAH|AED|GBP|USD|UYU|UZS|VES|VND|
    YER|ZWG)'

  CURRENCY_SYM =  '(?:؋|ƒ|₼|৳|Br|BZ\$|\$|Bs|KM|P|лв|R\$|¥|₡|₱||Kč|kr|RD\$|₿|€|¢|£|Q|
  L|Ft|kr|₹|Rp|﷼|₪|J\$|¥|₸|KSh|₩сом|د.ك |KD|₭|ден|RM|₨|₮|د.م|MT|₨|ƒ|C\$|₦
  |kr|﷼|₨|B/.|₲|S/.|₱|zł|﷼|lei|₽|£|﷼|дин.|₨|Sh|R|₨|kr|CHF|NT\$|฿|TT\$|₺|₴|د.\إ|\$U|soʻm|Bs.|₫|
  |﷼|ZWG|.د.ب)'

       
      





  
  PATTERNS = {
    #other groups to add [:secrets, :hashes :cve :currency, :wallet, :log, :coordinates, :command, :date_time, :version, :path, :useragent, :error]
    # Tighten regex to minimize false positives
    # Needs regex tightening: [:currency, :url, :ip_v6, :network_mac, :network_uuid, :phone_variants, :time_zone]

    # =============== ASCII ===============
    ascii_digit: /[0-9]+/,
    ascii_alpha: /[A-Za-z]+/,
    ascii_alphanum: /[A-Za-z0-9]+/,
    ascii_lower: /[a-z]+/,
    ascii_upper: /[A-Z]+/,
    ascii_space: /[ \t]+/,
    ascii_punct: /[!@#\$%\^&*()_\-=\+~`{|}\[\]\\';:"\/?.>,<]+/,
    ascii_hex: /[[:xdigit:]]+/,



    # =============== POSIX (UNICODE) ===============
    unicode_digit: /[[:digit:]]+/,
    unicode_alpha: /[[:alpha:]]+/,
    unicode_alphanum: /[[:alnum:]]+/,
    unicode_lower: /[[:lower:]]+/,
    unicode_upper: /[[:upper:]]+/,
    unicode_space: /[[:space:]]+/,
    unicode_print: /[[:print:]]+/,
    unicode_graph: /[[:graph:]]+/,
    unicode_punct: /[[:punct:]]+/,


    # ==================== ENCODING ================
    encoded_base64: /(?:#{ENCODED_B64}{4})*(?:#{ENCODED_B64}{2}==|#{ENCODED_B64}{3}=)?/, 
    #/(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=)?/,
    encoded_base64_url: /(?:#{ENCODED_B64URL}{4})*(?:#{ENCODED_B64URL}{2}==|#{ENCODED_B64URL}{3}=)?/,
    #/(?:[A-Za-z0-9+\-_]{4})*(?:[A-Za-z0-9+\-_]{2}==|[A-Za-z0-9+\-_]{3}=)?/,
    encoded_base32: /[A-Z2-7]+=*/,
    encoded_hex: /[[:xdigit:]]+/,
    encoded_binary: /[01]{6,8}/,
    encoded_jwt: /#{ENCODED_B64URL}+\.#{ENCODED_B64URL}+\.#{ENCODED_B64URL}*/,
    #/[A-Za-z0-9\-_]+\.[A-Za-z0-9\-_]+\.[A-Za-z0-9\-_]*/,


    # ==================== FLAGS ================
    flag_standard: /[Ff][Ll][Aa][Gg]\{[^}]+\}/,
    flag_ctf: /[Cc][Tt][Ff]\{[^}]+\}/,
    flag_htb: /HTB\{[^}]+\}/,
    flag_thm: /THM\{[^}]+\}/,
    flag_picoctf: /picoCTF\{[^}]+\}/,

    # ==================== FILE MAGIC BYTES ===================
    magic_pdf: /%PDF-[0-9]+\.[0-9]+/,
    # %PDF-1.4
    magic_png: /\x89PNG\x0D\x0A\x1A\x0A/n,
    magic_elf: /\x7ELF/n,
    magic_zip: /PK\x03\x04/n,
    magic_jpg: /\xFF\xD8\xFF/n,
    magic_gzip: /\x1F\x8B\x08/n,
    magic_bmp: /BM[^\x00-\x1F]{4}/n,
    magic_rar: /Rar!\x1A\x07\x00/n,

    # =============== CURRENCY =====================
    #Shouldn't match $ 001
    currency_common: /((#{CURRENCY_NAME}|#{CURRENCY_SYM})[0-9]+(?:\.[0-9]{2})?)/,
    # May split from "_common" to more specific variants eg. ("_dollar", "_euro")when the need arises

    # =============== VERSION ====================
    version_semver: /v?[0-9]+\.[0-9]+.[0-9]+/,
    version_calver: /[0-9]{4}\.[0-9]{2}\.[0-9]{2}/,
    version_simple: /v?[0-9]+\.[0-9]+/,


    # ================ CVE IDENTIFIERS ===================
    #cve started in 1999 so 1887 or less or 21NN years shouldn't match [Regex Tightening]
    #legacy accepts any number, some had zero padding, upper limit was 4 digits (pre 2014)
    cve_legacy: /CVE-(1999|200[0-9]|201[0-4])-[0-9]{1,4}/,

    # current format, no upper limits (2014-present).   
    cve_standard: /CVE-(201[4-9]|20[2-9][0-9])-[0-9]{4,}/,
    # CVE-YYYY-NNNN OR CVE-YYYY-NNNNN
    
    # ================= URL ===================
    url_http: /https?:\/\/[[:alnum:]\-]+(\.[[[:alnum:]]\-]+)+([\w\-\.,@?^=%&:\/~\+#]*[\w\-\@?^=%&\/~\+#])?/, #doesnt match "www" only
    #url_any: /(https?|ftp):\/\/[[:alnum:]\-]+(\.[[[:alnum:]]\-]+)+([\w\-\.,@^=%&:\/~\+#]*[\w\-\@?^=%&\/~\+#])?/,

    # ==================== EMAIL =====================
    email_basic: /[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}/,
    #email_extended: /[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}/,
    #email_detailed: /[\w\-]+(\.[\w\-]+)*@([A-Za-z0-9-]+\.)+[A-Za-z]{2,4}/,

    # =================== IP ADDRESS ==========================
	  ip_v4: /#{NETWORK_OCTET}\.#{NETWORK_OCTET}\.#{NETWORK_OCTET}\.#{NETWORK_OCTET}/,
    #/(?:(?:25[0-5]|2[0-4][[:digit:]]|[01]?[[:digit:]][[:digit:]]?)\.){3}(?:25[0-5]|2[0-4][[:digit:]]|[01]?[[:digit:]][[:digit:]]?)*/,
    ip_v6: /(?:[[:xdigit:]]{1,4}:){7}[[:xdigit:]]{1,4}/,

    # ====================== MAC ADDRESS ======================
    #mac: /(?:[[:xdigit:]]{2}:){5}[[:xdigit:]]{2}
    network_mac: /[[:xdigit:]]{2}:[[:xdigit:]]{2}:[[:xdigit:]]{2}:[[:xdigit:]]{2}:[[:xdigit:]]{2}:[[:xdigit:]]{2}/,
    network_uuid: /[[:xdigit:]]{8}-[[:xdigit:]]{4}-[[:xdigit:]]{4}-[[:xdigit:]]{4}-[[:xdigit:]]{12}/,
	  #card_credit: /(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6011[0-9]{12}|622((12[6-9]|1[3-9][0-9])|([2-8][0-9][0-9])|(9(([0-1][0-9])|(2[0-5]))))[0-9]{10}|64[4-9][0-9]{13}|65[0-9]{14}|3(?:0[0-5]|[68][0-9])[0-9]{11}|3[47][0-9]{13})*/,
    
    # =================== PHONE NUMBERS =======================
    phone_local: /[+]?[[:digit:]][\d\s-]{8,}/,
    phone_us: /(\+1)?[-.\s]?\(?[[:digit:]]{3}\)?[-.\s]?[[:digit:]]{3}[-.\s]?[[:digit:]]{4}/,
    phone_intl: /\+[[:digit:]]{1,3}[\d\s-]{7,14}/,  #phone_e164 (standard international)
    #phone_nanp
    #phone_uk
    #phone_eu
    #phone_jp
    #phone_au
    #phone_in
    #phone_br
    #phone_extension
    #phone_emergency #might add false positives to phone group, needs accurate regex tightening
  
    # ================== NUMERIC ====================
    numeric_integer: /[-\+]?(0|[1-9][[:digit:]]*)/,
    numeric_decimal: /[\+-]?[[:digit:]]+\.[[:digit:]]+/,
    numeric_hex: /(?:0x[[:xdigit:]]+)/,
  
    # ================ DATE ================
  
    date_iso_8601: /(?:#{DATE_YEAR4}-#{DATE_FEB}-#{DATE_FEB_DAY})|(?:#{DATE_YEAR4}-#{DATE_MONTH30}-#{DATE_DAY30})|(?:#{DATE_YEAR4}-#{DATE_MONTH31}-#{DATE_DAY31})/,
    # 2024-04-20
    date_iso_8601_slash: /(?:#{DATE_YEAR4}\/#{DATE_FEB}\/#{DATE_FEB_DAY})|(?:#{DATE_YEAR4}\/#{DATE_MONTH30}\/#{DATE_DAY30})|(?:#{DATE_YEAR4}\/#{DATE_MONTH31}\/#{DATE_DAY31})/,
    # 2024/04/20
    date_us: /(?:#{DATE_FEB}\/#{DATE_FEB_DAY}\/#{DATE_YEAR4})|(?:#{DATE_MONTH30}\/#{DATE_DAY30}\/#{DATE_YEAR4})|(?:#{DATE_MONTH31}\/#{DATE_DAY31}\/#{DATE_YEAR4})/,
    # 04/20/2024
    date_eu: /(?:#{DATE_FEB_DAY}\/#{DATE_FEB}\/#{DATE_YEAR4})|(?:#{DATE_DAY30}\/#{DATE_MONTH30}\/#{DATE_YEAR4})|(?:#{DATE_DAY31}\/#{DATE_MONTH31}\/#{DATE_YEAR4})/,
    # 20/04/2024
    date_eu_hyphen: /(?:#{DATE_FEB_DAY}-#{DATE_FEB}-#{DATE_YEAR4})|(?:#{DATE_DAY30}-#{DATE_MONTH30}-#{DATE_YEAR4})|(?:#{DATE_DAY31}-#{DATE_MONTH31}-#{DATE_YEAR4})/,
    # 20-04-2024
    date_long: /(#{DATE_MONTHNAME30}\s#{DATE_DAY30},\s#{DATE_YEAR4})|(#{DATE_MONTHNAME31}\s#{DATE_DAY31},\s#{DATE_YEAR4})|(#{DATE_FEBMONTH}\s#{DATE_FEB_DAY},\s#{DATE_YEAR4})/,
    #Jan 23, 2025
    date_short: /(#{DATE_DAY31}-#{DATE_MONTH31}-(#{DATE_YEAR4}|#{DATE_YEAR2}))|(#{DATE_DAY30}-#{DATE_MONTH30}-(#{DATE_YEAR4}|#{DATE_YEAR2}))|(#{DATE_FEB_DAY}-#{DATE_FEBMONTH}-(#{DATE_YEAR4}|#{DATE_YEAR2}))/,
    # 20-04-2024 or 20-04-24
    date_rfc_2822: /(?:#{DATE_DAYNAME},\s#{DATE_DAY30}\s#{DATE_MONTHNAME30}\s#{DATE_YEAR4})|(?:#{DATE_DAYNAME},\s#{DATE_DAY31}\s#{DATE_MONTHNAME31}\s#{DATE_YEAR4})|(?:#{DATE_DAYNAME},\s#{DATE_FEB_DAY}\s#{DATE_FEBMONTH}\s#{DATE_YEAR4})/,
    # Wed, 15 May 2026
   
    #date_rfc3339:

    # ===================== TIME ====================

    # Time
    #2024-01-15T14:30:00Z  
    #ISO 8601 is the internationally accepted standard for representing date and time. It uses the format YYYY-MM-DDTHH:MM:SSZ where:
    time_24: /#{TIME_HOUR24}:#{TIME_MIN_SEC}:#{TIME_MIN_SEC}/,
    #/([01][[:digit:]]|2[0-3]):[0-5][[:digit:]](:[0-5][[:digit:]])?/, # 01:30:12
    time_12: /#{TIME_HOUR12}:#{TIME_MIN_SEC}:#{TIME_MIN_SEC}\?#{TIME_AMPM}/,
    #/(0?[1-9]|1[0-2]):[0-5][[:digit:]](:[0-5][[:digit:]])?\s?(AM|PM|am|pm)/,
    time_zone: /([01][[:digit:]]|2[0-3]):[0-5][[:digit:]](:[0-5][[:digit:]])?\s?(UTC|GMT[+-][[:digit:]]{2}:[[:digit]]{2})/,

    # Datetime
=begin
ISO 8601 uses the 24-hour clock system. As of ISO 8601-1:2019, the basic format is T[hh][mm][ss] and the extended format is T[hh]:[mm]:[ss]. Earlier versions omitted the T (representing time) in both formats.

    [hh] refers to a zero-padded hour between 00 and 24.
    [mm] refers to a zero-padded minute between 00 and 59.
    [ss] refers to a zero-padded second between 00 and 60 (where 60 is only used to denote an added leap second).

So a time might appear as either "T134730" in the basic format or "T13:47:30" in the extended format. ISO 8601-1:2019 allows the T to be omitted in the extended format, as in "13:47:30", but only allows the T to be omitted in the basic format when there is no risk of confusion with date expressions. 
=end
  }

  GROUPS = PATTERNS.each_with_object({}) do |(key, _), groups|
    group, subset = key.to_s.split("_", 2).map(&:to_sym)
    groups[group] ||= {}
    groups[group][subset] = [key]
  end
    
end
