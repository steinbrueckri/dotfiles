#!/usr/bin/env bash

domain=""
output_mode="full"
exit_code=0

GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Parse args
for arg in "$@"; do
  case $arg in
    --json)
      output_mode="json"
      shift
      ;;
    --short)
      output_mode="short"
      shift
      ;;
    *)
      domain="$arg"
      ;;
  esac
done

if [[ -z "$domain" ]]; then
  echo "❌ Please provide a domain."
  echo "Usage: ./mailcheck.sh [--json|--short] domain.com"
  exit 99
fi

# dig with timeout
dig_opts="+short +time=2 +tries=1"

spf_ok=0
dkim_ok=0
dmarc_ok=0
dnssec_ok=0
mta_sts_ok=0
mx_records=()
dkim_records=()

# MX
while read -r mx; do
  mx_records+=("$mx")
done < <(dig $dig_opts MX "$domain" | sort -n)

# SPF
spf=$(dig $dig_opts TXT "$domain" | grep 'v=spf1')
[[ -n "$spf" ]] && spf_ok=1 || exit_code=$((exit_code + 1))

# DKIM
common_selectors=(default mail google selector1 dkim dkim1 dkim2 smtp mandrill sparkpost amazonses)
for sel in "${common_selectors[@]}"; do
  dkim=$(dig $dig_opts TXT "${sel}._domainkey.${domain}")
  if [[ -n "$dkim" ]]; then
    dkim_ok=1
    dkim_records+=("${sel}|${dkim}")
  fi
done
[[ $dkim_ok -eq 0 ]] && exit_code=$((exit_code + 2))

# DMARC
dmarc=$(dig $dig_opts TXT "_dmarc.${domain}")
[[ -n "$dmarc" ]] && dmarc_ok=1 || exit_code=$((exit_code + 4))

# DNSSEC
dnssec=$(dig +dnssec "$domain" SOA +time=2 +tries=1)
[[ "$dnssec" == *"RRSIG"* ]] && dnssec_ok=1

# MTA-STS
mta_sts=$(dig $dig_opts TXT "_mta-sts.${domain}")
[[ -n "$mta_sts" ]] && mta_sts_ok=1

# Output
if [[ "$output_mode" == "json" ]]; then
  echo -n "{"
  echo -n "\"domain\": \"$domain\", "
  echo -n "\"spf\": $spf_ok, "
  echo -n "\"dkim\": $dkim_ok, "
  echo -n "\"dmarc\": $dmarc_ok, "
  echo -n "\"dnssec\": $dnssec_ok, "
  echo -n "\"mta_sts\": $mta_sts_ok, "
  echo -n "\"mx\": ["
  for i in "${!mx_records[@]}"; do
    printf "\"%s\"%s" "${mx_records[$i]}" $([[ $i -lt $((${#mx_records[@]} - 1)) ]] && echo ", " || echo "")
  done
  echo -n "], \"dkim_records\": ["
  for i in "${!dkim_records[@]}"; do
    sel=$(echo "${dkim_records[$i]}" | cut -d'|' -f1)
    val=$(echo "${dkim_records[$i]}" | cut -d'|' -f2- | sed 's/"/\\"/g')
    printf "{\"selector\": \"%s\", \"record\": \"%s\"}%s" "$sel" "$val" $([[ $i -lt $((${#dkim_records[@]} - 1)) ]] && echo ", " || echo "")
  done
  echo "]}"
  exit $exit_code
fi

if [[ "$output_mode" == "short" ]]; then
  echo -n "SPF: $([[ $spf_ok -eq 1 ]] && echo ✅ || echo ❌) "
  echo -n "DKIM: $([[ $dkim_ok -eq 1 ]] && echo ✅ || echo ❌) "
  echo -n "DMARC: $([[ $dmarc_ok -eq 1 ]] && echo ✅ || echo ❌)"
  echo
  exit $exit_code
fi

# Full Output
echo "🔍 Checking domain: $domain"

echo ""
echo "📮 MX Records:"
for mx in "${mx_records[@]}"; do
  echo "   📫 $mx"
done

echo ""
echo "📄 SPF Record:"
if [[ $spf_ok -eq 1 ]]; then
  echo "   ${GREEN}✅ $spf${RESET}"
else
  echo "   ${RED}⚠️  No SPF record found${RESET}"
  echo "      ℹ️  SPF helps prevent spoofed emails from your domain (anti-spam)."
fi

echo ""
echo "🔏 DKIM Records:"
if [[ $dkim_ok -eq 1 ]]; then
  for rec in "${dkim_records[@]}"; do
    sel=$(echo "$rec" | cut -d'|' -f1)
    val=$(echo "$rec" | cut -d'|' -f2-)
    echo "   ${GREEN}✅ Selector '${sel}':${RESET}"
    echo "      $val"
  done
else
  echo "   ${RED}⚠️  No DKIM records found for common selectors${RESET}"
  echo "      ℹ️  DKIM signs your emails with a cryptographic signature (authenticity)."
fi

echo ""
echo "🛡️ DMARC Record:"
if [[ $dmarc_ok -eq 1 ]]; then
  echo "   ${GREEN}✅ $dmarc${RESET}"
else
  echo "   ${RED}⚠️  No DMARC record found${RESET}"
  echo "      ℹ️  DMARC builds on SPF & DKIM to define policy and reporting (anti-abuse)."
fi

echo ""
echo "🔐 DNSSEC:"
if [[ $dnssec_ok -eq 1 ]]; then
  echo "   ${GREEN}✅ DNSSEC is configured${RESET}"
else
  echo "   ${YELLOW}⚠️  DNSSEC not configured${RESET}"
  echo "      ℹ️  DNSSEC ensures DNS records can't be tampered with (integrity & trust)."
fi

echo ""
echo "📘 MTA-STS:"
if [[ $mta_sts_ok -eq 1 ]]; then
  echo "   ${GREEN}✅ MTA-STS TXT record found${RESET}"
else
  echo "   ${YELLOW}⚠️  No MTA-STS TXT record${RESET}"
  echo "      ℹ️  MTA-STS forces secure mail transport (TLS) to your domain."
fi

exit $exit_code
