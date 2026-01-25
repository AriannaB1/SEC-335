
for ip in {2..50}; do

parameter=$(nmap -n -vv -sn "10.0.5.${ip}" | grep "Host is up")

if [ ! -z "$parameter" ]; then
 
echo "10.0.5.${ip}"
fi

done 

