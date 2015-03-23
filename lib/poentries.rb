# -*- coding: utf-8 -*-
#
# POEntry - a class to encapsulate a single line of text to be translated in 
# a po file.
#
# Copyright 2015 Frederick Ollinger <follinge@gmail.com>
#

class POEntry
attr_accessor :name, :source, :extracomment
end

# POEntries - an enumerable of POEntries
class POEntries < Array

@@entries= Array.new

# include Enumerable
def getFieldFromElement(field, element) 
    element.elements.each(field){ |element| 
        return element
    }
end

def getElements(context)
    name=context.name=getFieldFromElement("name", context).text
    count=1
    sources=context.elements.each("message"){ |message|
            poe = POEntry.new
            poe.name=name+"#"+count.to_s
            poe.source=getFieldFromElement("source", message).text
            extracomment=getFieldFromElement("extracomment", message)

            if  REXML::Element ==  extracomment.class
	       poe.extracomment=extracomment.text
               #puts "[#{extracomment}]"
            else
               #puts "[#{extracomment.class}]"
	       poe.extracomment=""
	    end

            self << poe
	    count = count + 1
    }
end

def parse(doc)
    contexts=doc.root.each_element() { |element| 
        getElements(element)
    }
end

end
