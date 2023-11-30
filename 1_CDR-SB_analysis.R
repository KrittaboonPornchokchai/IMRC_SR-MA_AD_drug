# import pool data into R
library(readxl)
CDR <- read_excel("PoolData.xlsx", sheet = "CDR")
View(CDR)

############################################

# calculate mean difference
library(meta)
library(metafor)

CDR_meta <- metacont(n_drug, mean_drug, sd_drug, n_placebo, mean_placebo, 
                    sd_placebo, 
                    data = CDR, 
                    studlab = Study,
                    comb.fixed = FALSE,
                    comb.random = TRUE,
                    sm = "MD")
CDR_meta


# forest plot of meta analysis
forest(CDR_meta,
       leftcols = c("Drug", "studlab", "w.random", "effect", "ci"),
       col.diamond = "blue",
       xlim = c(-1,1),
       frontsize = 6)

##########################################

# subgroup analysis
CDR_meta_subgroup <- metacont(n_drug, mean_drug, sd_drug, n_placebo, mean_placebo, 
                              sd_placebo, 
                              data = CDR, 
                              studlab = Study,
                              subgroup = Drug,
                              comb.fixed = FALSE,
                              comb.random = TRUE,
                              sm = "MD")


# forest plot for subgroup analysis
forest(CDR_meta_subgroup,
       leftcols = c("Drug", "studlab", "w.random", "effect", "ci"),
       col.diamond = "blue",
       xlim = c(-1,1),
       frontsize = 6)

#########################################

#Funnel plot

#Design fill color
col.contour = c("gray75", "gray85", "gray95")

# funnel plot
funnel(CDR_meta_subgroup, xlim = c(-0.7, 0.5),
       contour = c(0.9, 0.95, 0.99), 
       col.contour = col.contour)
legend(x = 1.6, y = 1.6,
       legend = c("p < 0.1)", "p < 0.05", "p < 0.01"),
       fill = col.contour)
title("Contour-Enhancement Funnel Plot (CDB-SB score improvement)")

########################################

# save forest plot
png(file = "CDR-SB.png", width = 3500, height = 2500, res =300)

forest(CDR_meta,
       leftcols = c("Drug", "studlab", "w.random", "effect", "ci"),
       col.diamond = "blue",
       xlim = c(-1,1),
       frontsize = 6)

dev.off()

# save forest plot for subgroup
png(file = "CDR-SB_subgroup.png", width = 3500, height = 2500, res =300)

forest(CDR_meta_subgroup,
       leftcols = c("Drug", "studlab", "w.random", "effect", "ci"),
       col.diamond = "blue",
       xlim = c(-1,1),
       frontsize = 6)

dev.off()

#save funnel plot
png(file = "CDR-SB_funnelPlot.png", width = 2800, height = 2500, res =300)

funnel(CDR_meta_subgroup, xlim = c(-0.7, 0.5),
       contour = c(0.9, 0.95, 0.99), 
       col.contour = col.contour)
legend(x = 1.6, y = 1.6,
       legend = c("p < 0.1)", "p < 0.05", "p < 0.01"),
       fill = col.contour)
title("Contour-Enhancement Funnel Plot (CDB-SB score improvement)")

dev.off()
