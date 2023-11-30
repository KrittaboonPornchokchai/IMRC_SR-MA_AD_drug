# import pool data into R
library(readxl)
ARIA <- read_excel("PoolData.xlsx", sheet = "ARIA")
View(ARIA)

############################################

# calculate mean difference
library(meta)
library(metafor)

ARIA_meta <- metabin(Event.e, Total.e, Event.c, Total.c, 
                     data = ARIA, 
                     studlab = Study,
                     comb.fixed = FALSE,
                     comb.random = TRUE,
                     sm = "RR")
ARIA_meta


# forest plot of meta analysis
forest(ARIA_meta, 
       leftcols = c("Drug", "studlab", "event.e", "n.e", "event.c", "n.c"),
       rightcols = c("effect", "ci", "w.random"),
       xlim = c(0.2,7),
       col.diamond = "blue",
       frontsize = 6)

##############################################

#subgroup analysis
ARIA_meta_subgroup <- metabin(Event.e, Total.e, Event.c, Total.c, 
                              data = ARIA, 
                              studlab = Study,
                              subgroup = Drug,
                              comb.fixed = FALSE,
                              comb.random = TRUE,
                              sm = "RR")

forest(ARIA_meta_subgroup,
       leftcols = c("Drug", "studlab", "event.e", "n.e", "event.c", "n.c"),
       rightcols = c("effect", "ci", "w.random"),
       col.diamond = "blue",
       xlim = c(0.2,7),
       frontsize = 6)

###########################################

#Funnel plot

#Design fill color
col.contour = c("gray75", "gray85", "gray95")

# funnel plot
funnel(ARIA_meta,xlim = c(0.2,7),
       contour = c(0.9, 0.95, 0.99), 
       col.contour = col.contour)
legend(x = 1.6, y = 1.6,
       legend = c("p < 0.1)", "p < 0.05", "p < 0.01"),
       fill = col.contour)
title("Contour-Enhancement Funnel Plot (risk ratio of ARIA)")

##########################################

# save forest plot
png(file = "Result/ARIA.png", width = 3500, height = 2500, res =300)

forest(ARIA_meta, 
       leftcols = c("Drug", "studlab", "event.e", "n.e", "event.c", "n.c"),
       rightcols = c("effect", "ci", "w.random"),
       xlim = c(0.2,7),
       col.diamond = "blue",
       frontsize = 6)

dev.off()

# save forest plot for subgroup
png(file = "Result/ARIA_subgroup.png", width = 3500, height = 2500, res =300)

forest(ARIA_meta_subgroup,
       leftcols = c("Drug", "studlab", "event.e", "n.e", "event.c", "n.c"),
       rightcols = c("effect", "ci", "w.random"),
       col.diamond = "blue",
       xlim = c(0.2,7),
       frontsize = 6)

dev.off()

#save funnel plot
png(file = "Result/ARIA_funnelPlot.png", width = 3500, height = 2500, res =300)

funnel(ARIA_meta_subgroup, xlim = c(0.2,7),
       contour = c(0.9, 0.95, 0.99), 
       col.contour = col.contour)
legend(x = 1.6, y = 1.6,
       legend = c("p < 0.1)", "p < 0.05", "p < 0.01"),
       fill = col.contour)
title("Contour-Enhancement Funnel Plot (ARIA score improvement)")

dev.off()

