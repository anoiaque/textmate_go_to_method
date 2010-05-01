#!/usr/bin/env ruby -w
require File.join(ENV['TM_SUPPORT_PATH'], 'lib/textmate')

def search_directories
	[File.join(ENV['TM_PROJECT_DIRECTORY'], 'app/*'), File.join(ENV['TM_PROJECT_DIRECTORY'], 'lib/*')]
end

def go_to_method method
  grep_return = `grep -rnE "def (self\.)?#{method}([\( ]{1}|$)" #{search_directories.to_s}`
  filepath, line = grep_return.match(/^.+:[\d]+/).to_s.strip.split(':')
  TextMate.go_to(:file => filepath, :line => line)  if filepath && line
end

go_to_method Regexp.escape(ENV['TM_CURRENT_WORD'])
