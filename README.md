# Build-your-own-lm-function-with-Normal-Equation-in-R

The grand *'lm()'* function in R is the 'Hello World' for statistics researchers and ML learners.       

While the function is already well-built and easy to use, it is good for data guys to understand what is going on under the hood.      

The attached R file contains a function that implements the Linear Regression, which outputs the coefficient estimates as well as their Standard Errors, t-values, and p-values.         

The realization employees the famous Normal Equation B = (X'X)-1(X'Y), where X stands for the covariate (independent variable) matrix and Y stands for the dependent variable vector.    
