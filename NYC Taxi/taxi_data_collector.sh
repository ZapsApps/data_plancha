#!/bin/bash

# =========================================================================
# Script Name: taxi_data_collector.sh

# Description: This script grabs the download link for every parquet
# table under the Trip Record Data Download Links title:
# https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page

# Author: Sarah Zaporta
# =========================================================================


# URL bases for vehicles, month/year gets concatenated on for download
# =========================================================================

yellow_cab_url="https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_"	
green_cab_url="https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_"				# Introduced in August 2013
for_hire_vehicle_url="https://d37ci6vzurychx.cloudfront.net/trip-data/fhv_tripdata_"			# Introduced in January 2015
high_volume_fhv_url="https://d37ci6vzurychx.cloudfront.net/trip-data/fhvhv_tripdata_"			# Introduced in February 2019



# NOTE: Explicitly declared arrays here, rather than direct initialization.
# Figured that the direct indexing was appropriate for the month/year


# "months" array. 
# =========================================================================

declare -a months=(

[0]=01
[1]=02
[2]=03
[3]=04
[4]=05
[5]=06
[6]=07
[7]=08
[8]=09
[9]=10
[10]=11
[11]=12

)

# "years" array
# =========================================================================

declare -a years=(

[0]=2009
[1]=2010
[2]=2011
[3]=2012
[4]=2013
[5]=2014
[6]=2015
[7]=2016
[8]=2017
[9]=2018
[10]=2019
[11]=2020
[12]=2021
[13]=2022
[14]=2023
[15]=2024
[16]=2025

)


# Main Functionality
# NOTE: Added 5-second sleeps, so we're not getting refused connections
# =========================================================================

for year in ${years[@]};
do


  mkdir $year
  cd $year

  for month in ${months[@]};
  do

   curl -O "$yellow_cab_url$year-$month.parquet"
   sleep 5

  if (( $year >= 2013 )); then
    curl -O "$green_cab_url$year-$month.parquet"
    sleep 5
  else
    echo "no green cabs yet"
  fi


  if (( $year >= 2015 )); then
    curl -O "$for_hire_vehicle_url$year-$month.parquet"
    sleep 5
  else
    echo "no fhvs yet"
  fi


  if (( $year >= 2019 )); then
    curl -O "$high_volume_fhv_url$year-$month.parquet"
    sleep 5
  else
    echo "no hvfhvs yet"
  fi


  done

  cd ..

done
 