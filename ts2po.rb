#! /usr/bin/env ruby
# -*- coding: utf-8 -*-
#
# ts2po.rb
#
# Converts a Qt .ts file to a gettext .po file
#
# Copyright 2015 Frederick Ollinger <follinge@gmail.com>
#

require "rexml/document"
require "./lib/poentries"

def ts2po(pos)
    pos.each(){ |element| 
        if not element.extracomment.empty? then
            puts "# #{element.extracomment}"
        end
        puts "#: #{element.name}"
        puts 'msgid "' + element.source + '"'
        puts 'msgstr ""'
        puts
    }
end

if "" == ARGV[0] then 
    puts "USAGE!!"
    exit
end

pos = POEntries.new

file = File.new(ARGV[0])
doc = REXML::Document.new file
pos.parse(doc)

# ts2po(pos)
puts pos.to_s
