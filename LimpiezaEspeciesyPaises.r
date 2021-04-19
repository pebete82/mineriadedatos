library(readr)
"2_Dataset_GSAF5_Post_Python" <- read_csv("2_Dataset_GSAF5_Post_Python.csv")

## Limpieza Especies
EspecieTabulada= c("BASKING SHARK","BLACKTIP SHARK","BLUE SHARK","BLUNTNOSE SIXGILL SHARK","BROADNOSE SEVENGILL SHARK","BRONZE WHALER SHARK","BULL SHARK","DUSKY SHARK","GALAPAGOS SHARK","GRAY REEF SHARK","GREAT HAMMERHEAD SHARK","LEMON SHARK","NURSE SHARK","OCEANIC WHITETIP SHARK","SAND TIGER","SHORTFIN MAKO SHARK","SILKY SHARK","SPINNER SHARK","TIGER SHARK","WHITE SHARK","WOBBEGONG","ZAMBESI SHARK", "HAMMER HEAD SHARK", "SALMON SHARK" , "SPINNER SHARK","TRESHER SHARK", "WHALE SHARK", "WHITETIP REEF SHARK","wHITETIP SHARK" ,"WHITETIP SHARK", "BLUE NOSE SHARK" ,"SHARK", "NOT CONFIRMED", "NO SHARK")
#EspecieTabulada
#Lo convierto en un string separado por | para usar como patrón de búsqueda

library(stringr)
strEspecieTabulada =  str_c (EspecieTabulada, collapse = "|")
strEspecieTabulada
#Lo conviertimos en un string separado por | para usar como patrón de búsqueda
strEspecieTabulada =  str_c (EspecieTabulada$Species, collapse = "|")

install.packages("dplyr")
library(dplyr)
#1. Creamos columna pasando a Mayuscula
"2_Dataset_GSAF5_Post_Python"<- mutate("2_Dataset_GSAF5_Post_Python", EspecieIdentificada = toupper(Species))

#2. Categorizamos frases que indican la no confirmación o afirman que no se trata de un tiburón
Dataset_GSAF5_Post_R$EspecieIdentificada[str_detect(Dataset_GSAF5_Post_R$EspecieIdentificada,"NOT CONFIRMED")] <- "NOT CONFIRMED"

Dataset_GSAF5_Post_R$EspecieIdentificada[str_detect(Dataset_GSAF5_Post_R$EspecieIdentificada,"NOT INVOLVEMENT")] <- "NO SHARK"

Dataset_GSAF5_Post_R$EspecieIdentificada[str_detect(Dataset_GSAF5_Post_R$EspecieIdentificada,"NOT INVLOVEMENT")] <- "NO SHARK"

Dataset_GSAF5_Post_R$EspecieIdentificada[str_detect(Dataset_GSAF5_Post_R$EspecieIdentificada,"NOT CAUSED")] <- "NO SHARK"

Dataset_GSAF5_Post_R$EspecieIdentificada[str_detect(Dataset_GSAF5_Post_R$EspecieIdentificada,"BUT INJUR")] <- "NO SHARK"

Dataset_GSAF5_Post_R$EspecieIdentificada[str_detect(Dataset_GSAF5_Post_R$EspecieIdentificada,"QUESTIONABLE")] <- "NOT CONFIRMED"

Dataset_GSAF5_Post_R$EspecieIdentificada[str_detect(Dataset_GSAF5_Post_R$EspecieIdentificada,"INVALID")] <- "NO SHARK"

Dataset_GSAF5_Post_R$EspecieIdentificada[str_detect(Dataset_GSAF5_Post_R$EspecieIdentificada,"UNIDENTIFIED")] <- "SHARK"


#3. Extraemos la especie según las especies tabuladas
# En el archivo se agregaron NO SHARK y NOT CONFIRMED SHARK como opciones para poder tabular la columna
Dataset_GSAF5_Post_R <-mutate (Dataset_GSAF5_Post_R, EspecieIdentificada = str_extract(EspecieIdentificada, strEspecieTabulada))

Dataset_GSAF5_Post_R$EspecieIdentificada[is.na(Dataset_GSAF5_Post_R$EspecieIdentificada)] <- "NO DATA"

write.table(Dataset_GSAF5_Post_R, "3_Dataset_GSAF5_Post_R.csv", sep = "|")
