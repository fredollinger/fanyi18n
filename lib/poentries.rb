# POEntry - a class to encapsulate a single line of text to be translated in 
# a po file.
class POEntry
attr_accessor :name, :source
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
    #context.elements.each("message"){ |element| 
    sources=context.elements.each("message"){ |message|
            poe = POEntry.new
            source=message.name=getFieldFromElement("source", message).text
            poe.name=name
            poe.source=source
            puts "#{name} : [#{source}]"
            self << poe
    }
end

def parse(doc)
    contexts=doc.root.each_element() { |element| 
        getElements(element)
    }
end

end
