# pfsense-snort-rbl
Real-time blacklist update script, parses and removes local and broadcast/multicast IP ranges

## Installation
- Modify script
  - Add URLs and filenames for real-time blacklists
  - Comment out where not in use, iprepx and curl lines
- Transfer/copy file to pfSense firewall at /usr/local/bin/rblupdate.sh
- Open a shell, set the permission and user/group ownership
```
chmod 755 /usr/local/bin/rblupdate.sh
chown root:unbound /usr/local/bin/rblupdate.sh
```
- Install pfSense cron package
- Services => cron => Add
- Enter
  - minute, hour, *, *, *
  - user (root)
  - /usr/local/bin/rblupdate.sh
  
## Snort
- Services => Snort => IP Lists => add the IP lists after downloading the lists once with /usr/local/bin/rblupdate.sh
- Interface => IP Rep => Add the blacklist files

### Suppress
- Optionally, add a snort Suppress list to rate limit events to the log, sample below
```
#(spp_reputation) reputation blacklisted, only log select entries
# if more than 20 in 300 seconds
event_filter \
    gen_id 136, sig_id 1, \
    type threshold, track by_src, \
    count 20, seconds 300
```

## Notes
- It is not recommended to run the update process frequently, daily is best
- Many list providers are hammered by frequent updates, designed for FireHOL 1-3
