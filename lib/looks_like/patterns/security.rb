#security patterns [hashes, crypto wallets, flags, payloads]
# ============================================
# Security Patterns
# Authors: @jobotow
# Reviewed: @jobotow
# Last updated: 2026-05-16
# ============================================

module LooksLike
  SECURITY_PATTERNS = {
    # ========= HASHES ============
    # Author: @jobotow
    # Source: 
    hash_md5: /[A-Fa-f0-9]{32}/,

    # ==================== FLAGS ================
    # Author: @jobotow
    # Source:
    flag_standard: /[Ff][Ll][Aa][Gg]\{[^}]+\}/,
    flag_ctf: /[Cc][Tt][Ff]\{[^}]+\}/,
    flag_htb: /HTB\{[^}]+\}/,
    flag_thm: /THM\{[^}]+\}/,
    flag_picoctf: /picoCTF\{[^}]+\}/,
  }
end