# Iptables Essentials: общие правила и команды брандмауэра
# https://www.digitalocean.com/community/tutorials/iptables-essentials-common-firewall-rules-and-commands
# become root
sudo -i

# flush all existing rules
iptables -F

# Accept traffic from existing connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# accept SSH connections
iptables -A INPUT -p tcp --dport ssh -j ACCEPT

# allow connections from our servers
iptables -A INPUT -i eth1 -p tcp -s 000.000.000.000  --dport 5432 -j ACCEPT

# drop the remaining traffic
iptables -A INPUT -j DROP

# listen for loopback traffic
iptables -I INPUT 1 -i lo -j ACCEPT

# list rules
iptables -L -v

# store iptables rules
iptables-save > /etc/iptables.rules

# finish root session
exit


Да, все оказалось вообще тривиально: 
firewall-cmd --add-port=5432/tcp --permanent
Видимо, когда я делал через iptable, напутал что-то с ipадресом.
Служба firewalld оказалась в этом плане более дружелюбной
