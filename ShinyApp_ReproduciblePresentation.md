Developing Data Products Course Project: Shiny App Reproducible Presentation
========================================================
author: Ximena Ramirez
date: 11/23/2020
autosize: true

Introduction
========================================================

There are many factors that can affect the mileage (miles per gallon/mpg) of an automobile. Using the `mtcars` dataset in the `datasets`package, a linear model was fit using the following variables:

- `am` : Transmission (automatic, manual)
- `cyl` : Number of cylinder (4, 6, or 8)
- `disp` : Displacement (cu.in)
- `wt` : Weight (lbs)

The shiny app created will **predict the MPG (US gal)** of an automobile based on the user's input of value of each of the above variables. [Try it out!](https://ximenalr.shinyapps.io/firstshinyapp/)

The Data 
========================================================

The data was loaded from the `datasets` package and then formatted in order to better understand the variables.


```r
#load data
data(mtcars)

#reformat variables
mtcars2 <- within(mtcars, {
    am <- factor(am, labels = c("automatic", "manual")) #transmission
    cyl  <- ordered(cyl) #number of cylinders
    wt <- 1000 * wt #weight in lbs
    })
```

Fitting a Linear Model
========================================================

The linear model used to predict MPG was the final model from a previous project. In summary, the variables chosen for the model were selected through ANOVA table.


```r
fit_final <- lm(mpg ~ disp + wt + cyl + am, data = mtcars2)
```
You can view the project [here](https://rpubs.com/ximenalr/regmodels_mtcars).

Model Coefficients
========================================================

This is the summary of the model.

```
                Estimate  Std. Error    t value     Pr(>|t|)
(Intercept) 30.275004533 3.290561817  9.2005579 1.166979e-09
disp         0.001632161 0.013756939  0.1186427 9.064703e-01
wt          -0.003249176 0.001249098 -2.6012170 1.512685e-02
cyl.L       -4.467787517 1.872176610 -2.3864135 2.458094e-02
cyl.Q        0.935361845 1.052357698  0.8888250 3.822469e-01
ammanual     0.141212000 1.326751152  0.1064344 9.160547e-01
```
