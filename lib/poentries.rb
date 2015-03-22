# POEntry - a class to encapsulate a single line of text to be translated in 
# a po file.
class POEntry
attr_accessor :name
end

# POEntries - an enumerable of POEntries
class POEntries < Array

@@entries= Array.new

# include Enumerable
def getNameFromElement(element) 
    element.elements.each("name"){ |element| 
        return element.text
    }
end

def getElements(context)
    name=context.name=getNameFromElement(context)
    context.elements.each("message"){ |element| 
        poe = POEntry.new
        poe.name=name
        self << poe
    }
end

def parse(doc)
    contexts=doc.root.each_element() { |element| 
        getElements(element)
    }
end

end
