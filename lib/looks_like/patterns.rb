module LooksLike
  
  PATTERNS = {
    # =============== ASCII ===============
    ascii_digit: /[0-9]+/,
    ascii_alpha: /[A-Za-z]+/,
    ascii_alphanum: /[A-Za-z0-9]+/,
    ascii_lower: /[a-z]+/,
    ascii_upper: /[A-Z]+/,
    ascii_space: /[ \t]+/,
    ascii_punct: /[!@#\$%\^&*()_\-=+~`{|}\[\]\\';:"\/?.>,<]+/,
    ascii_hex: /(0x)?[A-Fa-f0-9]+/,



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
    base64: /(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=)?/,
    base64_url: /(?:[A-Za-z0-9+\-_]{4})*(?:[A-Za-z0-9+\-_]{2}==|[A-Za-z0-9+\-_]{3}=)?/,
    base32: /[A-Z2-7]+=*/,
    hex: /[[:xdigit:]]+/,
    binary: /[01]{6,8}/, #/([01]{6}|[01]{8})/,
    jwt: /[A-Za-z0-9\-_]+\.[A-Za-z0-9\-_]+\.[A-Za-z0-9\-_]*/,


    # ==================== FLAGS ================
    flag_standard: /[Ff][Ll][Aa][Gg]\{[^}]+\}/,
    flag_ctf: /[Cc][Tt][Ff]\{[^}]+\}/,
    flag_htb: /\AHTB\{[^}]+\}/,
    flag_thm: /\ATHM\{[^}]+\}/,
    flag_picoctf: /\ApicoCTF\{[^}]+\}/,
    
    # ================= URL ===================
    url_http: /\Ahttps?:\/\/[[:alnum:]\-]+(\.[[[:alnum:]]\-]+)+([\w\-\.,@?^=%&:\/~\+#]*[\w\-\@?^=%&\/~\+#])?/, #doesnt match "www" only
    #url_any: /(https?|ftp):\/\/[[:alnum:]\-]+(\.[[[:alnum:]]\-]+)+([\w\-\.,@^=%&:\/~\+#]*[\w\-\@?^=%&\/~\+#])?/,

    # ==================== EMAIL =====================
    email_basic: /[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}/,
    email_extended: /[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}/,
    email_detailed: /[\w\-]+(\.[\w\-]+)*@([A-Za-z0-9-]+\.)+[A-Za-z]{2,4}/,

    # =================== IP ADDRESS ==========================
	  ipv4: /(?:(?:25[0-5]|2[0-4][[:digit:]]|[01]?[[:digit:]][[:digit:]]?)\.){3}(?:25[0-5]|2[0-4][[:digit:]]|[01]?[[:digit:]][[:digit:]]?)*/,
    ipv6: /(?:[[:xdigit:]]{1,4}:){7}[[:xdigit:]]{1,4}/,

    # ====================== MAC ADDRESS ======================
    #mac: /(?:[[:xdigit:]]{2}:){5}[[:xdigit:]]{2}
    mac: /[[:xdigit:]]{2}:[[:xdigit:]]{2}:[[:xdigit:]]{2}:[[:xdigit:]]{2}:[[:xdigit:]]{2}:[[:xdigit:]]{2}/,
    uuid: /[[:xdigit:]]{8}-[[:xdigit:]]{4}-[[:xdigit:]]{4}-[[:xdigit:]]{4}-[[:xdigit:]]{12}/,
	  credit_card: /(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6011[0-9]{12}|622((12[6-9]|1[3-9][0-9])|([2-8][0-9][0-9])|(9(([0-1][0-9])|(2[0-5]))))[0-9]{10}|64[4-9][0-9]{13}|65[0-9]{14}|3(?:0[0-5]|[68][0-9])[0-9]{11}|3[47][0-9]{13})*/,
    
    # =================== PHONE NUMBERS =======================
    phone_local: /[+]?[[:digit:]][\d\s-]{8,}/,
    phone_us: /(\+1)?[-.\s]?\(?[[:digit:]]{3}\)?[-.\s]?[[:digit:]]{3}[-.\s]?[[:digit:]]{4}/,
    phone_intl: /\+[[:digit:]]{1,3}[\d\s-]{7,14}/,
  
    # ================== NUMERIC ====================
    integer: /(-|\+)?(0|[1-9][[:digit:]]*)/,
    decimal: /[+-]?[[:digit:]]+\.[[:digit:]]+/,
  
    # ================ DATE ================
    #Dates
    date_iso: /[[:digit:]]{4}-(0?[1-9]|1[0-2])-[[:digit:]]{2}/,
    date_us: /(0?[1-9]|1[0-2])(\/|-)(0?[-9]|[12][0-9]|3[01])(\/|-)([[:digit:]]{2}|[[:digit:]]{4})/,
    date_eu: /[[:digit:]]{1,2}\.[[:digit:]]{1,2}\.([[:digit:]]{2}|[[:digit:]]{4})/,
    date_long: /[[:upper:]][[:alpha:]]{2}\s[[:digit:]]{1,2},\s[[:digit:]]{4}/,
    date_short: /[[:digit:]]{1,2}-[[:digit:]]{1,2}-[[:digit]]{2,4}/,

    # ===================== TIME ====================

    # Time
=begin


    US Format: MM/DD/YYYY (e.g., 01/15/2024). Commonly used in personal and business communications in the United States, this format lists the month first, which can lead to confusion when interacting with regions using a day-first format.

    European Format: DD/MM/YYYY (e.g., 15/01/2024). Widely seen in official documents and public records across most European countries. This format prioritizes the day over the month, providing a logical chronological sequence that reduces confusion within the region.

    Asian Formats: YYYY/MM/DD (e.g., 2024/01/15). Frequently used in East Asia, including Japan, China, and South Korea. This format aligns closely with ISO standards, making it highly suitable for database entries and digital systems due to its descending order of time units.

    Middle Eastern Variations: Some countries in the Middle East adopt unique hybrids of the European and ISO formats, while others follow the Hijri calendar, which uses a completely different lunar-based system for date representation.

    Indian Format: DD-MM-YYYY (e.g., 15-01-2024). This format closely resembles the European style but uses hyphens instead of slashes and is standard for official use in India.

=end
    #2024-01-15T14:30:00Z  
    #ISO 8601 is the internationally accepted standard for representing date and time. It uses the format YYYY-MM-DDTHH:MM:SSZ where:
    time_24: /([01][[:digit:]]|2[0-3]):[0-5][[:digit:]](:[0-5][[:digit:]])?/,
    time_12: /(0?[1-9]|1[0-2]):[0-5][[:digit:]](:[0-5][[:digit:]])?\s?(AM|PM|am|pm)/,
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


  GROUPS = {
    ascii: {
      digit: [:ascii_digit],
      alpha: [:ascii_alpha],
      upper: [:ascii_upper],
      lower: [:ascii_lower],
      alphanum: [:ascii_alphanum],
      hex: [:ascii_hex],
      punct: [:ascii_punct]
    },
    unicode: {
      digit: [:unicode_digit],
      alpha: [:unicode_alpha],
      upper: [:unicode_upper],
      lower: [:unicode_lower],
      alphanum: [:unicode_alphanum],
      punct: [:unicode_punct],
      print: [:unicode_print],
      graph: [:unicode_graph]
    },
    numeric: {
      integer: [:integer],
      decimal: [:decimal]
    },

    time: {
      h12: [:time_12],
      h24: [:time_24],
      zone: [:time_zone]
    },
    date: {
      iso: [:date_iso],
      us: [:date_us],
      long: [:date_long],
      short: [:date_short],
      #rfc2822: [:date_rfc2822],
      #rfc3339: [:date_rfc3339],
      eu: [:date_eu]
    },
    ip: {
      v4: [:ipv4],
      v6: [:ipv6]
    },
    email: {
      basic: [:email_basic],
      extended: [:email_extended],
      detailed: [:email_detailed]
    },
    url: {
      http: [:url_http],
      #ftp: [:url_ftp],
      #https: [:url_https],
      #sftp: [:url_sftp]
    },
    encoded: {
      base64: [:base64],
      binary: [:binary],
      base32: [:base32],
      hex: [:ascii_hex],
      jwt: [:jwt]
    },
    flag: {
      standard: [:flag_standard],
      ctf: [:flag_ctf],
      htb: [:flag_htb],
      thm: [:flag_thm],
      picoctf: [:flag_picoctf],
      nsec: [:flag_picoctf]
    }
    #time: [:time_12, :time_24, :time_zone],
    #date: [:date_iso, :date_us, :date_long, :date_short], #date_rfc2822, date_rfc3339, date_eu
   # datetime: [:time_12, :time_24, :time_zone, :date_iso, :date_us, :date_long, :date_short],
   # phone: [:phone_local, :phone_us, :phone_intl],
   # email: [:email_simple, :email_permissive, :email_strict],
   # numeric: [:integer, :decimal],
   # ip: [:ipv4, :ipv6]
  }

 # PATTERNS = ENCODINGS.merge(CHARACTERS).merge(FORMATS).merge(NUMERICS).merge(TEMPORAL)
    
end