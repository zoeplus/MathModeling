R Cookbook
================
Zoe

# Pre

R Markdown supports different output. Using rtilces package, you can
output github markdown.

To use python, you need to set the python engine.

Note that both the R and Python values are available in environment.

``` r
vec <- 1:5
print(vec)
```

    ## [1] 1 2 3 4 5

``` r
mean(vec)
```

    ## [1] 3

``` r
sd(vec)
```

    ## [1] 1.581139

``` python
import torch
```

``` python
x = torch.arange(5)
print(x)
```

    ## tensor([0, 1, 2, 3, 4])

R’s markdown with no modification:

-   **Bold**
-   ==highlight not working==
-   *Italics*
-   <u>underline</u>

``` python
# code block still works but with no highlighting
import pandas as pd
for i in range(5):
  pass
```

``` r
# there're still some issue on highlighting
for i in 1:5 {
  pass
}
```
