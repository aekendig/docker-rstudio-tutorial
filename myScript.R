# load packages
library(nlme)
library(ggplot2)

# examine data
head(npk)

# create a treatment variable
npk$treatment = as.factor(with(npk, paste(N, P, K, sep = "")))

# translate to nutrient treatment
treatments = data.frame(treatment = levels(npk$treatment),
                        nutrients = factor(c("ctrl", "K", "P", "P+K", "N", "N+K", "N+P", "N+P+K"), levels = c("ctrl", "N", "P", "K", "N+P", "P+K", "N+K", "N+P+K")))

# merge with dataset
npk2 <- merge(npk, treatments, all.x = T)

# initial visualization
ggplot(npk2, aes(x = nutrients, y = yield)) +
  geom_point() +
  facet_wrap(~block)

# fit regression
mod <- lme(yield ~ N*P*K, random = ~1|block, data = npk2)
summary(mod)
  
# visualize
ggplot(npk2, aes(x = nutrients, y = yield)) +
  stat_summary(geom = "point", fun.y = "mean", size = 2) +
  stat_summary(geom = "errorbar", fun.data = "mean_se", width = 0.1)
