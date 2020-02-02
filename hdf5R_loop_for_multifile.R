
#hdf5 file creation for use with the Python package Acoular
library(rhdf5)
library(seewave)
library(tuneR)
library(stringr)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# set working diretory to folder where the .wav files are

#list all wav files in the directory
wavs <- list.files(pattern="wav$")

i <- 1
#create a list of file names without the wav
k <- read.csv(text="Filename",colClasses = c("character")) 
for (i in 1:length(wavs)) {
  
  Divy <- str_split(wavs[i],".w")
  Divx <- as.data.frame(as.character(Divy[[1]][1]))
  colnames(Divx)[1] <- "Filename"
  k <- rbind(k,Divx)
  
}

#now loop over the files to create the hdf5 files

for (i in 1:length(wavs)) {
  
  file1 <- readWave(wavs[i])#red in the file
  
  #now try with bigger dataset and check without chunking first
  #create the h5 file
  h5createFile(paste(k[i,],".h5",sep="")) 
  
  #set the parameters, for a one minute file at a sampling rate of 44100 with two microphones the dimensions are 2 (for the numbe rof microphones) and 60 * 44100 = 2646005 
  h5createDataset(paste(k[i,],".h5",sep=""), 'time_data', c(2, 2646005))  
  
  #now write the acoustic file to the h5 using the two microphones as a matrix
  h5write(as.matrix(c(file1@left,file1@right)), paste(k[i,],".h5",sep=""),"time_data" ,write.attributes=TRUE)
  
  #list the content of the file
  h5ls(paste(k[i,],".h5",sep=""))
  
  #read the atrributes to ensure the file was create dproperly 
  h5readAttributes(file = paste(k[i,],".h5",sep=""), name = "time_data")
  
  #add in sampling frequency as an attribute
  fid <- H5Fopen(paste(k[i,],".h5",sep="")) #open the h5 file
  did <- H5Dopen(fid, "time_data") #open the node
  
  #Provide the NAME and the ATTR (what the attribute says) for the attribute.
  h5writeAttribute(did, attr=44100,name="sample_freq") #assign the attribute
  H5Dclose(did) #close the node to ensure the data is saved
  H5Fclose(fid) #close the h5 file to ensure the data is saved
  h5readAttributes(file = paste(k[i,],".h5",sep=""), name = "time_data") #check out the attributes to ensure they are saved properly
  
  
}

