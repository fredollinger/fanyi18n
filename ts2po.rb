#! /usr/bin/env ruby

require "rexml/document"
require_relative "lib/poentries"

if "" == ARGV[0] then 
    puts "USAGE!!"
    exit
end

pos = POEntries.new

file = File.new(ARGV[0])
doc = REXML::Document.new file
pos.parse(doc)

#puts pos[0].name
#pos.each(){ |element| 
#    puts element.name
#}
