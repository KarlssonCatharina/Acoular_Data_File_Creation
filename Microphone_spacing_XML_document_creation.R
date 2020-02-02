#creation of XML document file with microphone spacings

library(XML)
library(methods)
library(kulife)
library(xml2)

list.files()

#create the XML document 
Mics <- newXMLDoc()

#create the main node
MicArray <- newXMLNode("MicArray", attrs = c(name= "array_2"), doc = Mics)

#create children nodes, this is for a two microphone set up where the microphones are 23mm apart. Add more nodes with correct position two mid zero pint for a set up with more microphones
pos1 <- newXMLNode("pos",attrs=c(Name="Point 1", x = "0.0115", y=" 0.0000", z=" 0"),parent=MicArray, doc = Mics)
pos2 <- newXMLNode("pos",attrs=c(Name="Point 2", x =" -0.0115", y=" 0.0000", z=" 0"),parent=MicArray, doc = Mics)

#save the XML file with the correct encoding, change the name after "file" for new file name
cat(saveXML(Mics, file =" array_2mic_0115space.xml", prefix = '<?xml version="1.0" encoding="utf-8"?>\n'))

#read it back in to inspect
x <- xmlParse("array_2mic_0115space.XML")

#check content
x

