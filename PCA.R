library(FactoMineR)
library(factoextra)
library("corrplot")

#Working directory
setwd("C:/Users/p1x33l/Desktop/projet data analysis")
hotels.data <- read.csv(file="hotels.csv",header = 1, sep =",",row.names=1)
View(hotels.data)

#correlation matrix
cor(hotels.data[2:13])

#verify PCA illegibility (>0.3 or <-0.3)
mean(cor(hotels.data[2:13])) #elegible

#ACP
hotels.acp <- PCA(hotels.data[c(2:13)],ncp=4,graph=F)
summary(hotels.acp)
dimdesc(hotels.acp)
hotels.acp$eig
hotels.acp$var

#Principal Components
fviz_screeplot(hotels.acp, type="lines", addlabels=T, main="Scree Plot PCA")


#Plot Indiv
plot(hotels.acp,choix="var",cex=1,habillage="night_price")
fviz_pca_ind(hotels.acp,
             geom.ind = "point", # show points only (but not "text")
             col.ind = hotels.data$category, # color by groups
             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
             addEllipses = TRUE, # Concentration ellipses
             legend.title = "Groups",
             axes=c(2,3)
)
fviz_pca_biplot(hotels.acp,geom = "point")

#Contribution
corrplot(hotels.acp$ind$, is.corr=F,cl.ratio = 0.5)

#Variables Contribution
fviz_contrib(hotels.acp, choice = "var", axes = 1, top = 10)
fviz_contrib(hotels.acp, choice = "var", axes = 2, top = 10)
fviz_contrib(hotels.acp, choice = "var", axes = 3, top = 10)
fviz_contrib(hotels.acp, choice = "var", axes = 4, top = 10)

#Individuals Contribution
fviz_contrib(hotels.acp, choice = "ind", axes = 1, top = 10)
fviz_contrib(hotels.acp, choice = "ind", axes = 2, top = 10)

#Projection
corrplot(hotels.acp$var$cos2, is.corr=FALSE)

#Variables Representation Quality
fviz_pca_var(hotels.acp, col.var = "contrib",gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), repel = T,axes=c(2,3))


