####################################################################################
# Author: Nel Pontejos | Created: Sept 15, 2016
# Description:
#   This file provides a color scheme for enhancing console output.
#   Ruby Gem Requirements:
#     gem install rainbow
#   References:
#     https://github.com/sickill/rainbow
####################################################################################


require 'rainbow'

$color = Rainbow.new
$color.enabled = true # disables coloring feature

# Naming of this functions would indicate a coloring to be applied within the parameter
#   string which will append to next line.
# those with *_bright covers a brighter color
# those with *_ is use when string will be displayed within the same line

def red(string)
  puts $color.wrap("#{string}").red
end

def red_bright(string)
  puts $color.wrap("#{string}").bright.red
end

def red_bright_yellow_bg(string)
  puts $color.wrap("#{string}").bright.red.background(:yellow)
end

def red_bright_blue_bg(string)
  puts $color.wrap("#{string}").bright.red.background(:blue)
end

def black(string)
  puts $color.wrap("#{string}").black
end

def black_bright(string)
  puts $color.wrap("#{string}").bright.black
end

def green(string)
  puts $color.wrap("#{string}").green
end

def green_bright(string)
  puts $color.wrap("#{string}").bright.green
end

def yellow(string)
  puts $color.wrap("#{string}").yellow
end

def yellow_bright(string)
  puts $color.wrap("#{string}").bright.yellow
end

def blue(string)
  puts $color.wrap("#{string}").blue
end

def blue_bright(string)
  puts $color.wrap("#{string}").bright.blue
end

def magenta(string)
  puts $color.wrap("#{string}").magenta
end

def magenta_bright(string)
  puts $color.wrap("#{string}").bright.magenta
end

def cyan(string)
  puts $color.wrap("#{string}").cyan
end

def cyan_bright(string)
  puts $color.wrap("#{string}").bright.cyan
end

def white(string)
  puts $color.wrap("#{string}").white
end

def white_bright(string)
  puts $color.wrap("#{string}").bright.white
end

# To be printed within the same line

def red_(string)
  print $color.wrap("#{string}").red
end

def red_bright_(string)
  print $color.wrap("#{string}").bright.red
end

def red_bright_yellow_bg_(string)
  print $color.wrap("#{string}").bright.red.background(:yellow)
end

def red_bright_blue_bg_(string)
  print $color.wrap("#{string}").bright.red.background(:blue)
end

def black_(string)
  print $color.wrap("#{string}").black
end

def black_bright_(string)
  print $color.wrap("#{string}").bright.black
end

def green_(string)
  print $color.wrap("#{string}").green
end

def green_bright_(string)
  print $color.wrap("#{string}").bright.green
end

def yellow_(string)
  print $color.wrap("#{string}").yellow
end

def yellow_bright_(string)
  print $color.wrap("#{string}").bright.yellow
end

def blue_(string)
  print $color.wrap("#{string}").blue
end

def blue_bright_(string)
  print $color.wrap("#{string}").bright.blue
end

def magenta_(string)
  print $color.wrap("#{string}").magenta
end

def magenta_bright_(string)
  print $color.wrap("#{string}").bright.magenta
end

def cyan_(string)
  print $color.wrap("#{string}").cyan
end

def cyan_bright_(string)
  print $color.wrap("#{string}").bright.cyan
end

def white_(string)
  print $color.wrap("#{string}").white
end

def white_bright_(string)
  print $color.wrap("#{string}").bright.white
end



if __FILE__ == $0
  puts "** Displays usage and sample output on using this color_utils.rb methods **"
  puts "** WARNING: output display the un-altered invocation of these methods"
  red("red(This is red)")
  black("black(This is black)")
  green("green(This is green)")
  yellow("yellow(this is yellow)")
  blue("blue(this is blue)")
  magenta("magenta(this is magenta)")
  cyan("cyan(this is cyan)")
  white("white(this is white)")

  red_bright("red_bright(this is bright red)")
  black_bright("black_bright(this is bright black)")
  green_bright("green_bright(this is bright green)")
  yellow_bright("yellow_bright(this is bright yellow)")
  blue_bright("blue_bright(this is bright blue)")
  magenta_bright("magenta_bright(this is bright magenta)")
  cyan_bright("cyan_bright(this is bright cyan)")
  white_bright("white_bright(this is bright white)")
  red_bright_yellow_bg("red_bright_yellow_bg(bright red with yellow bg)")
  red_bright_blue_bg("red_bright_blue_bg(bright red with blue bg")


  red_("red_(this is red within the same line)")
  black_("black_(this is black in the same line)")
  green_("green_(this is green in the same line)")
  yellow_("yellow_(this is yellow in the same line)")
  blue_("blue_(this is blue in the same line)")
  magenta_("magenta_(this is magenta in the same line)")
  cyan_("cyan_(this is cyan in the same line)")
  white_("white_(this is white in the same line)")

  red_bright_("red_bright_(this is bright red in the same line)")
  black_bright_("black_bright_(this is bright black in the same line)")
  green_bright_("green_bright_(this is bright green in the same line)")
  yellow_bright_("yellow_bright_(this is bright yellow in the same line)")
  blue_bright_("blue_bright_(this is bright blue in the same line)")
  magenta_bright_("magenta_bright_(this is bright magenta in the same line)")
  cyan_bright_("cyan_bright_(this is bright cyan in the same line)")
  white_bright_("white_bright_(this is bright white in the same line)")
  red_bright_yellow_bg_("red_bright_yellow_bg_(this is bright red with yellow background in the same line)")
  red_bright_blue_bg_("red_bright_blue_bg_(this is bright red with blue background in the same line)")
  puts "*** End of sample display output ***"
end
