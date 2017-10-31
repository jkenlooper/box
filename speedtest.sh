#!/bin/bash

# From https://www.reddit.com/r/webdev/comments/6ylmki/heres_an_easy_way_to_find_the_nearest/

echo "DigitalOcean";
for DC in nyc1 nyc2 nyc3 ams2 ams3 sfo1 sfo2 sgp1 lon1 fra1 tor1 blr1; do
  echo "$DC: $(ping -i .2 -c 75 -q speedtest-$DC.digitalocean.com | awk -F/ '/^round|^rtt/{print $5}')";
done | sort -n -k2

echo "AWS EC2";
for DC in ap-northeast-1 ap-south-1 ap-southeast-1 ap-southeast-2 eu-central-1 eu-west-1 eu-west-2 sa-east-1 us-east-1 us-west-1 us-west-2; do
  echo "$DC: $(ping -i .2 -c 75 -q ec2.$DC.amazonaws.com | awk -F/ '/^round|^rtt/{print $5}')";
done | sort -n -k2
