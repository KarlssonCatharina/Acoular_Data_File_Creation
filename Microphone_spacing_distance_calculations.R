#calculations of microphone spacing

#speed of sound (m/s), will change slightly with altitude/temperature. If you want to use a "basic" air speed set ss to 340, however in reality the average air temperature should be known and used. So the information needed to run the calculations is the air temperature in celsius and the dominant frequency of the species. 

#we calculate two values, one is half the distance. The spacingbetween microphones is not allowed to exceed this for any given species, and the 1/3 value which is a "safe" distance between the microphones. 


#safe distance of microphone spacings
MicSpacing3 <- function (temp,freq) {
  
  ss <- 331 + 0.6 * temp
  
  ((ss/freq)/3) * 100
  
}

#value that the distance is not allowed to exceed to ensure accurate calculations for atrget species
MicSpacing2 <- function (temp, freq) {
  
  ss <- 331 + 0.6 * temp
  
  ((ss/freq)/2) * 100
  
}


#calculate values for a target species at 5100 hZ at an air temperature of 20 degrees celsius, results are in centimeters
MicSpacing3(20, 5100)
MicSpacing2(20, 5100)




