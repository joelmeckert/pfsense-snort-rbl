# pfsense-snort-rbl
Real-time blacklist update script, parses and removes local and broadcast/multicast IP ranges

## Installation
- Modify script
  - Add URLs and filenames for real-time blacklists
  - Comment out where not in use, iprepx and curl lines
- Transfer/copy file to pfSense firewall at /usr/local/bin/snort-rbl.sh
- Set the permission and user/group ownership
```
chmod 755 /usr/local/bin/snort-rbl.sh
```
- Install pfSense cron package
- Services => cron => Add
- Enter
  - minute, hour, *, *, *
  - user (root)
  - /usr/local/bin/snort-rbl.sh
  
  ## Snort
  - Services => Snort => IP Lists => add the IP lists after downloading the lists once with /usr/local/bin/snort-rbl.sh
  - Interface => IP Rep => Add the blacklist files
  
  ## Notes
  It is not recommended to run the update process frequently, daily is best, as many list providers are hammered by frequent updates. Usually daily will suffice, I had been using FireHOL.
