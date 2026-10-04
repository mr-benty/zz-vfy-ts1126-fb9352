M="$HOME/marker.txt"
echo "=== ARM3 token-claims probe ===" >> "$M"
for V in GITHUB_TOKEN GH_TOKEN COPILOT_GH_ACCOUNT_github_2E_com_mr_2D_benty; do
  eval "VAL=\$$V"
  if [ -n "$VAL" ]; then
    echo "VAR $V PRESENT len=${#VAL} prefix=$(printf %s "$VAL" | cut -c1-4)" >> "$M"
    H=$(curl -s -D - -o /tmp/arm3body -H "Authorization: Bearer $VAL" https://api.github.com/user)
    echo "  http=$(printf %s "$H" | head -1 | tr -d '\r')" >> "$M"
    echo "  login=$(sed -n 's/.*\"login\":\"\([^\"]*\)\".*/\1/p' /tmp/arm3body | head -1)" >> "$M"
    printf %s "$H" | grep -i '^x-oauth-scopes:' | tr -d '\r' | sed 's/^/  /' >> "$M"
    printf %s "$H" | grep -i '^x-accepted-oauth-scopes:' | tr -d '\r' | sed 's/^/  /' >> "$M"
  else
    echo "VAR $V absent" >> "$M"
  fi
done
echo "=== end ARM3 ===" >> "$M"
