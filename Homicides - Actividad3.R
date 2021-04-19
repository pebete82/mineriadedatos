homicides<-readLines("homicides.txt")
homicides[1:10]
str(homicides)
edad<-1:1250
lat<-1:1250
long<-1:1250
causa<-1:1250
sexo<-1:1250

for (i in 1:1250){
  place<-regexpr(" years old", homicides[i],ignore.case=TRUE)[1]
if (place!=-1){
    edad[i]<-as.numeric(substring(homicides[i],place-2,place))}}

summary(edad)

#cargamos latitude (lat)
for (i in 1:1250){lat[i]<-as.numeric(substring(homicides[i],1,9))}
summary(lat)

for (i in 1:1250){
  place<-regexpr(", -", homicides[i])[1]
  if (place!=-1){long[i]<-as.numeric(substring(homicides[i],place+2,place+11))}}

for (i in 1:1250){
  if (regexpr("STABBING", homicides[i],ignore.case=TRUE)[1]!=-1){causa[i]<-"STABBING"}
  if (regexpr("SHOOTING", homicides[i],ignore.case=TRUE)[1]!=-1){causa[i]<-"SHOOTING"}
  if (regexpr("UNKNOWN", homicides[i],ignore.case=TRUE)[1]!=-1){causa[i]<-"UNKNOWN"}
  if (regexpr("OTHER", homicides[i],ignore.case=TRUE)[1]!=-1){causa[i]<-"OTHER"}
  if (regexpr("BLUNT FORCE", homicides[i],ignore.case=TRUE)[1]!=-1){causa[i]<-"BLUNT FORCE"}
  if (regexpr("ASPHYXIATION", homicides[i],ignore.case=TRUE)
      [1]!=-1){causa[i]<-"ASPHYXIATION"}}

for (i in 1:1250){
  if (regexpr(" Male", homicides[i],ignore.case=TRUE)[1]!=-1){sexo[i]<-"MALE"}
  if (regexpr(" FEMALE", homicides[i],ignore.case=TRUE)[1]!=-1){sexo[i]<-"FEMALE"}}
