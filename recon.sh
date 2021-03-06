#! /bin/bash

#start script
figlet -f slant.tlf "#recon-map"
echo -e "\e[33m by: @ WebCipher101"

# check root usage
if [[ "${UID}" -eq 0 ]]
then
    echo -e "\e[32m >>> you are root ,go ahead..!!**"
else
    echo -e "\e[91m >>> warning : your not root user."
fi

sleep 2
im=${USER}

echo -e "\e[37m><><>< HEY $im i will take 10 to 15 min to complete your task ><><><"
sleep 2
# get input from user
echo -e "\e[92m >>> Enter your target domain : "

# read input or domain name
read target

# make specific directory based on domain name
mkdir $target
echo " >>> your target name is >>> $target"
sleep 2

echo -e "\e[37m          *** initial recon is started    **     "
# using nmap for port scanning
echo -e "\e[37m          *** Nmap is started    ***     "
sudo nmap -open $target >> nmap-output.txt
sleep 20

sleep 10

# whois for more info about target
echo "          *** whois lookup is started    ***       "
whois $target >> whois-output.txt

sleep 7

# nslookup for checking dnsrecord
echo "          *** nslookup is started        ***       "
nslookup $target >> dns-record.txt

sleep 7

# find emails,host,ip using theHarvester
echo "          *** theHarvester is started    ***       "
theHarvester -d $target >> theHarvester.txt

sleep 10

mypwd=${PWD}

sleep 2

#moving all outputs to specific folder
sudo mv nmap-output.txt $mypwd/$target/
sleep 2
sudo mv whois-output.txt $mypwd/$target/
sleep 2
sudo mv dns-record.txt $mypwd/$target/
sleep 2
sudo mv theHarvester.txt $mypwd/$target/

# using sslscan to find or check Heartbleed vuln
echo "          *** Checking for heartbleed    ***     "

sslscan $target >> ssloutput.txt && cat ssloutput.txt | grep "to heartbleed" | tee sslscan-output.txt

sleep 15

sudo rm -rf ssloutput.txt
sleep 2
sudo mv sslscan-output.txt $mypwd/$target/ 

sleep 7

# emoji to notify about end
figlet -f slant.tlf "DONE . ."

echo -e "\e[96m(\_/)"
echo -e "\e[96m(* *) your output saved to >>\e[91m~/$target"
echo -e "\e[96m \w/ @ webcipher101"

sleep 10

#starting subdomain enum
echo -e "\e[37m          *** subdomain enum  is started  ***       "
#echo user's input
echo -e "\e[37m>>> your domain name is $target "

# open browser and search shodan.io
URL="https://www.shodan.io/search?query=$target"; xdg-open $URL || sensible-browser $URL || x-www-browser $URL || gnome-open $URL

# open browser and search censys.io
URL="https://search.censys.io/search?resource=hosts&q=$target"; xdg-open $URL || sensible-browser $URL || x-www-browser $URL || gnome-open $URL

# finding subdomains using these tools and command

# nslookup for checking dnsrecord
echo -e "\e[37m          *** subfinder is started        ***       "
sudo subfinder -d $target -o subfinder.txt
sleep 15
echo -e "\e[37m          *** assetfinder is started      ***       "
sudo assetfinder -subs-only $target | tee assetfinder.txt
sleep 15
echo -e "\e[37m          *** findomain is started        ***       "
sudo findomain -t $target -u findomain.txt
sleep 10
echo -e "\e[37m          *** knockpy is started          ***       "
mkdir knockpy
sleep 1
sudo knockpy $target -o $mypwd/knockpy
sleep 40
echo -e "\e[37m          *** amass is started            ***       "
sudo amass enum -d $target -o amass1.txt
sleep 40
sudo amass enum -brute -active -d $target -o amass2.txt
# pop message to users
echo -e "\e[37m>>> please wait for some time im working fine ....**\e[0m"

sudo mv knockpy $mypwd/$target/
sleep 2

sudo sort subfinder.txt amass1.txt amass2.txt findomain.txt assetfinder.txt | uniq >> subdomain.txt
sleep 5
cat subdomain.txt | httpx | tee domains.txt
sleep 30
sudo rm -rf subfinder.txt amass1.txt amass2.txt findomain.txt assetfinder.txt

# url enumeration is started

echo -e "\e[37m          *** url enum is started        ***       "

cat domains.txt | waybackurls | tee url1.txt
sleep 15
cat domains.txt | gau | tee url2.txt
sleep 15
sudo sort url1.txt url2.txt | uniq >> urls.txt
sleep 10
sudo rm -rf url1.txt url2.txt
sleep 2
cat domains.txt | aquatone -out $mypwd/$target/screenshots
sleep 10
sudo mv domains.txt $mypwd/$target/
sudo rm -rf subdomain.txt
sleep 1
cat urls.txt | gf xss | tee xss.txt
sleep 1
cat urls.txt | gf ssrf | tee ssrf.txt
sleep 1
cat urls.txt | gf lfi | tee lfi.txt
sleep 1
cat urls.txt | gf redirect | tee redirect.txt
sleep 10
sudo mv urls.txt $mypwd/$target/
sudo mv xss.txt $mypwd/$target/
sudo mv ssrf.txt $mypwd/$target/
sudo mv lfi.txt $mypwd/$target/
sudo mv redirect.txt $mypwd/$target/
sleep 2

# emoji to notify about end
figlet -f slant.tlf "DONE . ."

echo -e "\e[96m(\_/)"
echo -e "\e[96m(* *) your output saved to >>\e[91m~/$target"
echo -e "\e[96m \w/ @ webcipher101"

sleep 2
im=${USER}

echo -e "\e[37m><><>< HEY $im thanks for using Recon-Map ><><><"

sleep 2

# end
