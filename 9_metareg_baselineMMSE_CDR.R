library(readxl)
CDR <- read_excel("PoolData.xlsx", sheet = "CDR")
View(CDR)

############################################
#CRD-baseline MMSE
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

MMSE_base <- c(26.3, 26.3, 26.4, 26.4, 25.5, 22.4)

CDR_meta_reg <- metareg(CDR_meta, ~MMSE_base)
CDR_meta_reg

bubble(CDR_meta_reg, studlab = TRUE)
regplot(CDR_meta_reg, pred = TRUE, 
        label = TRUE, 
        xlab = "baseline MMSE",
        ylab = "Mean different of CDR-SB",
        plim = c(2,5))

# save regplot
png(file = "Result/meta_regress_MMSE_CDR.png", width = 3000, height = 2100, res =300)

regplot(CDR_meta_reg, pred = TRUE, 
        label = TRUE, 
        xlab = "baseline MMSE",
        ylab = "Mean different of CDR-SB",
        plim = c(2,5))

dev.off()
##############################################
#ADAS-Cog
ADAS <- read_excel("PoolData.xlsx", sheet = "ADAS")
View(ADAS)

ADAS_meta <- metacont(n_drug, mean_drug, sd_drug, n_placebo, mean_placebo, 
                      sd_placebo, 
                      data = ADAS, 
                      studlab = Study,
                      comb.fixed = TRUE,
                      comb.random = FALSE,
                      sm = "MD")
ADAS_meta

ADAS_meta_reg <- metareg(ADAS_meta, ~MMSE_base)
ADAS_meta_reg

bubble(ADAS_meta_reg, studlab = TRUE)
#########################################
#ARIA.E

ARIAE <- read_excel("PoolData.xlsx", sheet = "ARIA-E")
View(ARIAE)


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

CDR_Change <- c(-0.39, -0.26, 0.03, -0.18, -0.45, -0.7)
ADAS_change <- c(-1.4, -0.7, -0.59, -0.58, -1.44, -1.35)

ARIAE_meta_reg <- metareg(ARIAE_meta, ~CDR_Change+ADAS_change)
ARIAE_meta_reg

bubble(ARIAE_meta_reg, studlab = TRUE)
#########################################

ARIA <- read_excel("PoolData.xlsx", sheet = "ARIA")
View(ARIA)

ARIA_meta <- metabin(Event.e, Total.e, Event.c, Total.c, 
                     data = ARIA, 
                     studlab = Study,
                     comb.fixed = FALSE,
                     comb.random = TRUE,
                     sm = "RR")
ARIA_meta
ARIA_meta_reg <- metareg(ARIA_meta, ~ADAS_change)
ARIA_meta_reg

bubble(ARIA_meta_reg, studlab = TRUE)
##########################################


