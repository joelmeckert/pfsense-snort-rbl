 #!/bin/sh

# This code is licensed under MIT license (see LICENSE for details)
# Joel Eckert, joel@joelme.ca, 2022-08-11

# Download IP lists, parse them with sed and a regular expression, and restart Snort
# Replace the list entries with the lists that you use, uncomment in URLs, reputation, and curl sections

# Requires /usr/local/etc/rc.d/snort.sh script, which may not be installed by default

# URLs to IP list(s), enter the URLs, uncomment for 2+ lists, and uncomment reputation list
list1='https://hahordaplanet.ru/badazz/file1.netset'
list2='https://haxordaplanet.ru/badazz/file2.netset'
list3='https://haxordaplanet.ru/badazz/file3.netset'

# Local path to Snort IP reputation lists
ipreppath='/var/db/snort/iprep'
iprep1="${ipreppath}/file1.netset"
iprep2="${ipreppath}/file2.netset"
iprep3="${ipreppath}/file3.netset"

# Regular expression to parse the lists and remove entries for local and broadcast CIDRs / IPs
localcidr='/(^192\.168\.([0-9]|[0-9][0-9]|[0-2][0-5][0-5])\.([0-9]|[0-9][0-9]|[0-2][0-5][0-5]).*$)|(^172\.([1][6-9]|[2][0-9]|[3][0-1])\.([0-9]|[0-9][0-9]|[0-2][0-5][0-5])\.([0-9]|[0-9][0-9]|[0-2][0-5][0-5]).*$)|(^10\.([0-9]|[0-9][0-9]|[0-2][0-5][0-5])\.([0-9]|[0-9][0-9]|[0-2][0-5][0-5])\.([0-9]|[0-9][0-9]|[0-2][0-5][0-5]).*$)|(224\.0\.0\.0\/3)/d'

# Path to the Snort script
snort='/usr/local/etc/rc.d/snort.sh'

# Determine if Snort is installed, exit if the file does not exist
if ls "$snort"
then
        echo "Downloading lists and restarting Snort"
else
        exit
fi

# Download the lists
curl "$list1" > "$iprep1" && sed -E -i '' "${localcidr}" "$iprep1"
curl "$list2" > "$iprep2" && sed -E -i '' "${localcidr}" "$iprep2"
curl "$list3" > "$iprep3" && sed -E -i '' "${localcidr}" "$iprep3"

# Restart Snort
eval "$snort" restart
