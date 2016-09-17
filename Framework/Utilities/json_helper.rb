#=======================================================================================================================
# Author: Nel Pontejos
# Updated: Sept 15, 2016
#   * For processing json file
#=======================================================================================================================

require "json"

def read_json(file_name)
  file = open(file_name)
  json = file.read
  file.close
  JSON.parse(json)
end

def write_json(file_name, hash, write_mode = 'w+')
  file = open(file_name, write_mode)
  file.puts(JSON.pretty_generate(hash))
  file.close
end