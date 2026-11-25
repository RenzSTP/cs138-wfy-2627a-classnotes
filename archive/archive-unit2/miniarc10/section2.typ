// STYLING PREAMBLE

#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true, first-line-indent: 2.0em)
#show title: set align(center)
#show title: set text(size: 48pt)

  // I really hate how this is not the default
#set math.mat(delim: "[")
#set math.vec(delim: "[")

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

// IMPORTS
#import "../assets.typ": notes, definition, theorem, algorithm, example, note, section-subheading, section-emphasis

/// END STYLING PREAMBLE




// SECTION HEADER
#show: notes.with(
  title: [Nonlinear FDA: The Solution],
)


// SECTION SUBHEADER1
#section-subheading("1", "The Algorithm")
As explained in the detour section, we can take inspiration from Newton's method to derive an algorithm to numerically solve nonlinear BVPs.

\

#algorithm(name: "Nonlinear Finite Difference Approximation")[
- Step 1: replace n-th derivative variables with their FDA counterparts 
- Step 3: Write as a root finding problem $F(bold(x))=0$
- Step 4: Compute $J_F (bold(x)^((k)))$
- Step 2: Define an initial guess value $x^((0))$
- Step 5: Solve the linear SLE $J_F (bold(x)^((k))) Delta bold(x)^)((k)) = -F(bold(x)^((k)))$
- Step 6: $bold(x)^((k+1)) <- bold(x)^((k))+ Delta bold(x)^((k))$
]

\ 

// SECTION SUBHEADER2
#section-subheading("2", "Worked Example")
#example(number: "1")[
  Solve the nonlinear BVP using 3 interior points:
$
y'' = e^y y', y(0) = alpha = -ln 2, y(1) = beta = 0
$
*Note:* True solution is $y = -ln(2 - x)$
]
Central FDA variant is used.
\
\
Recall that the central FDA formulas are the following: $y'(x_i) approx (y_(i+1) - y_(i-1)) / (2h), quad y''(x_i) approx (y_(i+1) - 2y_i + y_(i-1)) / (h^2)$

Substituting into $y'' = e^y y'$ for $i = 1, 2, 3$,
$
(y_(i+1) - 2y_i + y_(i-1)) / (h^2) = e^(y_i) (y_(i+1) - y_(i-1)) / (2h)
$

Defining $F_i$,
$
F_i (y_(i-1), y_i, y_(i+1)) = (y_(i+1) - 2y_i + y_(i-1)) / (h^2) - e^(y_i) (y_(i+1) - y_(i-1)) / (2h) = 0, quad i = 1, 2, 3
$

#pagebreak()
With $h = 0.25$, we get:
$F_i = 16(y_(i+1) - 2y_i + y_(i-1)) - 2 e^(y_i) (y_(i+1) - y_(i-1)) = 0$
Note that $y_0 = alpha, y_4=beta$. 

\
We then define the following variables to be used for the SLEs:
$ 
bold(y) = vec(y_1, y_2, y_3), quad bold(F)(bold(y)) = vec(F_1(bold(y)), F_2(bold(y)), F_3(bold(y))) 
$

Partial differentiating with respect to each variable:

$
(partial F_i)/(partial y_(i-1)) = 16 + 2 e^(y_i)
$
$
(partial F_i)/(partial y_i) = -32 - 2 e^(y_i) (y_(i+1) - y_(i-1))
$
$
(partial F_i)/(partial y_(i+1)) = 16 - 2 e^(y_i)
$

Final SLE variables:
$
J_F (bold(x)) Delta bold(x) = bold(y)
$
$ mat(
      -32 - 2e^(y_1)(y_2 - alpha), 16 - 2e^(y_1), 0;
      16 + 2e^(y_2), -32 - 2e^(y_2)(y_3 - y_1), 16 - 2e^(y_2);
      0, 16 + 2e^(y_3), -32 - 2e^(y_3)(beta - y_2)
    ) Delta bold(x)^((k)) = \ -mat(
    16(y_2 - 2y_1 + alpha) - 2e^(y_1)(y_2 - alpha);
    16(y_3 - 2y_2 + y_1) - 2e^(y_2)(y_3 - y_1);
    16(beta - 2y_3 + y_2) - 2e^(y_3)(beta - y_2)
  ),
$
Initial guess: $bold(y)^((0))=y_"line"(x) = alpha + (beta - alpha)(x - alpha)/(b - alpha)$
\ 
\
Running the algorithm for one iteration yields:
$
bold(y)^( (0) ) = mat(y_(l i n e)(0.25); y_(l i n e)(0.50); y_(l i n e)(0.75)) = mat(-0.51986039; -0.34657359; -0.17328680)
$
$
bold(y)^( (1) ) approx mat(-0.55931807; -0.40509582; -0.22293384), #text("Error") = (2.98 times 10^(-4), 3.69 times 10^(-4), 2.10 times 10^(-4))
$