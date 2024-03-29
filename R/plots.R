#################################################################################
#                    PLOT PPGMMGA                                               #
#################################################################################

plot.ppgmmga <- function(x, class = NULL,
                         dim = seq(x$d),
                         drawAxis = TRUE,
                         bins = nclass.numpy,
                         ...)
{
  stopifnot(inherits(x, "ppgmmga"))
  d <- length(dim)
  d <- ifelse(d > 2, 3, length(dim))
  Zpp <- data.frame(x$Z[,dim,drop=FALSE])
  znames <- colnames(Zpp)
  if(is.null(colnames(x$data)))
    colnames(x$data) <- paste0("X", seq(x$GMM$d))
  if(!is.null(class))
  { 
    class.name <- deparse(substitute(class))
    if(!is.factor(class)) class <- factor(class)
  } else
  { 
    class <- rep(1, nrow(Zpp))
    class.name <- NULL
  }

  switch(d,
  "1" = # 1D case ----
  { 
    gg <- ggplot(Zpp, aes(x = .data[[znames[1]]])) +
      geom_rug(alpha = 0.5)
    if(!is.null(class.name))
    {
      gg <- gg + 
        geom_histogram(aes(y = after_stat(density),
                           fill = class, colour = class),
                       position = "identity",
                       alpha = 0.6,
                       bins = if(is.function(bins)) bins(Zpp[,1])
                              else as.numeric(bins)) +
        scale_fill_manual(values = rep(ppgmmga.options("classPlotColors"),
                                       length = nlevels(class))) + 
        scale_colour_manual(values = rep(ppgmmga.options("classPlotColors"), 
                                         length = nlevels(class))) + 
        labs(fill = class.name, col = class.name)
    } else
    {
      gg <- gg +
        geom_histogram(aes(y = after_stat(density)),
                       position = "identity",
                       alpha = 0.6,
                       col = "white",
                       bins = if(is.function(bins)) bins(Zpp[,1])
                              else as.numeric(bins))
    }
    gg <- gg + theme_bw()
     
    return(gg)
  },
  "2" = # 2D case ----
  { 
    gg <- ggplot(Zpp, aes(x = .data[[znames[1]]], 
                          y = .data[[znames[2]]]))
    if(!is.null(class.name))
    {
      gg <- gg +
        geom_point(cex = 1, aes(shape = class, 
                                colour = class)) +
        scale_shape_manual(values = rep(ppgmmga.options("classPlotSymbols"),
                                        length = nlevels(class))) + 
        scale_colour_manual(values = rep(ppgmmga.options("classPlotColors"), 
                                         length = nlevels(class))) + 
        labs(shape = class.name, colour = class.name)
    } else 
    {
      gg <- gg + geom_point(cex = 1, shape = 20, colour = "black")
    }

    if(drawAxis)
    { 
      df2 <- data.frame(varnames = abbreviate(colnames(x$data), 
			                                        minlength = 8),
                        x = x$basis[,dim[1]],
                        y = x$basis[,dim[2]],
                        stringsAsFactors = FALSE)
      mult <- min((max(Zpp[,1]) - min(Zpp[,1])/(max(df2$x)-min(df2$x))),
                  (max(Zpp[,2]) - min(Zpp[,2])/(max(df2$y)-min(df2$y))) )
      df2 <- transform(df2,
                       x = .7 * mult * df2$x,
                       y = .7 * mult * df2$y)
      gg <-  gg + 
        geom_segment(data = df2, 
                     aes(x = 0, xend = .data[["x"]], 
                         y = 0, yend = .data[["y"]]),
                     arrow = arrow(length = unit(0.5, "picas")),
                     alpha = 0.5, color = "gray30") +
        geom_text(data = df2, aes(x = .data[["x"]], 
                                  y = .data[["y"]], 
                                  label = .data[["varnames"]]),
                  nudge_x = 0.05*diff(range(df2$x))*sign(df2$x),
                  nudge_y = 0.05*diff(range(df2$y))*sign(df2$y),
                  alpha = 0.5, color = "gray30")
    }
    
    gg <- gg + theme_bw()
    return(gg)
  },
  { # d > 2 case ----
    if(is.null(class.name))
    { 
      class <- rep(1,nrow(Zpp))
      symb <- 20
      col  <- "black"
    } else
    { 
      symb <- rep(ppgmmga.options("classPlotSymbols"), length = nlevels(class))
      col  <- rep(ppgmmga.options("classPlotColors"), length = nlevels(class))
    }
    clPairs(data = Zpp, classification = class,
            symbols = symb, colors = col, ...)
  }
  )
}

nclass.numpy <- function(x, ...)
{
  x <- as.vector(x)
  max(nclass.Sturges(x), nclass.FD(x))
}

