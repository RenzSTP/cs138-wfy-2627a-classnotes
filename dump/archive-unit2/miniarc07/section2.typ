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
#import "../assets.typ": notes, definition, theorem, algorithm, example, note, section-subheading, section-emphasis

/// END STYLING PREAMBLE




// SECTION HEADER
#show: notes.with(
  title: [Nonlinear Shooting Method],
)


// SECTION SUBHEADER1
#section-subheading("1", "Gist of the Method")
//#h(2em) // fix indent for 1st paragraph

Note: The ultimate goal of the shooting method is to approximate the unknown "initial" slope $s$, i.e. the slope at $a$. This is implicitly a solution to the given BVP because if we plug it into $s$ in IVP 1 below and then solve/approximate it, the resulting solution $y$ will also solve the original BVP (because of how we will set things up).\ \
Given the BVP $ y'' = f(x, y, y') " with " y(a) = alpha "and" y(b) = beta, $

we create two related IVPs:
1. $y'' = f(x, y, y');  y(a) = alpha "and" y'(a) = s$ where $s$ is a fresh variable representing the *initial slope* and

2. $ z'' = (partial f(x, y, y'))/(partial s); z(a) = 0 "and" z'(a) = 1. $<2ndivp>

Finally, these IVPs are approximated at the right boundary point $b$ and previous slope $s_(k - 1)$ and used to approximate $s$ with *Newton's Method*:
$ s_k = s_(k - 1) - (y(b, s_(k - 1)) - beta)/(z(b, s_(k - 1))). $<nlsm-newton>

Note: The shooting method is thus comprised of a nested "loop" of approximations: the outer loop is the Newtons Method that approximates $s$, and the inner loop uses an IVP approximation method like RK4 or something to approximate $y$ and $z$.

#h(2em)



// SECTION SUBHEADER2
#section-subheading("2", "Derivation/Explanation")
Suppose we're looking at the BVP $ y'' = f(x, y, y'); y(a) = alpha "and" y(b) = beta. $



The ultimate goal of the shooting method is to reduce the problem of solving said BVP into a root-finding problem. This root-finding problem can be interpreted as approximating the initial slope $y'(a)$. 

We start by realizing that for any arbitrary guess for the slope $s$, we can get an IVP by setting $y'(a) = s$ and throwing away the data that $y(b) = beta$. Explicitly, we can look at the IVP $ y'' = f(x, y, y'); y(a) = alpha "and" y'(a) = s.  $

Solving said IVP then yields a function $y_s$ which *depends on $s$*. Note that for any $s$, $y_s$ already satisfies two of the three conditions of the BVP. We now just need to find an $s$ such that $y_s (b) = beta$ as well, i.e. a "root" of the equation $y_s (b) - beta = 0.$ 

Thus,  the nonlinear shooting method reduces the boundary-value problem to finding a root of the equation

$
  F(s) = y(b, s) - beta = 0. 
$

For any chosen initial slope $s$, the corresponding IVP satisfies

$
  y'' = f(x,y,y'), quad y(a) = alpha, quad y'(a) = s.
$

Hence, our objective is to determine a suitable $s^*$ such that

$
  y(b, s^*) = beta.
$




#linebreak()





// SECTION SUBHEADER3
#section-subheading("3", "Using Newton's Method")
#h(2em) // fix indent for 1st paragraph


Taking the result $y (b, s) - beta = 0$, we obtain the following Newton iteration scheme:

$
  s_k = s_(k-1) - (y(b, s_(k-1)) - beta)/((d y)/(d s)(b, s_(k - 1)))
$

This is what is in Burden and Faires. Using Newton's Method is complicated because we need to know the partial derivative of the solution $y$ w.r.t $s$.

// To include: the result in variational calculus that sir mentioned that partial and direct derivatives commute or whatever. This is so that we can set $z = (partial y)/(partial s)$ and also have $z'' =  (partial y'')/(partial s)$ which is the second IVP.
\
Let's go back to the IVP given in equation (4). Recall that $y$ is a function on both $x$ and $s$. 

$
  y''(x, s) = f(x, y(x, s), y'(x, s)), y(a) = alpha$ and $y(b) = beta
$

Consider its partial derivative below:

$
  (partial y'') / (partial s) = 

  (partial f) / (partial x)(x, y(x, s), y'(x, s))
  (partial x) / (partial s)

  +
  
  (partial f) / (partial y)(x, y(x, s), y'(x, s))
  (partial y) / (partial s)(x, s) 

  + 
  \

  (partial f) / (partial y')(x, y(x, s), y'(x, s))
  (partial y') / (partial s)(x, s)
  
$

Since $(partial x) / (partial s) = 0$,

$
  (partial y'') / (partial s) = 
  
  (partial f) / (partial y)(x, y(x, s), y'(x, s))
  (partial y) / (partial s)(x, s) 

  + 
  
  (partial f) / (partial y')(x, y(x, s), y'(x, s))
  (partial y') / (partial s)(x, s)
  
$

with $(partial y) / (partial s)(a, s) = 0$ and $(partial y') / (partial s)(a, s) = 1$.


Now, suppose that we let $z = (partial y)/ (partial s)$. We get the following:

$
  z' = ((partial y) /(partial s))'
  " and "
  z'' = ((partial y) /(partial s))''
$

// probably some thm here

From the commutativity of partial and ordinary derivatives, it follows that:

$
  z' = (partial y') /(partial s)
  " and "
  z'' = (partial y'') /(partial s)
$

Which gives us

$
  z''(x, s) = 
  
  (partial f) / (partial y)(x, y, y')
  z(x, s) 

  + 
  
  (partial f) / (partial y')(x, y, y')
  z'(x, s)
$

with $z(a, s) = 0$ and $z'(a, s) = 1$. 

Plugging that into our Newton iteration scheme, we get the following

$ s_k = s_(k - 1) - (y(b, s_(k - 1)) - beta)/(z(b, s_(k - 1))). $

Which is the same iteration scheme as discussed in the previous section! 

\
#section-subheading("4", "Setup Example Using Newton's Method")
\
This is similar to one of the seatworks we had during class.

#example(number: "")[
// page 684 chapter 11 exercise set 11.2 item 1

Consider the BVP $y'' = -(y')^2 - y + ln x$, with $y(1) = 0$ and $y(2) = ln 2$.  \
The actual solution is $y = ln x$. 

Set up using newton's method to approximate a good slope for the BVP.

This BVP is taken from Burden and Faires, Chapter 11 exercise set 11.2 item 1 page 684.
]


1. *Get the 1st IVP.* 

  We let $y'(1) = s$, so we can have the IVP  
  $y'' = f(x, y, y') = -(y')^2 - y + ln x$ with initial conditions
  $y(1) = 0$  and  $y'(1) = s$

  We can turn this into FODE: $y' = mat(y'_1; y'_2) = mat(y_2; -y_2^2 - y_1 + ln x)$ where $y_1 = y$ and $y_2 = y'$ with initial values $y_1(1) = 0$ and $y_2(1) = s$.

2. *Get the 2nd IVP.* 

  Let $z = (partial y)/(partial t)$. From @2ndivp,   $z''= (partial f(x, y, y'))/(partial s) 
  = (partial f)/(partial y) (partial y)/(partial t) + (partial f)/(partial y') (partial y')/(partial t) 
  = (partial f) / (partial y) z  + (partial f) / (partial y') z' = (-1)z +(-2y')z' = -z - 2y'z'$. So, our 2nd IVP is

  $ z'' = -z - 2y'z' " with " z(1) = 0 " and " z'(1) = 1 $

  We can turn this into FODE: $z' = mat(z'_1; z'_2) = mat(z_2; -z_1 - 2y_2 z_2)$ where $z_1 = z$ and $z_2 = z'$ with initial values $z_1(1) = 0$ and $z_2(1) = 1$.

  
3. *Vector form*

    We can write this in vector form: $w = mat(y_1; y_2; z_1; z_2)$ with initial values $w_0 = mat(0; s; 0; 1)$.
  We can now use RK4 on $w' = partial / (partial s) mat(y_1; y_2; z_1; z_2) = mat(y_2; -y_2^2 - y_1 + ln x; z_2; -z_1 - 2y_2 z_2)$ to solve for $y_1$ & $z_1$ needed in Newton's method.

4. *Newton's scheme*

  Plugging in the given boundary values into @nlsm-newton,
  $ s_k = s_(k - 1) - (y_1(2, s_(k - 1)) - ln 2)/(z_1(2, s_(k - 1))). $

5. *Stopping Condition*

  We can choose $italic("tol" = 10^(-5))$ to have a stopping condition $abs(s_(n+1) - s(n)) < italic("tol" = 10^(-5))$.
  // also dont get the point of this

With this, what remains is the gnarly calculations.



  

// #section-emphasis[Max-Flow]
// Blah blah blah, here's a section to show emphasis. #lorem(40)

// #section-emphasis[Min-Cut]
// #lorem(40)


// // taken from LE1-miniarc3
// #example(number: "1")[
//   For the system from the lecture,
//   $ mat(
//       5, -2, 3;
//       -3, 9, 1;
//       2, -1, -7
//     )
//     mat(x_1; x_2; x_3)
//     =
//     mat(-1; 2; 3), $

//   the matrix splitting is
//   $ D = mat(
//       5, 0, 0;
//       0, 9, 0;
//       0, 0, -7
//     ), $

//   $ L = mat(
//       0, 0, 0;
//       -3, 0, 0;
//       2, -1, 0
//     ),
//     quad
//     U = mat(
//       0, -2, 3;
//       0, 0, 1;
//       0, 0, 0
//     ). $

//   Adding these three matrices reconstructs $A$.
//   Since every diagonal entry is nonzero, $D$ is
//   invertible, and, by algebra, we have:
//   $ D^(-1) = mat(
//       1/5, 0, 0;
//       0, 1/9, 0;
//       0, 0, -1/7
//     ). $
// ]



// #lorem(50)

// \ 

// // SECTION SUBHEADER4
// #section-subheading("4", "Computational Example?")
// #h(2em) // fix indent for 1st paragraph
// #lorem(100)

// #lorem(10)

// \

// // SECTION SUBHEADER5
// // #section-subheading("4", "Unit Testing")
// // #h(2em) // fix indent for 1st paragraph
// // #lorem(100)

// // #lorem(10)

