# -*- coding: utf-8 -*-
#
# POEntry - a class to encapsulate a single line of text to be translated in 
# a po file.
#
# Copyright 2015 Frederick Ollinger <follinge@gmail.com>
#

class POEntry
attr_accessor :name, :source, :extracomment, :msgctxt 

def cond_p(label, acc)
    if not acc.empty? then
        print "#{label}: [#{acc}] "
    end
end

def to_s()
    cond_p("name", name)
    cond_p("source", source)
    cond_p("extracomment", extracomment)
    cond_p("msgctxt", msgctxt)
    puts
    #puts "name: [#{name}] source: [#{source}] extracomment: [#{extracomment}]"
end

def ==(name)
    return self.name == element.name
end

end # class POEntry

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
            else
	       poe.extracomment=""
	    end


            self << poe
	    count = count + 1
    } # END sources=context.elements.each("message")

    self.each(){ |element| 
            matches=find(element.source)
	    if (matches.length > 1) then
                element.msgctxt = element.name
            else
                element.msgctxt = ""
 	    end
     }

end # getElements()

def parse(doc)
    contexts=doc.root.each_element() { |element| 
        getElements(element)
    }
end

def to_s()
    self.each(){ |element| 
        puts element.to_s
	puts
    }
end

# find() find an element based on a piece of text
# which matches the source
def find(source)
    a = []
    self.each(){ |element| 
        if element.source == source then
	    #puts "MATCH: [#{element.source}]"
	    a << element
        end
    }
    return a
end

def ts2po()
    self.each(){ |element| 
        # FRED TODO: NEED TO PUT pound in front of line breaks!!
        if not element.extracomment.empty? then
            puts "# #{element.extracomment}"
        end

        puts "#: #{element.name}"

        if not element.msgctxt.empty? then
            puts 'msgctxt "' + element.msgctxt + '"'
        end

        puts 'msgid "' + element.source + '"'
        puts 'msgstr ""'
        puts
    }
end

end # class POEntries < Array
