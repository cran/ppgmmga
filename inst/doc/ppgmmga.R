## ----setup, include=FALSE------------------------------------------------
library(knitr)
opts_chunk$set(fig.align = "center", 
               out.width = "80%",
               fig.width = 6, fig.height = 5,
               dev.args = list(pointsize = 10),
               par = TRUE, # needed for setting hook 
               collapse = TRUE, # collapse input & ouput code in chunks
               message = FALSE,
               warning = FALSE)

knit_hooks$set(par = function(before, options, envir)
  { if(before && options$fig.show != "none") 
       par(family = "sans", mar=c(4.1,4.1,1.1,1.1), mgp=c(3,1,0), tcl=-0.5)
})

## ---- message = FALSE, echo=1--------------------------------------------
library(ppgmmga)
cat(ppgmmga:::ppgmmgaStartupMessage(), sep="")

## ---- fig.width = 7, fig.height = 6, out.width = "100%"------------------
library(mclust)
data("banknote")
X <- banknote[,-1]
Class <- banknote$Status
table(Class)
Class_color <- ggthemes::tableau_color_pal("Classic 10")(2)
clPairs(X, classification = Class, colors = Class_color)

## ------------------------------------------------------------------------
pp1D <- ppgmmga(data = X, d = 1, approx = "UT", seed = 1)
pp1D
summary(pp1D)

## ---- out.width="60%", fig.width=6, fig.height=4-------------------------
plot(pp1D)

## ---- out.width="70%", fig.width=7, fig.height=4-------------------------
plot(pp1D, class = Class)

## ------------------------------------------------------------------------
pp2D <- ppgmmga(data = X, d = 2, approx = "UT", seed = 1)
summary(pp2D, check = TRUE)
summary(pp2D$GMM)

## ------------------------------------------------------------------------
plot(pp2D$GA)

## ------------------------------------------------------------------------
plot(pp2D)

## ---- fig.width = 7, fig.height = 5--------------------------------------
plot(pp2D, class = Class, drawAxis = FALSE)

## ------------------------------------------------------------------------
pp3D <- ppgmmga(data = X, d = 3, 
                center = TRUE, scale = FALSE, 
                gatype = "gaisl", 
                options = ppgmmga.options(numIslands = 2),
                seed = 1)
summary(pp3D, check = TRUE)

## ------------------------------------------------------------------------
plot(pp3D$GA)

## ---- fig.width = 7, fig.height = 6, out.width = "100%"------------------
plot(pp3D)

## ---- fig.width = 7, fig.height = 6, out.width = "100%"------------------
plot(pp3D, class = Class)

## ---- fig.width = 6, fig.height = 5--------------------------------------
plot(pp3D, dim = c(1,2))

## ---- fig.width = 7, fig.height = 5, out.width = "90%"-------------------
plot(pp3D, dim = c(1,3), class = Class)

## ---- eval=FALSE---------------------------------------------------------
#  # A rotating 3D plot can be obtained using
#  if(!require("msir")) install.packages("msir")
#  msir::spinplot(pp3D$Z, markby = Class,
#                 pch.points = c(19,17),
#                 col.points = Class_color)

## ---- echo=FALSE, results='asis'-----------------------------------------
print(citation("ppgmmga"), style = "text")

## ------------------------------------------------------------------------
sessionInfo()

