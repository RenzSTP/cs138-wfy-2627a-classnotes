// STYLING PREAMBLE

#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true, first-line-indent: 2.0em)
#show title: set align(center)
#show title: set text(size: 48pt)

  // I really hate how this is not the default
#set math.mat(delim: "[")

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

// IMPORTS
#import "../assets.typ": notes, definition, theorem, algorithm, example, note, section-subheading, section-emphasis, solution-box

/// END STYLING PREAMBLE




// SECTION HEADER
#show: notes.with(
  title: [The Cauchy-Euler Equation],
)


// SECTION SUBHEADER1

Suppose we have the Euler equation

$ a x^2 y'' +  b x y' + c y = 0 $

Using standard series methods for this equation would not be possible since they fail at the singular point $x_0 = 0$. We need to use a different approach. This is where Cauchy-Euler substitution comes in, so that we can transform the equation's problematic variable coefficients ($a x^2$, $b x$) into constant coefficients. 

\
// SECTION SUBHEADER2
#section-subheading("1", "Cauchy-Euler Substitution")

Given the ODE  
$ a x^2 y'' + b x y' + c y = 0  $
with $a, b, c in RR$, we can use the substitution $x = e^t$

Deriving $x$ with respect to $t$, we have\
$(d x)/(d t) = e^t$

Obtaining $y'$ and $y''$, \
$=> (d y)/(d x) = (d y) / (d t) dot (d t) / (d x) = (d y)/(d t) e^(-t) $ \
$=> (d^2 y)/(d x^2) = e^(-2t) [(d^2 y)/(d t^2) - (d y)/(d t)]$

Plugging $x$, $y'$, and $y''$ into our original ODE, we get \
$a (e^t)^2 (e^(-2t) [(d^2 y)/(d t^2) - (d y)/(d t)]) + b (e^t) ((d y)/(d t) e^(-t)) + c y = 0$

Simplifying and combining like terms, we have \
$=> a[(d^2 y)/(d t^2) - (d y)/(d t)] + b dot (d y)/(d t) + c y = 0$ \
$=> a dot (d^2 y)/(d t^2) + (b - a) dot (d y)/(d t) + c y = 0$

#solution-box[$therefore a y'' + (b-a) y' + c y = 0$]

This is the Cauchy-Euler Equation.
\ 

#definition(name: "Cauchy-Euler Substitution")[ \
Given the ODE  

#align(center)[$a x^2 y'' + b x y' + c y = 0,$ #h(1.5em) $y=y (x)$]

with $x = e^t$, then

#align(center)[$a y'' + (b-a) y' + c y = 0,$ #h(1.5em) $y=y (t) = y(ln x)$]

with $y = e^(r t) = x^r$, you can obtain the indicial equation:

#align(center)[$a r^2 + (b-a) r + c = 0$]
]
#h(1em) Depending on the roots, we have the following $y(t)$, $x = e^t$: \
#h(2em) - *Real Distinct $r = r_1, r_2$.* $ y(t) = C_1 e^(r_1 t) + C_2 e^(r_2 t)$ \
#h(2em) - *Real Repeated $r$.* $ y(t) = (C_1 + C_2 t) e^(r t)$ \
#h(2em) - *Complex $r = a plus.minus b i$.* $y(t) = C_1 e^(a t) cos(b t) + C_2 e^(a t) sin(b t)$

#h(1em) Since $x = e^t$, then $t = ln x$, which we can substitute back to x to obtain their corresponding $y(x)$: \
#h(2em) - *Real Distinct $r = r_1, r_2$.* $y(x) = C_1 x^(r_1) + C_2 x^(r_2)$ \
#h(2em) - *Real Repeated $r$.* $y(x) = (C_1 + C_2 ln x) x^r$ \
#h(2em) - *Complex $r = a plus.minus b i$.* $y(x) = C_1 x^(a) cos(b ln x) + C_2 x^(a ) sin(b ln x)$
#example(number: "1")[
  Solve $x^2 y'' - 6 x y' - 18y = 0$ \
  Let $x = e^t$, we then get the following equation: \
  $=> y'' + (-6 - 1)y' -18y = 0$ \
  $=> y'' - 7y' -18y = 0$ \
  $=> (D^2 - 7D - 18)y = 0$

  The indicial equation is: $r^2 - 7r - 18 = 0$ \ 
  Solving for r: \
  $(r+2) (r-9) = 0$ \
  $therefore r = -2, 9$ \ 

  Observe that the roots are real and distinct. Therefore, based on what we mentioned earlier, we have the following: \
  $y(t) = C_1 e^(r_1 t) + C_2 e^(r_2 t) = C_1 e^(-2t) + C_2 e^(9t)$ \ \
  Substituting $t = ln x$:
  #solution-box[$y(x) = C_1 x^(-2) + C_2 x^(9)$]
]

#example(number: "2")[
  Solve $x^2 y'' - 7x y + 16y = 0$ \
  Let $x = e^t$, we then get the following equation: \
  $=> y'' + (-7 - 1)y' + 16y = 0$ \
  $=> y'' - 8y' + 16y = 0$ \
  $=> (D^2 - 8D + 16)y = 0$

  The indicial equation is: $r^2 - 8r + 16 = 0$ \ 
  Solving for r: \
  $(r - 4)^2 = 0$ \ 
  $therefore r = -4, $ multiplicity $2$

  Observe that the root is a real repeated root. Therefore, based on what we mentioned earlier, we have the following: \
  $y(t) = C_1 e^(4t) + C_2 t e^(4t)$ \
  $=> y(t) = e^(4t) (C_1 + C_2 t)$
  
  Substituting $t = ln x$: \
  $y(x) = C_1 x^4 + C_2 (ln x) x^4$ \
  $=> y(x) = x^4 (C_1 + C_2 ln x)$
  #solution-box[$y(x) = x^4 (C_1 + C_2 ln x)$]
]

#example(number: "3")[
  Solve $2x^2 y''+ 5y = 0$ \
  Let $x = e^t$, we then get the following equation: \
  $=> 2y'' + (0 - 1)y' + 5y = 0$ \
  $=> 2y'' - y' + 5y = 0$ \
  $=> (2D^2 - D + 5)y = 0$

  The indicial equation is: $2r^2 - r + 5 = 0$ \ 
  Using the quadratic formula, we get: \
  $r = (1 plus.minus 3 i)/2$ \ 

  Observe that the roots are complex. Therefore, based on what we mentioned earlier, we have the following: \
  $y(t) = C_1 e^(a t) cos(b t) + C_2 e^(a t) sin(b t) = C_1 e^(1/2 t) cos(3/2 t) + C_2 e^(1/2 t) sin(3/2 t)$ \ \
  Substituting $t = ln x$: \
  $y(x) = C_1 x^(1/2) cos(3/2 ln x) + C_2 x^(1/2) sin(3/2 ln x)$
  #solution-box[$y(x) = x^(1/2) (C_1 cos(3/2 ln x) + C_2  sin(3/2 ln x))$]
]

#example(number: "4")[
  Solve $x^2 y'' + x y + 9y = 0$ \
  Let $x = e^t$, we then get the following equation: \
  $=> y'' + (1 - 1)y' + 9y = 0$ \
  $=> y'' + 9y = 0$ \
  $=> (D^2 + 9)y = 0$

  The indicial equation is: $r^2 + 9= 0$ \ 
  Using the quadratic formula, we get: \
  $r = plus.minus 3i$

  Observe that the roots are complex. Therefore, based on what we mentioned earlier, we have the following: \
  $y(t) = C_1 cos(3t) + C_2 sin(3t)$ \
  
  Substituting $t = ln x$: \
  $y(x) = C_1 cos(3 ln x) + C_2 sin(3 ln x)$ \
  #solution-box[$y(x) = C_1 cos(3 ln x) + C_2 sin(3 ln x)$]
]

\ 



