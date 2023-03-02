#!/bin/gawk

# this script takes bom resource IDs and matches them against a CSV file that contains rows of their descriptive data
# merge the two data sets and then prettify the results to display them
# thanks to @SasaK for the help here

BEGIN {
  # get the $3 argument passed to merge_lists() function into a variable for awk (we have to weirdly quote it because of nested shell quoting)
  # used to test later whether we are writing matches in CSV format or displaying a pretty list to pass to `less`
  ##prettify = "'"$arg"'" # now commented out as we'll use `--assign=prettify="${3}"` in the function that passes this to `awk` itself
}

# set up prettification
function make_newline(line) {
  newline = ""
  # find the comma separated columns for each line
  split(line, all_columns)
  for (column_index in all_columns) {
    current_column = all_columns[column_index]
    # "recomposing" with formatting applied
    newline = newline " " sprintf("%-*s", all_lengths[column_index] + 3, current_column)
  }
  return substr(newline, 2)
}

# if we are going through the CSV file, take the data from CSV file and match it against the list of IDs
{
  if (NR == FNR) {
    # determine the headings of the columns
    if (NR == 1) header = $0
    # get the number of columns
    if (!column_number) column_number = NF - 1
    # determine the length of each column for prettification spacing (spacing will be based on the longest length after traversing all rows)
    for (field_index=1; field_index<NF; field_index++)
      if (length($field_index) > all_lengths[field_index]) all_lengths[field_index] = length($field_index)
    # associate lines with their IDs
    ids[$1] = $0
  } else {
    # now merge the data
    # if we get a match of an ID in the list, merge it with the matching CSV description data
    if ($1 in ids) {
      # remake the line to assemble/merge the data depending on if the result should be pretty or written to file in CSV format
      new_file = new_file "\n" ((prettify) ? make_newline(ids[$1]) : ids[$1])
    } else {
      # if ID does not have any data associated, keep it, but add empty space to the rest of its column
      empty_columns = sprintf("%s%*s", $1, column_number, " ")
      if (!prettify) gsub(" ", ",", empty_columns)
      new_file = new_file "\n" empty_columns
    }
  }
} END {
  # do the merge work
  # add headings
  if (prettify) header = make_newline(header)
  # now print all lines
  print header new_file
}
