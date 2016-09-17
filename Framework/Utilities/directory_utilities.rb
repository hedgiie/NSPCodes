#=======================================================================================================================
# Author: Nel Pontejos
# Created: Sept 15, 2016
#   * Provider for directory and file manipulation
#=======================================================================================================================

def create_directory(directory_path_string)
  puts "testing if #{directory_path_string} exist..."
  if not Dir.exists?(directory_path_string)
    puts "directory does not exist #{directory_path_string}, creating directory..."
    Dir.mkdir(directory_path_string)
  else
    puts "directory exist: #{directory_path_string}"
  end
end

def get_program_name program_path
  array_prog_length = program_path.split('/').length
  array_prog_path = program_path.split('/')
  program_name = array_prog_path[array_prog_length - 1]
  trimmed_prog_name = program_name[0..-4]
  return trimmed_prog_name
end
