## ----setup, include=FALSE-----------------------------------------------------
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

## ----message = FALSE, echo=1--------------------------------------------------
library(ppgmmga)
cat(ppgmmga:::ppgmmgaStartupMessage(), sep="")

## ----fig.width = 7, fig.height = 6, out.width = "100%"------------------------
library(mclust)
data("banknote")
X <- banknote[,-1]
Class <- banknote$Status
table(Class)
clPairs(X, classification = Class, 
        symbols = ppgmmga.options("classPlotSymbols"),
        colors = ppgmmga.options("classPlotColors"))

## -----------------------------------------------------------------------------
PP1D <- ppgmmga(data = X, d = 1, seed = 1)
PP1D
summary(PP1D)

## ----out.width="60%", fig.width=6, fig.height=4-------------------------------
plot(PP1D)

## ----out.width="70%", fig.width=7, fig.height=4-------------------------------
plot(PP1D, class = Class)

## -----------------------------------------------------------------------------
PP2D <- ppgmmga(data = X, d = 2, seed = 1)
summary(PP2D)
summary(PP2D$GMM)

## -----------------------------------------------------------------------------
plot(PP2D$GA)

## -----------------------------------------------------------------------------
plot(PP2D)

## ----fig.width = 7, fig.height = 5--------------------------------------------
plot(PP2D, class = Class, drawAxis = FALSE)

## -----------------------------------------------------------------------------
PP3D <- ppgmmga(data = X, d = 3, 
                center = TRUE, scale = FALSE, 
                gatype = "gaisl", 
                options = ppgmmga.options(numIslands = 2),
                seed = 1)
summary(PP3D)

## -----------------------------------------------------------------------------
plot(PP3D$GA)

## ----fig.width = 7, fig.height = 6, out.width = "100%"------------------------
plot(PP3D)

## ----fig.width = 7, fig.height = 6, out.width = "100%"------------------------
plot(PP3D, class = Class)

## ----fig.width = 6, fig.height = 5--------------------------------------------
plot(PP3D, dim = c(1,2))

## ----fig.width = 7, fig.height = 5, out.width = "90%"-------------------------
plot(PP3D, dim = c(1,3), class = Class)

## ----eval=FALSE---------------------------------------------------------------
#  # A rotating 3D plot can be obtained using
#  if(!require("msir")) install.packages("msir")
#  msir::spinplot(PP3D$Z, markby = Class,
#                 pch.points = c(20,17),
#                 col.points = ppgmmga.options("classPlotColors")[1:2])

## -----------------------------------------------------------------------------
sessionInfo()

