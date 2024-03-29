# Default options used in 'ppgmmga' package

.ppgmmga <- list(
  # mclust 
  modelNames = c("EII", "VII", "EEI", "VEI", "EVI", "VVI", "EEE", "EVE", "VEE", "VVE", "EEV", "VEV", "EVV", "VVV"),
  G = 1:9,
  initMclust = "SVD",
  # GA
  popSize = 100,
  pcrossover = 0.8,
  pmutation = 0.1,
  maxiter = 1000,
  run = 100,
  selection = GA::gareal_lsSelection,
  crossover = GA::gareal_laCrossover,
  mutation = GA::gareal_raMutation,
  parallel = FALSE,
  numIslands = 4,
  migrationRate = 0.1,
  migrationInterval = 10,
  # GA - local search
  optim = TRUE, 
  optimPoptim = 0.05,
  optimPressel = 0.5,
  optimMethod = "L-BFGS-B",
  optimMaxit = 100,
  # ppgmmga
  orthDecomp = "QR",
  classPlotSymbols = c(16, 0, 17, 3, 15, 4, 1, 8, 2, 7, 5, 9, 6, 10, 11, 18, 12, 13, 14),
  # classPlotColors = tableau_color_pal(palette = "Classic 10")(10)
  classPlotColors = c(# ggthemes::tableau_color_pal("Classic 10")(4)
                      "#1f77b4", "#ff7f0e", "#2ca02c", "#d62728",
                      # ggthemes::tableau_color_pal("Tableau 20")(20)[c(10,2,4,6,11,8)]
                      "#86BCB6", "#A0CBE8", "#FFBE7D", "#8CD17D", 
                      "#E15759", "#F1CE63")
)

ppgmmga.options <- function(...)
{
  current <- get(".ppgmmga", envir = asNamespace("ppgmmga"))
  if(nargs() == 0) return(current)
  args <- list(...)
  if(length(args) == 1 && is.null(names(args))) 
  { arg <- args[[1]]
    switch(mode(arg),
           list = args <- arg,
           character = return(.ppgmmga[[arg]]),
           stop("invalid argument: ", dQuote(arg)))
  }
  if(length(args) == 0) return(current)
  n <- names(args)
  if(is.null(n)) stop("options must be given by name")
  current[n] <- args
  # browser()
  if(sys.nframe() == 1) 
    assign(".ppgmmga", current, envir = asNamespace("ppgmmga"))
  invisible(current)
}

