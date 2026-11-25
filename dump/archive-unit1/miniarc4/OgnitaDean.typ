#import "../assets.typ": notes, definition, theorem, algorithm, example, note

#show: notes.with(
  title: [Using Rayleigh's Quotient],
  subtitle: [ Arc 4 · Ognita Remix Problems ])

  *Exercise 19.* Following along the line of Exercise 11 in Section 6.3 and Exercise 15 in Section 7.2, suppose that a species of beetle has a life span of 4 years, and that a female in the first year has a survival rate of $1/2$, in the second year a survival rate of $1/4$, and in the third year a survival rate of $1/8$.  Suppose additionally that a female gives birth, on the average, to two new females in the third year and to four new females in the fourth year.  The matrix describing a single female's contribution in 1 year to the female population in the succeeding year is
\
$
A = mat(delim:"[",
,0, 0, 2, 4,;
,1/2, 0, 0, 0,;
,0, 1/4, 0, 0,;
,0, 0, 1/8, 0,;
column-gap: #1em,
)
$
where again the entry in the #emph[i]th row and the #emph[j]th column denotes the probabilistic contribution that a female of age j makes on the next year's female population of age _i_.\


== Rayleigh Quotient Solution
#definition(name: "Rayleigh quotient")[
  $ R(x) = (x^top A x) slash (x^top x), quad x != 0. $
]

Sanity Check: \
Calculating the characteristic polynomial $ p(lambda) = lambda dot lambda^3 + (-2)(+1)(lambda/8) + (-4)(-1)(-1/64) \ = lambda^4 - 1/4 lambda - 1/16. $ 

$ sigma_1 = R(1, 1, 1, 1) = ((1, 1, 1, 1) A (1, 1, 1, 1)^top)/((1, 1, 1, 1) (1, 1, 1, 1)^top) = (6 + 1/2 + 1/4 + 1/8)/4, $

$ sigma_1 = 55/32 = 1.71875. $


$
  -sigma w_1 + 2 w_3 + 4 w_4 &= 1 &"(row 1)"\
  1/2 w_1 - sigma w_2 &= 1 &"(row 2)"\
  1/4 w_2 - sigma w_3 &= 1 &"(row 3)"\
  1/8 w_3 - sigma w_4 &= 1 &"(row 4)"
$


$
  w_2 &= (16 w_1 - 32)/55 = 0.2909090909 w_1 - 0.5818181818,\
  w_3 &= (8 w_2 - 32)/55 = 0.1454545455 w_2 - 0.5818181818,\
  w_4 &= (4 w_3 - 32)/55 = 0.0727272727 w_3 - 0.5818181818.
  $

$ w_1 "with" sigma &= 55/32 space , space 1 slash sigma = 32 slash 55 = 0.5818181818 \
  w_2 &= (16 w_1 - 32)/55 = 0.2909090909 w_1 - 0.5818181818,\
  w_3 &= (8 w_2 - 32)/55 = 0.1454545455 w_2 - 0.5818181818,\
  w_4 &= (4 w_3 - 32)/55 = 0.0727272727 w_3 - 0.5818181818.
$

$ w = (-2.992972981, -1.452501231, -0.7930910881, -0.6394975337) : quad abs(abs(w))_infinity = w_1, \
x^((1)) = w slash w_1 = (1, 0.4853038233, 0.2649843795, 0.2136663237). $

== Repeating the Iteration Scheme
#figure(
  table(
    columns: (auto, auto, auto),
    align: (center, center, center),
    inset: 5pt,
    table.header([$k$], [$x^((k))$], [$R(x^((k)))$], ),
    [$1$], [$(1, 0.485304, 0.264984, 0.213666)$], [$1.2331843139$], 
    [$2$], [$(1, 0.575113, 0.209228, 0.095904)$], [$0.8110110205$], 
    [$3$], [$(1, 0.698314, 0.245019, 0.051405)$], [$0.7025427265$], 
    [$4$], [$(1, 0.716606, 0.256726, 0.046039)$], [$0.6976570027$], 
    [$5$], [$(1, 0.716673, 0.256810, 0.046012)$], [$0.6976684977$], 
    [$6$], [$(1, 0.716673, 0.256810, 0.046012)$], [$0.6976684972$], 
  ),
  caption: [Rayleigh quotient iteration from $(1, 1, 1, 1)$. The shift at step $k$ is $R$ of the previous row, the last row is at the precision of the ten decimals With $ lambda_1 approx 0.6976684972  $  ]
) #pagebreak()
= Shifted Inverse Power Method, fixed shift
Using the rational  root theorem we can evaluate possible values in the characteristic polynomial in Equation (3)

#figure(
  table(
    columns: (auto, auto, auto),
    align: (center, center, right),
    inset: 5pt,
    table.header([$lambda = p slash q$], [$p(lambda)$], [Approx. Decimal Value]),
    [$-1$], [$19/16$], [$1.1875$],
    [$-1/2$], [$1/8$], [$0.125$],
    [$-1/4$], [$1/256$], [$0.00390625$],
    [$-1/8$], [$-127/4096$], [$-0.031005859$],
    [$-1/16$], [$-3071/65536$], [$-0.046859741$],
    [$1/16$], [$-5119/65536$], [$-0.078109741$],
    [$1/8$], [$-383/4096$], [$-0.093505859$],
    [$1/4$], [$-31/256$], [$-0.12109375$],
    [$1/2$], [$-1/8$], [$-0.125$],
    [$1$], [$11/16$], [$0.6875$],
  ),
  caption: [The rational root theorem applied to Equation 3. ],
)

Using this we can decide the shift to be $-1/4$ as the closest value to 0. We can get 

$ sigma = -1/4 "and" x^((0)) = (1, 1, 1, 1)", we get  system:"
(A + 1/4 I) w = x^((0)) $ 

$
  1/4 w_1 + 2 w_3 + 4 w_4 &= 1\
  1/2 w_1 + 1/4 w_2 &= 1 quad ==> quad w_2 = 4 - 2 w_1\
  1/4 w_2 + 1/4 w_3 &= 1 quad ==> quad w_3 = 4 - w_2 = 2 w_1\
  1/8 w_3 + 1/4 w_4 &= 1 quad ==> quad w_4 = 4 - w_3 slash 2 = 4 - w_1
$

$ 1/4 w_1 + 2(2 w_1) + 4(4 - w_1) = 1 quad ==> quad 1/4 w_1 = 1 - 16 = -15, quad w_1 = -60, $

$ w = (-60, 124, -120, 64), quad abs(abs(w))_infinity = 124, $


$ x^((1)) = w / abs(abs(w))_infinity = (-15/31, 1, -30/31, 16/31) = (-0.483871, 1, -0.967742, 0.516129). $

$ lambda^(1)_2 = (-585/961) slash (2342/961) = -585/2342 = -0.2497865073. $

== Repeating the Iteration Scheme
#figure(
  table(
    columns: (auto, auto, auto,),
    align: (center, center, center,),
    inset: 4pt,
    table.header([$k$], [$x^((k))$], [$lambda^(k)_2$]),
    [$1$], [$(-0.48387, 1, -0.96774, 0.51613)$], [$-0.2497865073$], 
    [$2$], [$(0.44942, -0.95025, 1, -0.52653)$], [$-0.2370125934$], 
    [$3$], [$(0.45050, -0.94923, 1, -0.52673)$], [$-0.2373064719$], 
    [$4$], [$(0.45054, -0.94925, 1, -0.52673)$], [$-0.2373134475$], 
    [$5$], [$(0.45054, -0.94925, 1, -0.52673)$], [$-0.2373133124$],
    [$6$], [$(0.45054, -0.94925, 1, -0.52673)$], [$-0.2373133087$]
  ),
  caption: [Shifted inverse iteration with the fixed shift $sigma = -1/4$, $x^k$ shown to five decimals and $lambda^(k)_2$. With $ lambda_2 approx -0.2373133087 $ ],
)
= Reference:
1. Burden, R. L. & Faires, J. D. (1978). _Numerical Analysis_.