rm(list=ls())

## IMPORTAMOS CSV DESDE CLOUD, SEPARADO POR ";"
install.packages("readr")
library(readr)
datos <- read_delim("Actividad_1/2_Dataset_GSAF5_Post_Python.csv", 
                    ";", escape_double = FALSE, trim_ws = TRUE)
View(datos)

## ARMAMOS UN LISTADO DE ESPECIES
EspecieTabulada= c("BASKING SHARK","BLACKTIP SHARK","BLUE SHARK","BLUNTNOSE SIXGILL SHARK","BROADNOSE SEVENGILL SHARK","BRONZE WHALER SHARK","BULL SHARK","DUSKY SHARK","GALAPAGOS SHARK","GRAY REEF SHARK","GREAT HAMMERHEAD SHARK","LEMON SHARK","NURSE SHARK","OCEANIC WHITETIP SHARK","SAND TIGER","SHORTFIN MAKO SHARK","SILKY SHARK","SPINNER SHARK","TIGER SHARK","WHITE SHARK","WOBBEGONG","ZAMBESI SHARK", "HAMMER HEAD SHARK", "SALMON SHARK" , "SPINNER SHARK","TRESHER SHARK", "WHALE SHARK", "WHITETIP REEF SHARK","wHITETIP SHARK" ,"WHITETIP SHARK", "BLUE NOSE SHARK" ,"SHARK", "NOT CONFIRMED", "NO SHARK")

## LO CONVERTIMOS EN UN ÚNICO STRING SEPARADO POR "|" PARA USAR COMO PATRON DE BUSQUEDA
install.packages("stringr")
library(stringr)
strEspecieTabulada =  str_c (EspecieTabulada, collapse = "|")

## CREAMOS COLUMNA PASANDO A MAYUSCULAS
install.packages("dplyr")
library(dplyr)
datos_transformados<- mutate(datos, Species = toupper(Species))
#X2_Dataset_GSAF5_Post_Python <- mutate(X2_Dataset_GSAF5_Post_Python, Species = toupper(Species))

## CATEGORIZAMOS FRASES QUE INDICAN LA NO CONFIRMACION O AFIRMAN QUE NO SE TRATA DE UN TIBURON
datos_transformados$Species[str_detect(datos_transformados$Species,"NOT CONFIRMED")] <- "NOT CONFIRMED"
datos_transformados$Species[str_detect(datos_transformados$Species,"NOT INVOLVEMENT")] <- "NO SHARK"
datos_transformados$Species[str_detect(datos_transformados$Species,"NOT INVLOVEMENT")] <- "NO SHARK"
datos_transformados$Species[str_detect(datos_transformados$Species,"NOT CAUSED")] <- "NO SHARK"
datos_transformados$Species[str_detect(datos_transformados$Species,"BUT INJUR")] <- "NO SHARK"
datos_transformados$Species[str_detect(datos_transformados$Species,"QUESTIONABLE")] <- "NOT CONFIRMED"
datos_transformados$Species[str_detect(datos_transformados$Species,"INVALID")] <- "NO SHARK"
datos_transformados$Species[str_detect(datos_transformados$Species,"UNIDENTIFIED")] <- "SHARK"

## EXTRAEMOS LA ESPECIE SEGUN LAS ESPECIES TABULADAS
datos_transformados <-mutate (datos_transformados, Species = str_extract(Species, strEspecieTabulada))

## ASIGNAMOS "NO DATA" A TODOS LOS "NA"
datos_transformados$EspecieIdentificada[is.na(datos_transformados$EspecieIdentificada)] <- "NO DATA"

write.table(Dataset_GSAF5_Post_R, "3_Dataset_GSAF5_Post_R.csv", sep = "|")
