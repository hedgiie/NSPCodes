#=======================================================================================================================
# Author: Nel Pontejos
# Created: Sept 15, 2016
#   * Provider for any time and date specific needs
#=======================================================================================================================

require 'time'

def create_date_stamp(date_separator='-')
  Time.now.strftime("%Y" + date_separator + "%m" + date_separator + "%d")
end

def create_time_stamp(include_milliseconds=false, time_separator='-')
  time_string = Time.now.strftime("%H" + time_separator + "%M" + time_separator + "%S")
  if include_milliseconds
    time_string += Time.now.strftime(time_separator + "%L")
  end
  time_string
end

def create_date_time_stamp(include_milliseconds=false, date_separator='-', date_time_separator='_', time_separator='-')
  create_date_stamp(date_separator) + date_time_separator + create_time_stamp(include_milliseconds, time_separator)
end

def create_date_time_stamped_filename(base_name, extension, include_milliseconds=false)
  base_name + "_" + create_date_time_stamp(include_milliseconds) + "." + extension
end

def create_date_time_stamped_email_address(base_name, email_provider, include_milliseconds=false)
  base_name + "+" + create_date_time_stamp(include_milliseconds) + "@" + email_provider
end
