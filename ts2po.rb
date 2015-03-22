#! /usr/bin/env ruby

require "rexml/document"

if "" == ARGV[0] then 
    puts "USAGE!!"
    exit
end

def getNameFromElement(element) 
    element.elements.each("name"){ |element| 
        return element.text
    }
end

file = File.new(ARGV[0])
doc = REXML::Document.new file
contexts=doc.root.each_element() { |element| 
    name=getNameFromElement(element)
}
