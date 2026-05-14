require_relative 'blocks'
module LooksLike
  include LooksLike::Blocks
  #Base = LooksLike::Blocks::Base
  #Network = LooksLike::Blocks::Network
  #Date = LooksLike::Blocks::Date
  #Time = LooksLike::Blocks::Time
  #Encoded = LooksLike::Blocks::Encoded
  
  PATTERNS = {
    # Tighten regex to minimize false positives

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
    encoded_base64: /(?:#{Encoded::B64}{4})*(?:#{Encoded::B64}{2}==|#{Encoded::B64}{3}=)?/, 
    #/(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=)?/,
    encoded_base64_url: /(?:#{Encoded::B64URL}{4})*(?:#{Encoded::B64URL}{2}==|#{Encoded::B64URL}{3}=)?/,
    #/(?:[A-Za-z0-9+\-_]{4})*(?:[A-Za-z0-9+\-_]{2}==|[A-Za-z0-9+\-_]{3}=)?/,
    encoded_base32: /[A-Z2-7]+=*/,
    encoded_hex: /#{Base::HEX}+/,
    #/[[:xdigit:]]+/,
    encoded_binary: /#{Base::BIN}{6,8}/, #/[01]{6,8}/,
    encoded_jwt: /#{Encoded::B64URL}+\.#{Encoded::B64URL}+\.#{Encoded::B64URL}*/,
    #/[A-Za-z0-9\-_]+\.[A-Za-z0-9\-_]+\.[A-Za-z0-9\-_]*/,


    # ==================== FLAGS ================
    flag_standard: /[Ff][Ll][Aa][Gg]\{[^}]+\}/,
    flag_ctf: /[Cc][Tt][Ff]\{[^}]+\}/,
    flag_htb: /HTB\{[^}]+\}/,
    flag_thm: /THM\{[^}]+\}/,
    flag_picoctf: /picoCTF\{[^}]+\}/,
    
    # ================= URL ===================
    url_http: /https?:\/\/[[:alnum:]\-]+(\.[[[:alnum:]]\-]+)+([\w\-\.,@?^=%&:\/~\+#]*[\w\-\@?^=%&\/~\+#])?/, #doesnt match "www" only
    #url_any: /(https?|ftp):\/\/[[:alnum:]\-]+(\.[[[:alnum:]]\-]+)+([\w\-\.,@^=%&:\/~\+#]*[\w\-\@?^=%&\/~\+#])?/,

    # ==================== EMAIL =====================
    email_basic: /[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}/,
    #email_extended: /[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}/,
    #email_detailed: /[\w\-]+(\.[\w\-]+)*@([A-Za-z0-9-]+\.)+[A-Za-z]{2,4}/,

    # =================== IP ADDRESS ==========================
	  ip_v4: /#{Network::OCTET}\.#{Network::OCTET}\.#{Network::OCTET}\.#{Network::OCTET}/,
    #/(?:(?:25[0-5]|2[0-4][[:digit:]]|[01]?[[:digit:]][[:digit:]]?)\.){3}(?:25[0-5]|2[0-4][[:digit:]]|[01]?[[:digit:]][[:digit:]]?)*/,
    ip_v6: /(?:[[:xdigit:]]{1,4}:){7}[[:xdigit:]]{1,4}/,

    # ====================== MAC ADDRESS ======================
    #mac: /(?:[[:xdigit:]]{2}:){5}[[:xdigit:]]{2}
    network_mac: /#{Network::HEXBYTE}:#{Network::HEXBYTE}:#{Network::HEXBYTE}:#{Network::HEXBYTE}:#{Network::HEXBYTE}:#{Network::HEXBYTE}/,
    #/[[:xdigit:]]{2}:[[:xdigit:]]{2}:[[:xdigit:]]{2}:[[:xdigit:]]{2}:[[:xdigit:]]{2}:[[:xdigit:]]{2}/,
    network_uuid: /[[:xdigit:]]{8}-[[:xdigit:]]{4}-[[:xdigit:]]{4}-[[:xdigit:]]{4}-[[:xdigit:]]{12}/,
	  card_credit: /(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6011[0-9]{12}|622((12[6-9]|1[3-9][0-9])|([2-8][0-9][0-9])|(9(([0-1][0-9])|(2[0-5]))))[0-9]{10}|64[4-9][0-9]{13}|65[0-9]{14}|3(?:0[0-5]|[68][0-9])[0-9]{11}|3[47][0-9]{13})*/,
    
    # =================== PHONE NUMBERS =======================
    phone_local: /[+]?[[:digit:]][\d\s-]{8,}/,
    phone_us: /(\+1)?[-.\s]?\(?[[:digit:]]{3}\)?[-.\s]?[[:digit:]]{3}[-.\s]?[[:digit:]]{4}/,
    phone_intl: /\+[[:digit:]]{1,3}[\d\s-]{7,14}/,
  
    # ================== NUMERIC ====================
    numeric_integer: /(-|\+)?(0|[1-9][[:digit:]]*)/,
    numeric_decimal: /[+-]?[[:digit:]]+\.[[:digit:]]+/,
  
    # ================ DATE ================
    #Dates
    #date_iso: /[[:digit:]]{4}-(0?[1-9]|1[0-2])-(0?[1-9]|[12][0-8])/,#[[:digit:]]{2}/,j
    date_iso: /(?:#{Date::YEAR}-#{Date::FEB}-#{Date::FEB_DAY})|(?:#{Date::YEAR}-#{Date::MONTH30}-#{Date::DAY30})|(?:#{Date::YEAR}-#{Date::MONTH31}-#{Date::DAY31})/,
    date_asian: /(?:#{Date::YEAR}#{Date::FEB}\/#{Date::FEB_DAY})|(?:#{Date::YEAR}\/#{Date::MONTH30}\/#{Date::DAY30})|(?:#{Date::YEAR}\/#{Date::MONTH31}\/#{Date::DAY31})/,
    date_us: /(?:#{Date::FEB}\/#{Date::FEB_DAY}\/#{Date::YEAR})|(?:#{Date::MONTH30}\/#{Date::DAY30}\/#{Date::YEAR})|(?:#{Date::MONTH31}\/#{Date::DAY31}\/#{Date::YEAR})/,
    #/(0?[1-9]|1[0-2])(\/|-)(0?[-9]|[12][0-9]|3[01])(\/|-)([[:digit:]]{2}|[[:digit:]]{4})/,
    date_eu: /(?:#{Date::FEB_DAY}\/#{Date::FEB}\/#{Date::YEAR})|(?:#{Date::DAY30}\/#{Date::MONTH30}\/#{Date::YEAR})|(?:#{Date::DAY31}\/#{Date::MONTH31}\/#{Date::YEAR})/,
    date_indian: /(?:#{Date::FEB_DAY}-#{Date::FEB}-#{Date::YEAR})|(?:#{Date::DAY30}-#{Date::MONTH30}-#{Date::YEAR})|(?:#{Date::DAY31}-#{Date::MONTH31}-#{Date::YEAR})/,
    #/[[:digit:]]{1,2}\.[[:digit:]]{1,2}\.([[:digit:]]{2}|[[:digit:]]{4})/,
    date_long: /[[:upper:]][[:alpha:]]{2}\s[[:digit:]]{1,2},\s[[:digit:]]{4}/,
    date_short: /#{Date::DAY31}-#{Date::MONTH31}-(#{Date::YEAR}|#{Date::YEAR2})/,
    #/[[:digit:]]{1,2}-[[:digit:]]{1,2}-[[:digit]]{2,4}/,j
    #date_hijri:
    #date_iso_8601:
    #date_rfc2822:
    #date_rfc3339:

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
    time_24: /#{Time::HOUR24}:#{Time::MINUTE}:#{Time::SECOND}/,
    #/([01][[:digit:]]|2[0-3]):[0-5][[:digit:]](:[0-5][[:digit:]])?/, # 01:30:12
    time_12: /#{Time::HOUR12}:#{Time::MINUTE}:#{Time::SECOND}\?#{Time::AMPM}/,
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