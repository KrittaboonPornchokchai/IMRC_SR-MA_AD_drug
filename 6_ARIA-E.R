# import pool data into R
library(readxl)
ARIAE <- read_excel("PoolData.xlsx", sheet = "ARIA-E")
View(ARIAE)

############################################

# calculate mean difference
library(meta)
library(metafor)

ARIAE_meta <- metabin(Event.e, Total.e, Event.c, Total.c, 
                      data = ARIAE, 
                      studlab = Study,
                      comb.fixed = FALSE,
                      comb.random = TRUE,
                      sm = "RR")
ARIAE_meta


# forest plot of meta analysis
forest(ARIAE_meta, 
       leftcols = c("Drug", "studlab", "event.e", "n.e", "event.c", "n.c"),
       rightcols = c("effect", "ci", "w.random"),
       xlim = c(0.2,15),
       col.diamond = "blue",
       frontsize = 6)

##############################################

#subgroup analysis
ARIAE_meta_subgroup <- metabin(Event.e, Total.e, Event.c, Total.c, 
                              data = ARIAE, 
                              studlab = Study,
                              subgroup = Drug,
                              comb.fixed = FALSE,
                              comb.random = TRUE,
                              sm = "RR")

forest(ARIAE_meta_subgroup,
       leftcols = c("Drug", "studlab", "event.e", "n.e", "event.c", "n.c"),
       rightcols = c("effect", "ci", "w.random"),
       col.diamond = "blue",
       xlim = c(0.2,15),
       frontsize = 6)

###########################################

#Funnel plot

#Design fill color
col.contour = c("gray75", "gray85", "gray95")

# funnel plot
funnel(ARIAE_meta, xlim = c(0.2,15),
       contour = c(0.9, 0.95, 0.99), 
       col.contour = col.contour)
legend(x = 1.6, y = 1.6,
       legend = c("p < 0.1)", "p < 0.05", "p < 0.01"),
       fill = col.contour)
title("Contour-Enhancement Funnel Plot (risk ratio of ARIA-E)")
##########################################

# save forest plot
png(file = "Result/ARIA-E.png", width = 3500, height = 2500, res =300)

forest(ARIAE_meta, 
       leftcols = c("Drug", "studlab", "event.e", "n.e", "event.c", "n.c"),
       rightcols = c("effect", "ci", "w.random"),
       xlim = c(0.2,15),
       col.diamond = "blue",
       frontsize = 6)

dev.off()

# save forest plot for subgroup
png(file = "Result/ARIA-E_subgroup.png", width = 3500, height = 2500, res =300)

forest(ARIAE_meta_subgroup,
       leftcols = c("Drug", "studlab", "event.e", "n.e", "event.c", "n.c"),
       rightcols = c("effect", "ci", "w.random"),
       col.diamond = "blue",
       xlim = c(0.2,15),
       frontsize = 6)

dev.off()

#save funnel plot
png(file = "Result/ARIA-E_funnelPlot.png", width = 3500, height = 2500, res =300)

funnel(ARIAE_meta_subgroup, xlim = c(0.2,15),
       contour = c(0.9, 0.95, 0.99), 
       col.contour = col.contour)
legend(x = 1.6, y = 1.6,
       legend = c("p < 0.1)", "p < 0.05", "p < 0.01"),
       fill = col.contour)
title("Contour-Enhancement Funnel Plot (ARIA score improvement)")

dev.off()
