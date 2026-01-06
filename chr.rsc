# 2026-01-06 09:45:59 by RouterOS 7.20.6
# system id = iHix2j5/FpO
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=ether1-WAN
set [ find default-name=ether2 ] disable-running-check=no name=ether2-LAN
/ip hotspot profile
add hotspot-address=10.10.10.1 name=hsprof1
/ip pool
add name=dhcp_pool0 ranges=10.10.10.2-10.10.10.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether2-LAN name=dhcp1
/ip hotspot
add address-pool=dhcp_pool0 disabled=no interface=ether2-LAN name=hotspot1 \
    profile=hsprof1
/port
set 0 name=serial0
set 1 name=serial1
/ip address
add address=10.10.10.1/24 interface=ether2-LAN network=10.10.10.0
/ip dhcp-client
add interface=ether1-WAN
/ip dhcp-server network
add address=10.10.10.0/24 gateway=10.10.10.1
/ip dns
set servers=8.8.8.8
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=drop chain=forward dst-address=1.1.1.1 dst-port=443 protocol=tcp
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=accept chain=srcnat out-interface=ether1-WAN
add action=masquerade chain=srcnat src-address=10.10.10.0/24
/ip hotspot user
add name=admin
/radius
add address=35.227.71.209 service=hotspot
