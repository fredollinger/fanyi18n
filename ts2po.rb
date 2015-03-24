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
if  File.exist?('./lib/poentries.rb') then
    puts "loading local lib"
    require "./lib/poentries"
else
   require 'poentries'
end

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

unless ARGV[0] then 
    puts "usage: "
    puts
    puts "ts2po.rb translation-file.ts"
    puts 
    puts "Usually one gets the translation-file.ts by running lupdate on a directory."
    puts "See Qt tranlation documentation for details."
    puts 
    puts "http://doc.qt.io/qt-4.8/internationalization.html"
    exit
end

pos = POEntries.new

file = File.new(ARGV[0])
doc = REXML::Document.new file
pos.parse(doc)

# ts2po(pos)
# puts pos.to_s
