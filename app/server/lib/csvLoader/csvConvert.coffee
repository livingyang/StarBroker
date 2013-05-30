csv_to_json = (a_csv, a_del, a_newline) ->
  
  # Default values
  csv = a_csv
  del = (if (typeof a_del isnt "string") then "," else a_del)
  nl = (if (typeof a_newline isnt "string") then /\r\n|\r|\n/ else a_newline)
  
  return [] if typeof csv isnt "string" or csv.split(nl).length < 2

  # Start parsing
  result = [] # result array
  lines = csv.split(nl) # split csv data into lines using newline var
  headers = lines.shift().split(del) # split the headers into an array by the specified delimiter
  
  # Loop through the lines array
  for lineStr, ii in lines
    line = lineStr.split del

    o = {} # object for keeping the data
    # If there is only one or less entry in the csv data, it is not a valid line so just skip it - the main purpose is to avoid blank end-rows for example
    if line.length isnt headers.length
      console.log "Error in CSV; Line #{ii + 2}"
      continue
    
    # Add the line's data to the container object and trim the strings for unneccesary whitespace
    for data, j in line
      o[headers[j]] = data
    
    # Push the resulting object to the result array
    result.push o
  
  # Return the JSON object
  result

@csv_to_json = csv_to_json