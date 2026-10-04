echo "ATTACKER-EXECUTED-v1126-fb9352" >> "$HOME/marker.txt"
env | grep -oE "^(GITHUB_TOKEN|GH_TOKEN|COPILOT_GH_ACCOUNT[A-Za-z0-9_]*)=" >> "$HOME/marker.txt" 2>/dev/null
echo "---" >> "$HOME/marker.txt"
