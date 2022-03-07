if [[ $# != 1 ]] 
then
	echo "Usage: $0 Cidr"
	echo "Example: cidr_to_ip.sh 192.30.255.0/24"
	exit
fi

echo $1 > tmpfile.txt

ip=`cut -d "/" -f 1 tmpfile.txt`
mask=`cut -d "/" -f 2 tmpfile.txt`

echo $ip > tmpfile1.txt

ipw=`cut -d "." -f 1 tmpfile1.txt`
ipx=`cut -d "." -f 2 tmpfile1.txt`
ipy=`cut -d "." -f 3 tmpfile1.txt`
ipz=`cut -d "." -f 4 tmpfile1.txt`
rm tmpfile1.txt
rm tmpfile.txt

curl -s "http://magic-cookie.co.uk/cgi-bin/iplist-cgi.pl" -X POST  -d "ipw=$ipw&ipx=$ipx&ipy=$ipy&ipz=$ipz&mask=$mask" | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' > tmpfile2.txt

awk '!seen[$0]++'  tmpfile2.txt 

rm tmpfile2.txt
