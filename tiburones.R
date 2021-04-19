## LIMPIAMOS ENVIRONMENT
rm(list=ls())

## IMPORTAMOS PAQUETES
for(paquete in c("tidyverse","xlsx","readxl","agricolae","ResourceSelection","aod","ResourceSelection", "repolr", "VGAM", "pROC","OptimalCutpoints","Epi")){
  if(!require(paquete,character.only=T)){
    install.packages(paquete,dependencies = T)
    library(paquete,character.only=T)}
}
## IMPORTAMOS CSV DESDE CLOUD, SEPARADO POR ";"
datos <- read_delim("Actividad_1/2_Dataset_GSAF5_Post_Python.csv", 
                    ";", escape_double = FALSE, trim_ws = TRUE)

## ARMAMOS UN LISTADO DE ESPECIES
## GENERAMOS UNA LISTA DE LAS ESPECIES E INCLUIMOS LAS OPCIONES "SHARK", "NOT CONFIRMED" y "NO SHARK"
EspecieTabulada<- c("BASKING SHARK","BLACKTIP SHARK","BLUE SHARK","BLUNTNOSE SIXGILL SHARK",
                    "BROADNOSE SEVENGILL SHARK","BRONZE WHALER SHARK","BULL SHARK","DUSKY SHARK",
                    "GALAPAGOS SHARK","GRAY REEF SHARK","GREAT HAMMERHEAD SHARK","LEMON SHARK","NURSE SHARK",
                    "OCEANIC WHITETIP SHARK","SAND TIGER","SHORTFIN MAKO SHARK","SILKY SHARK","SPINNER SHARK",
                    "TIGER SHARK","WHITE SHARK","WOBBEGONG","ZAMBESI SHARK", "HAMMER HEAD SHARK", "SALMON SHARK",
                    "SPINNER SHARK","TRESHER SHARK", "WHALE SHARK", "WHITETIP REEF SHARK","wHITETIP SHARK",
                    "WHITETIP SHARK", "BLUE NOSE SHARK" ,"SHARK", "NOT CONFIRMED", "NO SHARK")

## LO CONVERTIMOS EN UN ÚNICO STRING SEPARADO POR "|" PARA USAR COMO PATRON DE BUSQUEDA
strEspecieTabulada<-str_c (EspecieTabulada, collapse = "|")

## CREAMOS COLUMNA PASANDO A MAYUSCULAS
datos_transformados<- mutate(datos, EspecieIdentificada = toupper(Species))

## CATEGORIZAMOS FRASES QUE INDICAN LA NO CONFIRMACION O AFIRMAN QUE NO SE TRATA DE UN TIBURON
datos_transformados$EspecieIdentificada[str_detect(datos_transformados$Species,"NOT CONFIRMED")] <- "NOT CONFIRMED"
datos_transformados$EspecieIdentificada[str_detect(datos_transformados$Species,"NOT INVOLVEMENT")] <- "NO SHARK"
datos_transformados$EspecieIdentificada[str_detect(datos_transformados$Species,"NOT INVLOVEMENT")] <- "NO SHARK"
datos_transformados$EspecieIdentificada[str_detect(datos_transformados$Species,"NOT CAUSED")] <- "NO SHARK"
datos_transformados$EspecieIdentificada[str_detect(datos_transformados$Species,"BUT INJUR")] <- "NO SHARK"
datos_transformados$EspecieIdentificada[str_detect(datos_transformados$Species,"QUESTIONABLE")] <- "NOT CONFIRMED"
datos_transformados$EspecieIdentificada[str_detect(datos_transformados$Species,"INVALID")] <- "NO SHARK"
datos_transformados$EspecieIdentificada[str_detect(datos_transformados$Species,"UNIDENTIFIED")] <- "SHARK"

## EXTRAEMOS LA ESPECIE SEGUN LAS ESPECIES TABULADAS
datos_transformados <-mutate (datos_transformados, EspecieIdentificada = str_extract(EspecieIdentificada, strEspecieTabulada))

## ASIGNAMOS "NO DATA" A TODOS LOS "NA"
datos_transformados$EspecieIdentificada[is.na(datos_transformados$EspecieIdentificada)] <- "NO DATA"

## EXPORTAMOS EL ARCHIVO CSV
write.table(datos_transformados, "Actividad_1/3_Dataset_GSAF5_Post_R.csv", sep = "|")

