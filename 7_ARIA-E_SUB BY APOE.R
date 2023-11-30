# import pool data into R
library(readxl)
APOE <- read_excel("PoolData.xlsx", sheet = "APO-E")
View(APOE)

############################################

# calculate mean difference
library(meta)
library(metafor)

##############################################

#subgroup analysis
APOE_meta_subgroup <- metabin(Event.e, Total.e, Event.c, Total.c, 
                               data = APOE, 
                               studlab = Study,
                               subgroup = APOE,
                               comb.fixed = FALSE,
                               comb.random = TRUE,
                               sm = "RR")

forest(APOE_meta_subgroup,
       leftcols = c("Drug", "studlab", "event.e", "n.e", "event.c", "n.c"),
       rightcols = c("effect", "ci", "w.random"),
       col.diamond = "blue",
       xlim = c(0.2,40),
       frontsize = 6)

###########################################

#Funnel plot

#Design fill color
col.contour = c("gray75", "gray85", "gray95")

# funnel plot
funnel(APOE_meta_subgroup, xlim = c(0.2,15),
       contour = c(0.9, 0.95, 0.99), 
       col.contour = col.contour)
legend(x = 1.6, y = 1.6,
       legend = c("p < 0.1)", "p < 0.05", "p < 0.01"),
       fill = col.contour)
title("Contour-Enhancement Funnel Plot (risk ratio of ARIA-E SUBGROUP BY APOE+/-)")
##########################################

# save forest plot for subgroup
png(file = "Result/APOE_subgroup.png", width = 3500, height = 2500, res =300)

forest(APOE_meta_subgroup,
       leftcols = c("Drug", "studlab", "event.e", "n.e", "event.c", "n.c"),
       rightcols = c("effect", "ci", "w.random"),
       col.diamond = "blue",
       xlim = c(0.2,40),
       frontsize = 6)

dev.off()

#save funnel plot
png(file = "Result/APOE_funnelPlot.png", width = 3500, height = 2500, res =300)

funnel(APOE_meta_subgroup, xlim = c(0.2,15),
       contour = c(0.9, 0.95, 0.99), 
       col.contour = col.contour)
legend(x = 1.6, y = 1.6,
       legend = c("p < 0.1)", "p < 0.05", "p < 0.01"),
       fill = col.contour)
title("Contour-Enhancement Funnel Plot (risk ratio of ARIA-E SUBGROUP BY APOE+/-)")

dev.off()

