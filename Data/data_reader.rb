#=======================================================================================================================
# Author: Nel Pontejos
# Created: Sept 15, 2016
#   * Handles mapping of data json file location from configuration file.
#   * Modified to refer an isolated data path
#=======================================================================================================================

require_relative ENV['FCTEST']+'/Framework/Utilities/json_helper'

class DataReader

  def self.initialize
    if $data.nil?
      $config = read_json ENV['FCTEST']+'/config.json'
      if ARGV.length == 0
        $data = read_json ENV['FCTEST']+$config[ENV['FCTEST_ENV']]['data']
      else
        $data = read_json ENV['FCTEST']+$config[ARGV[0]]['data']
      end

    end
  end

end
