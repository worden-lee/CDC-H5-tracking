#!/usr/bin/env bash -v

## cron script for daily download of H5 presence/absence data

export TZ='America/Los_Angeles'

date

## pull whatever changes have been pushed to the website
## if there are unpushed local changes, this will fail
## and the push to the website will fail
git pull

## download the data from CDC's JSON endpoints and write into a CSV file
## titled cdc-h5-$(DATES).csv where $(DATES) is the "map time period"
## denoting the week covered by the data
Rscript dl-cdc-h5.r

## commit it to git
git add cdc-h5-data/cdc-h5-*.csv && git commit -a -m 'automated commit of latest data' && git push

