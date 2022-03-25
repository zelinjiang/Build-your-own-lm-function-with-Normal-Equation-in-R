
###########################################
### Part 1: Let us build a my_lm *function*
###########################################

my_lm = function(y,x) {
  
  n = nrow(x)                    # number of observations
  
  one = matrix(1,n,1)            # creates column of ones for the intercept beta_0
  xx = as.matrix(cbind(one,x))   # attaches ones to the x data
  p = ncol(xx)                   # number of variables in xx data
  
  xpx = t(xx) %*% xx             # X'X matrix, t() denotes transpose
  xpxi = solve(xpx)              # solve() inverts the matrix X'X
  xpy = t(xx) %*% y              # X'Y matrix
  bhat = xpxi %*% xpy            # estimate bhat = Inverse(X'X)*X'Y as per OLS estimator
  
  yhat = xx %*% bhat             # forecasted y values = X*bhat
  err = y-yhat                   # residuals = y - yhat
  sse = t(err) %*% err           # sum of square residuals to compute error variance s2
  
  s2 = sse/(n-p)                 # error variance, sigma^2
  se = sqrt(c(s2)*diag(xpxi))    # standard errors of bhat given by diagonal of sigma^2 * Inverse(X'X)
  tval = (bhat - 0)/se           # t-values = estimates divided by their std errors
  pval = 1 - pt(abs(bhat), df = n-p)  # Prob. of getting this beta value (or higher beta value) assuming beta = 0
  
  my_out = cbind(bhat, se, tval, pval)    # output from my OLS built from first principles
  colnames(my_out) = c("Estimates", "Std Errors", "t-values", "p-values")
  rownames(my_out) = c("Intercept","Independent Vars")

  CI_lb = bhat - qt(0.975, df=n-p)*se		# lower bound based on t-dist
  CI_ub = bhat + qt(0.975,df=n-p)*se 		# upper bound based on t-dist

  my_CI = cbind(CI_lb, CI_ub)
  colnames(my_CI)= c("2.5%", "97.5%")
  rownames(my_CI)=c("Intercept","Independent Vars")
  
  return(list(my_out, my_CI)) 	
  
  # R returns only ONE output. If you have more than one output, create a list(out1, out2, out3, etc) to return  multiple outputs. 
  }


########################################
# PART Two: Calling the function output 
########################################

setwd("xxxx")  # Set the working directory to your data's directory

data = read.csv("abc.csv", header=T)    # read csv file and label the data as "data"

# Extract the dependent variable and independent variables, convert them into matrices
Y = as.matrix(data[,n])       # assuming that your dependent variable is the last column
X = as.matrix(data[,1:n-1])   # adjust the n and n-1 to suit your data
mylm_out = my_lm(y.in,x.in)

print("Results from *my_lm()* function!"); mylm_out

# Extract a specific ouput, say, confidence interval

CI_out = mylm_out[[2]]

# print command via the parenthesis ()

(round(CI_out, digits = 4)) 	# upto 4 numbers after the decimal


############################################
# PART FIVE: Saving the outputs to text file
############################################

sink("compare R Built-in lm with My LM.txt", append = F, split=T)

print("My LM Estimates"); round(mylm_out[[1]], digits = 4) 

print("My LM Confidence Intervals"); round(mylm_out[[2]], digits = 4) 

## Compare the results with the builtin lm() function, you will find they are the same!
print("R built-in Output"); summary(lm_out)
print("R built-in Confidence Intervals");  confint(lm_out, level = 0.95)

sink()




  