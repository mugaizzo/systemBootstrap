#!/bin/bash
set -e

echo "[+] Installing Ansible and Git..."
if ! [ -x "$(command -v ansible)" ] && ! [ -x "$(command -v git)" ]; then
  sudo pacman -Sy --noconfirm ansible git base-devel
fi

if [ "$GITHUB_TOKEN" = "" ]; then
  echo "[!] GITHUB_TOKEN is not set. Please export it first."
  exit 1
fi

echo "[+] Cloning your private repo..."
git clone https://"$GITHUB_TOKEN"@github.com/mugaizzo/systemAnsible.git ~/systemAnsible

echo "[+] Changing directory"
cd ~/systemAnsible

echo "[+] Running Ansible playbook locally..."
ansible-playbook -i inventory/hosts playbook.yml

echo "[✓] Done! Your system is now configured."
