##################################################################
# Example for determining minimum sample size for a traditional
# 1-way ANOVA with 4 groups using a simulation procedure
rm(list = ls())

# we want to know the TPR of obtaining a p-value < .01
p_values = c()

# define the population distributions
# we assume the grades within the groups follow a normal distribution
mu = c(
       6.5,    # Munich 
       7.5,    # Berlin
         7,    # Hamburg
         8     # Cologne
       )
sigma = 1.7

# we assume a sample size 
n = 100

# start the iterations
for (i in 1:1000) {
  
  # sample of size N from the defined population
  grade <- c(
    rnorm(n/4, mu[1], sigma),     # group 1: Munich
    rnorm(n/4, mu[2], sigma),     # group 2: Berlin
    rnorm(n/4, mu[3], sigma),     # group 3: Hamburg
    rnorm(n/4, mu[4], sigma)      # group 4: Cologne
  )
  
  # create and attach grouping variable
  city <- c(rep("Munich",n/4),    # group 1: Munich
             rep("Berlin",n/4),   # group 2: Berlin
             rep("Hamburg",n/4),  # group 3: Hamburg
             rep("Cologne",n/4))  # group 4: Cologne
  data <- data.frame(grade, city)
  
  # estimate the model for our sampled data
  fit <- anova(lm(grade ~ city, data = data))
  
  # store the obtained p-value
  p_values[i] <- fit$`Pr(>F)`[1]
}

# now we can calculate the TPR
# TPR = true positives / iterations
TPR = sum(p_values < .01) / 1000
print(TPR)

##################################################################
# Minimum sample size determination for TPR = 0.80
# we increase n until the power is sufficient

# first, we create an empty data frame to store the data
results_df <- data.frame(sample_size = integer(), TPR = numeric())

# use while function to iterate, until our preferred TPR is reached 
while(TPR < 0.80) {
 
  # simulation as before
  for (i in 1:1000) {
    # sample from the population of size N
    Y <- c(
      rnorm(n/4, mu[1], sigma),    # group 1
      rnorm(n/4, mu[2], sigma),    # group 2
      rnorm(n/4, mu[3], sigma),    # group 3
      rnorm(n/4, mu[4], sigma)     # group 4
    )
  
    # create and attach grouping variable
    group <- c(rep(1,n/4),         # group 1
               rep(2,n/4),          # group 2
               rep(3,n/4),          # group 3
               rep(4,n/4))          # group 4

    # create data frame
    data <- data.frame(group, Y)
    
    # estimate the model for our sampled data
    fit <- anova(lm(Y ~ group, data = data))
          
    # store the obtained p-value
    p_values[i] <- fit$`Pr(>F)`[1]
  }
  
  # calculate TPR      
  TPR = sum(p_values < .01) / 1000
  
    # track and store the data
    new_row <- data.frame(sample_size = n, TPR = TPR)
    results_df <- rbind(results_df, new_row)
    print(TPR)
  
  # increase n by 1 for each group
  n = n + 4
}

# minimum sample size determined!
print(n)

# results & visualization
print(results_df)
plot(results_df$sample_size, 
     results_df$TPR, 
     type = "b",
     pch = 20,
     ylim = c(0.45,0.85),
     xlab = "Sample Size",
     ylab = "TPR")
abline(h = 0.80, col = "red")
text(mean(results_df$sample_size), 0.80, "TPR = 0.80", col = "red", pos = 3)
