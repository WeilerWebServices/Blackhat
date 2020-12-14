curl "https://api.github.com/orgs/nmap/repos?per_page=1000" | 
grep -o 'git@[^"]*' | xargs -L1 git clone

git clone https://github.com/nmap/nmap.git
git clone https://github.com/nmap/npcap.git
git clone https://github.com/nmap/ncrack.git
git clone https://github.com/nmap/libpcap.git
git clone https://github.com/nmap/tcpdump.git
