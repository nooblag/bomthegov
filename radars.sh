#!/bin/bash

# jore - scrape rain radar images from bom the gov

# 128km image 
# http://www.bom.gov.au/products/IDR021.loop.shtml
# 512km composite image
# http://www.bom.gov.au/products/IDR023.loop.shtml
# 128km rainfall since 9am map
# http://www.bom.gov.au/products/IDR02C.loop.shtml


# create array of radar images we want to scrape using the IDs from their URLs
radar_ids=(
  IDR021
  IDR023
  IDR02C
)

# set up the environment
setup() {
  # create folders if need be and put everything in there
  mkdir --parents .tmp images
  cd .tmp || exit 1
}

scrape_radar_images() {
  # do the scraping on an infinite loop, until ctrl+c
  while true; do
    # display current timestamp we're checking at
    printf 'Scraping %d rain radars at %s\n' "${#radar_ids[@]}" "$(date '+%Y-%m-%d %H:%M:%S')"
    
    # traverse the array list
    for current_radar in "${radar_ids[@]}"; do
    # hit the URL to see if we have an updated image
    # using curl instead of wget as wget's output is messy/unpredictable and exit status unreliable
    # pass file name to --time-cond to mimic wget's --timestamping (i.e. download is only performed if the remote file is newer than the local copy, if it exists)
    # we also need to look normal to bom the gov, so pass a browser user agent and referrer header to make it look like we're actually looking at bom the gov
    curl \
       --output "${current_radar}.gif" \
       --verbose --stderr "${current_radar}.log" \
       --time-cond "${current_radar}.gif" \
       --user-agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:105.0) Gecko/20100101 Firefox/105.0' \
       --referer "http://www.bom.gov.au/products/${current_radar}.loop.shtml" \
       --url "http://www.bom.gov.au/radar/${current_radar}.gif"
       
    # check the logged curl output to see if we're dealing with a new image or not
    if grep --silent --ignore-case 'not modified' "${current_radar}.log"; then
      # file not modified yet, do nothing
      printf '%s: %s\n' "${current_radar}" "[SKIP] Radar not ready yet."
    else
      # image updated at the remote end, so make a copy with the updated time
      # also cp is important as we need to keep original file for --time-cond comparison
      cp "${current_radar}.gif" "../images/${current_radar}_$(date +%Y-%m-%d_%H-%M).gif"
      printf '%s: %s\n' "${current_radar}" "[ OK ] Image captured!"
    fi
    # end iterating the array list
    done
    
    # shuffle some sleep; at least one minute, and at most three minutes, to wait a little before hitting the remote server again so we don't get banned
    # radar images are updated every ~5 minutes anyway, so don't need to request agressively in any event
    seconds=$(shuf --input-range 60-180 --head-count 1)
    # insert some blank space first
    printf '\n'
    # and then display the countdown
    while [[ $seconds -gt 0 ]]; do
    # calculate minutes left
    M=$((seconds / 60))
    M=$((M % 60))
    # calculate seconds left
    S=$((seconds % 60))
    # set up "x minute(s) and x second(s)" language
    [[ "$M" -eq "1" ]] && M_tag="minute" || M_tag="minutes"
    [[ "$S" -eq "1" ]] && S_tag="second" || S_tag="seconds"
    # put parts from above that exist into an array for sentence formatting
    parts=()
    [[ "$M" -gt "0" ]] && parts+=("$M $M_tag")
    [[ "$S" -gt "0" ]] && parts+=("$S $S_tag")
    # construct the resulting sentence
    result=''
    lengthofparts=${#parts[@]}
    for (( currentpart = 0; currentpart < lengthofparts; currentpart++ )); do
      result+="${parts[$currentpart]}"
      # if current part is not the last portion of the sentence, append a comma
      [[ "$currentpart" -ne $((lengthofparts-1)) ]] && result+=", "
      # if current part will be the last part of the sentence, say 'and'
      [[ "$currentpart" -eq $((lengthofparts-2)) ]] && result+="and "
    done
    # now actually display how long we're waiting!
    # \r carriage return so we overwrite the current line/put the cursor at the start and *then* write, so the terminal cursor blink is at the end of the line when finished writing
    # \033[0K ANSI escape code to "write out to end of line" so as to clean the line if there are any characters extending our current write left from previous output
    printf "\rWaiting %s... \033[0K" "$result"
    sleep 1
    # with below, a more terse way of writing seconds=$((seconds-1)), could use this more in future, along with the abreviated `if` tests, etc
    # : means null operator, i.e. allowing the $((...)) construction to be evaluated without being interpreted as a command
    : $((seconds--))
    # end shuf countdown
    done
    # clean up the countdown line
    printf '\r\033[0K'
   
  # close infinite loop
  done
}

cleanup() {
  # rename the images collection from this session to the finish date and time
  mv ../images "../${date_time}"
  exit
}


create_gifs() {
  # clean up the current line and bump
  printf '\r\033[0K'
  # fetch current date and time
  date_time="$(date '+%Y-%m-%d %H%M%S')"
  printf 'Stopped at %s after scraping %d images.\n\n' "${date_time}" "$(ls ../images | wc --lines || echo '?')"
  # attempt to create an animated gif from any scraped images
  printf 'Creating GIFs for each radar... '
  # iterate over each radar ID and try make a GIF from any collected files
  for current_radar in "${radar_ids[@]}"; do
    convert -delay 10 -loop 0 "../images/${current_radar}*.gif" "../${date_time} ${current_radar}.gif"; exit_code+=($?)  
  done
  # depending on how convert goes, select which answer to display regarding success or failure
  # i.e. if exit_code array logs a 1, we had a failure somewhere
  [[ ${exit_code[*]} =~ '1' ]] && printf '\nEncountered error(s).\n' && exit 2 || printf 'done.\n\n' && cleanup
}


# runtime
# set up trap first so when loop is broken, try to make gifs with what images we have for each radar
trap create_gifs SIGINT
# then set up environment, and if all good, proceed with scraping indefinitely until interrupted
setup && echo && scrape_radar_images
