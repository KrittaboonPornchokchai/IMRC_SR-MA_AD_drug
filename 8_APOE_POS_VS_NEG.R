# import pool data into R
library(readxl)
APOEPN <- read_excel("PoolData.xlsx", sheet = "APOE POS VS NEG")
View(APOEPN)
############################################

# calculate mean difference
library(meta)
library(metafor)

APOEPN_meta <- metabin(Event.e, Total.e, Event.c, Total.c, 
                      data = APOEPN, 
                      studlab = Study,
                      comb.fixed = TRUE,
                      comb.random = FALSE,
                      sm = "RR")
APOEPN_meta


# forest plot of meta analysis
forest(APOEPN_meta, 
       leftcols = c("Drug", "studlab", "event.e", "n.e", "event.c", "n.c"),
       rightcols = c("effect", "ci", "w.random"),
       xlim = c(0.2,5),
       col.diamond = "blue",
       frontsize = 6)

##############################################

#subgroup analysis
APOEPN_meta_subgroup <- metabin(Event.e, Total.e, Event.c, Total.c, 
                                data = APOEPN, 
                                studlab = Study,
                                subgroup = Drug,
                                comb.fixed = TRUE,
                                comb.random = FALSE,
                                sm = "RR")

forest(APOEPN_meta_subgroup,
       leftcols = c("Drug", "studlab", "event.e", "n.e", "event.c", "n.c"),
       rightcols = c("effect", "ci", "w.random"),
       col.diamond = "blue",
       xlim = c(0.2,5),
       frontsize = 6)

###########################################

#Funnel plot

#Design fill color
col.contour = c("gray75", "gray85", "gray95")

# funnel plot
funnel(APOEPN_meta, xlim = c(0.2,5),
       contour = c(0.9, 0.95, 0.99), 
       col.contour = col.contour)
legend(x = 1.6, y = 1.6,
       legend = c("p < 0.1)", "p < 0.05", "p < 0.01"),
       fill = col.contour)
title("Contour-Enhancement Funnel Plot (risk ratio of ARIA-E compare between APOE+ and APOE-)")
##########################################

# save forest plot
png(file = "Result/APOEPN.png", width = 3500, height = 2500, res =300)

forest(APOEPN_meta, 
       leftcols = c("Drug", "studlab", "event.e", "n.e", "event.c", "n.c"),
       rightcols = c("effect", "ci", "w.random"),
       xlim = c(0.2,5),
       col.diamond = "blue",
       frontsize = 6)

dev.off()

# save forest plot for subgroup
png(file = "Result/APOEPN_subgroup.png", width = 3500, height = 2500, res =300)

forest(APOEPN_meta_subgroup,
       leftcols = c("Drug", "studlab", "event.e", "n.e", "event.c", "n.c"),
       rightcols = c("effect", "ci", "w.random"),
       col.diamond = "blue",
       xlim = c(0.2,5),
       frontsize = 6)

dev.off()

#save funnel plot
png(file = "Result/APOEPN_funnelPlot.png", width = 3500, height = 2500, res =300)

funnel(APOEPN_meta, xlim = c(0.2,5),
       contour = c(0.9, 0.95, 0.99), 
       col.contour = col.contour)
legend(x = 1.6, y = 1.6,
       legend = c("p < 0.1)", "p < 0.05", "p < 0.01"),
       fill = col.contour)
title("Contour-Enhancement Funnel Plot (risk ratio of ARIA-E compare between APOE+ and APOE-)")

dev.off()
