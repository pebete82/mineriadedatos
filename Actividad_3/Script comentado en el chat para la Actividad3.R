SILVIA ADRIANA COBIALCA11:11
homicides<-readLines("homicides.txt")
SILVIA ADRIANA COBIALCA11:16
homicides[1:10]
tail()
SILVIA ADRIANA COBIALCA11:22
edad<-1:1250
lat<-1:1250
long<-1:1250
causa<-1:1250
sexo<-1:1250
SILVIA ADRIANA COBIALCA11:23
for (i in 1:1250){
  place<-regexpr(" years old", homicides[i],ignore.case=TRUE)[1]
  if (place!=-1){
    edad[i]<-as.numeric(substring(homicides[i],place-2,place))}}
SILVIA ADRIANA COBIALCA11:30
#cargamos latitude (lat)
for (i in 1:1250){lat[i]<-as.numeric(substring(homicides[i],1,9))}
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
SILVIA ADRIANA COBIALCA11:34
for (i in 1:1250){
  if (regexpr(" Male", homicides[i],ignore.case=TRUE)[1]!=-1){sexo[i]<-"MALE"}
  if (regexpr(" FEMALE", homicides[i],ignore.case=TRUE)[1]!=-1){sexo[i]<-"FEMALE"}}
SILVIA ADRIANA COBIALCA11:36
edad[edad==1033]<-10
edad[edad==949]<-94
edad[edad==806]<-80
edad[edad==768]<-76
edad[edad==555]<-55
edad[edad==527]<-52
edad[edad==481]<-48
edad[edad==461]<-46
edad[edad==455]<-45
edad[edad==448]<-44
edad[edad==441]<-44
edad[edad==420]<-42
edad[edad==382]<-38
edad[edad==348]<-34
edad[edad==275]<-27
edad[edad==247]<-24
edad[edad==168]<-16
edad[edad==515]<-NA
SILVIA ADRIANA COBIALCA11:39
sexo[sexo==515]<-NA
table(sexo)
SILVIA ADRIANA COBIALCA11:41
causa[causa==515]<-NA
causa[causa==213]<-'OTHER'
causa[causa==212]<-'OTHER'
causa[causa==236]<-'OTHER'
causa[causa==238]<-'OTHER'
SILVIA ADRIANA COBIALCA11:48
baltimore<-as.data.frame(cbind(edad,sexo,lat,long,causa))
SILVIA ADRIANA COBIALCA11:54
balt<-transform(baltimore,edad=as.numeric(edad),sexo,lat=as.numeric(lat),long=as.numeric(long),causa)
SILVIA ADRIANA COBIALCA11:56
final<-balt[complete.cases(balt),]
SILVIA ADRIANA COBIALCA11:58
index <- sample(1:nrow(final),as.integer(nrow(final)*.70),replace=FALSE)

train<- final[index,]
test<-final[-index,]
SILVIA ADRIANA COBIALCA12:00
install.packages(c("partykit", "rpart"))
SILVIA ADRIANA COBIALCA12:04
library(partykit)
fit<-ctree(causa~edad+sexo,data=train)
plot(fit)
SILVIA ADRIANA COBIALCA12:10
fit2<-ctree(causa~edad+sexo+long+lat,data=train)
plot(fit2,type="simple")
SILVIA ADRIANA COBIALCA12:14
fit<-ctree(causa~.=train)
test1<-test[c(1,2,3,4)]

#aplicamos el modelo a test1
prediction <- predict(fit, newdata=test1, type = "response")
SILVIA ADRIANA COBIALCA12:17
table(prediction, test$causa)