# Function to load and install packages (if required)
load_packages <- function(packages){
  for (package in packages) {
    if (!require(package, character.only=T, quietly=T)) {
      install.packages(package)
      library(package, character.only=T)
    }
  }
}