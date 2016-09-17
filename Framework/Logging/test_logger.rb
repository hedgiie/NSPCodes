#=======================================================================================================================
# Author: Nel Pontejos
# Created: Sept 15, 2016
#   * A thin layer built on top of Ruby's logger.
#=======================================================================================================================

require 'logger'
require 'cgi'

require_relative ENV['FCTEST']+'/Framework/Utilities/date_time_stamp'
require_relative ENV['FCTEST']+'/Framework/Utilities/json_helper'
require_relative ENV['FCTEST']+'/Framework/Utilities/color_utils'


module MessageType
  SUCCESS = 0
  FAIL = 1
  INCOMPLETE = 2
  NOTE = 4
  CJIMS = 5
  WARNING = 6
end

class TestLogger

  private
  def initialize(test_plan_name, logging_directory, date_time_stamp, logging_level = 'debug')
    @log_file_name = "#{test_plan_name}_#{date_time_stamp}.html"
    @logger = initialize_logger(logging_directory, @log_file_name, logging_level)
    ensure_css_file_present( logging_directory )
    initialize_log_file(@log_file_name, 'logfile.css')
  end

  # Ensures that a .css file is copied into the logging directory.
  # @param severity [#Logger::Severity] The severity to which the logger should be set.
  #   This can be Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, or Logger::WARN.
  # @return [void]
  def ensure_css_file_present( logging_directory )
    unless (File.exists?("#{logging_directory}logfile.css"))
      begin
        FileUtils.copy_file(ENV['FCTEST']+'/Framework/Logging/logfile.css', "#{logging_directory}/logfile.css")
      rescue StandardError => e
        puts "| #{self.class} | #{__method__} | WARNING: Cannot copy logfile.css in #{logging_directory} - #{e.inspect}"
      end
    end
    unless (FileUtils.compare_file("#{logging_directory}logfile.css", ENV['FCTEST']+"/Framework/Logging/logfile.css") )
      begin
        FileUtils.copy_file("framework/logging/logfile.css", "#{logging_directory}/logfile.css")
      rescue StandardError => e
        puts "| #{self.class} | #{__method__} | WARNING: Cannot copy logfile.css in #{logging_directory} - #{e.inspect}"
      end
    end
  end

  # Convert the input logging level string to an enumerated form the Logger will accept.
  #
  # @param level [String] logging level that is taken from the config file's logging_mode field.
  # @ return [#Logger::Severity] Logger severity level. This will be Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, or Logger::WARN.
  def filter_logging_level level
    level.downcase!
    case level
    when 'fatal'
      Logger::FATAL
    when 'error'
      Logger::ERROR
    when 'warn'
      Logger::WARN
    when 'debug'
      Logger::DEBUG
    when 'info'
      Logger::INFO
    when 'unknown'
      Logger::UNKNOWN
    else
      raise RuntimeError, "Error: Unknown logging level #{level} in config file."
    end
  end

  # Initialize the built-in Ruby logger.
  #
  # @param log_file_path [String] file path to save the logs to.
  # @param log_file_name [String] name of the file to save the logs to.
  # @param logging_level [#Logger::Severity] the severity level the logger is to be set to.
  #   This can be Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, or Logger::WARN.
  # @ return [#Logger] a Logger instance.
  def initialize_logger(logging_directory, log_file_name, logging_level)
    logger = Logger.new("#{logging_directory}/#{log_file_name}", 100, 1048576)  # Keep last 100 log files, rotating them when they reach 1MB in size.
    logger.level = filter_logging_level logging_level
    # Suppress the default logging chatter.
    logger.formatter = proc do |severity, datetime, progname, msg|
      "#{msg}\n"
    end

    logger
  end

  def initialize_log_file(title, css_path_and_filename)
    html_header = "<!DOCTYPE HTML>\n" + \
    "<html>\n" + \
    "<head>\n" + \
    "<title>" + title + \
    "</title>\n" + \
    '<meta property="username" content="' + ENV["USERNAME"] + '"' + "/>\n" + \
    '<meta property="localhost" content="' + ENV["COMPUTERNAME"] + '"' + "/>\n" + \
    '<link rel="stylesheet" type="text/css" href="' + css_path_and_filename + '"' + "/>\n" + \
    "</head>\n" + \
    "<body>"
    @logger.unknown(html_header)
  end

  def finalize_log_file()
    @logger.unknown {
      "</body>\n" + \
      "</html>"
    }
  end

  public
  # Allows the logger's severity to be set via the standard assignment symbol '='.
  # @param severity [#Logger::Severity] The severity to which the logger should be set.
  #   This can be Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, or Logger::WARN.
  # @return [void]
  def severity= severity
    @logger.level = severity
  end

  # Write any message to the log. This method is the basis of the other convenience log methods.
  # @param message [String] The message to be logged.
  # @param severity [#Logger::Severity] The message severity.
  #   This can be Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, or Logger::WARN.
  # @return [void]
  def log_message(message, message_type = MessageType::NOTE, severity = Logger::UNKNOWN)
    case message_type
    when MessageType::SUCCESS
      html_class = 'success'
    when MessageType::FAIL
      html_class = 'fail'
    when MessageType::CJIMS
        html_class = 'note_cjims'
    when MessageType::INCOMPLETE
      html_class = 'incomplete'
    when MessageType::WARNING
        html_class = 'note_warn'
    else MessageType::NOTE
      case severity
      when Logger::FATAL
        html_class = 'note_fatal'
      when Logger::ERROR
        html_class = 'note_error'
      when Logger::WARN
        html_class = 'note_warn'
      when Logger::DEBUG
        html_class = 'note_debug'
      when Logger::INFO
        html_class = 'note_info'
      else Logger::UNKNOWN
        html_class = 'note_unknown'
      end
    end
    @logger.add(severity) {'<div class="' + html_class + '">' + create_date_time_stamp(true, '-', ' ', ':') + ' ' + CGI.escapeHTML(message) + '</div>'}
  end

  # Log a success message.
  # @param message [String] The message to be logged.
  # @param severity [#Logger::Severity] The message severity.
  #   This can be Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, or Logger::WARN.
  # @return [void]
  def success(message, severity = Logger::INFO)
    green_bright "SUCCESS: #{message}"
    log_message("SUCCESS: #{message}", MessageType::SUCCESS, severity)
  end

  # Log a passed message.
  # @param message [String] The message to be logged.
  # @param severity [#Logger::Severity] The message severity.
  #   This can be Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, or Logger::WARN.
  # @return [void]
  def passed(message, severity = Logger::INFO)
    green_bright "PASSED: #{message}"
    log_message("PASSED: #{message}", MessageType::SUCCESS, severity)
  end

  # Log a failure error message.
  # @param message [String] The message to be logged.
  # @param severity [#Logger::Severity] The message severity.
  #   This can be Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, or Logger::WARN.
  # @return [void]
  def fail_msg(message, severity = Logger::WARN)
    red_bright_yellow_bg "FAIL: #{message}"
    log_message("FAIL: #{message}", MessageType::FAIL, severity)
  end

  # Log a failure error message.
  # @param message [String] The message to be logged.
  # @param severity [#Logger::Severity] The message severity.
  #   This can be Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, or Logger::WARN.
  # @return [void]
  def warning(message, severity = Logger::UNKNOWN)
    red_bright "WARNING: #{message}"
    log_message("WARNING: #{message}", MessageType::WARNING, severity)
  end

  # Log an incompletion error message.
  # @param message [String] The message to be logged.
  # @param severity [#Logger::Severity] The message severity.
  #   This can be Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, or Logger::WARN.
  # @return [void]
  def incomplete(message, severity = Logger::ERROR)
    magenta_bright "INCOMPLETE: #{message}"
    log_message("INCOMPLETE: #{message}", MessageType::INCOMPLETE, severity)
  end

  # Log an exception error message.
  # @param message [String] The message to be logged.
  # @param severity [#Logger::Severity] The message severity.
  #   This can be Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, or Logger::WARN.
  # @return [void]
  def error(message, severity = Logger::ERROR)
    red_bright "ERROR: #{message}"
    log_message("ERROR:| #{self.class} | #{__method__} | #{message}", MessageType::NOTE, severity)
  end

  # Write a note to the log.
  # @param message [String] The message to be logged.
  # @param severity [#Logger::Severity] The message severity.
  #   This can be Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, or Logger::WARN.
  # @return [void]
  def note(message, severity = Logger::UNKNOWN)
    cyan_bright "note: #{message}"
    log_message("note:| #{message}", MessageType::NOTE, severity)
  end

  # Write a CJIMS specific notification note to the log.
  # @param message [String] The message to be logged.
  # @param severity [#Logger::Severity] The message severity.
  #   This can be Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, or Logger::WARN.
  # @return [void]
  def note_cjims(message, severity = Logger::UNKNOWN)
    magenta_bright "note cjims: #{message}"
    log_message("note cjims:| #{message}", MessageType::CJIMS, severity)
  end

  # Close the log file and logger instance.
  # @return [void]
  def end_logging
    finalize_log_file()
    @logger.close()
  end

  def display_summary()
    @logger.unknown(report_summary_in_html())
  end
end
