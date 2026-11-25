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
  title: [Nonlinear BVPs: Detour],
)

// SECTION SUBHEADER1

#section-subheading("1", "Overview")
#h(2em) // fix indent for 1st paragraph
Recall that linear BVPs can be treated as a system of linear equations. For nonlinear BVPs however, the system involved doesnt have to be linear anymore. However, both BVP types can be treated as root-finding problems. This mini-arc will revolve around the application of finite difference approximation for solving BVPs.
// #lorem(100) 

// #lorem(10)
\

// SECTION SUBHEADER2
#section-subheading("2", "Jacobian")
#h(2em) // fix indent for 1st paragraph
#definition(name: "Jacobian")[
  Let F: $bb(R)^n -> bb(R)^m$ be a differentiable function. Then, the Jacobian of $F$, denoted as $J_F$, is 
$
J_F (x) = mat((partial f_1) /(partial x_1), ..., (partial f_1) /(partial x_n); dots.v, dots.down, dots.v; (partial f_m) /(partial x_1), ..., (partial f_m) /(partial x_n))
=mat((partial F)/(partial x_1), dots, (partial F)/(partial x_n))
$
where $x$ is a vector.
]


One can imagine the Jacobian as the total derivative of a multivariable function but in matrix form. A row corresponds to the partial derivatives with respect to some element in $x$. A column corresponds to the partial derivatives of all functions with respect to one element. 


\

#section-subheading("3", "Newton Linearization")
#h(2em)
Given the Taylor Expansion $f(x + Delta x) approx f(x) + f'(x) Delta x$, by setting $f(x + Delta x) = 0$,
$
  & -f(x) approx f'(x) Delta x \
  & => Delta x = - (f(x^((k))))/(f'(x^((k)))) \
  & => x^((k + 1)) - x^((k)) = - (f(x^((k))))/(f'(x^((k)))) \
  & => x^((k + 1)) = x^((k)) - (f(x^((k))))/(f'(x^((k)))) \
$
Which is exactly Newton's method. We can then extend this logic to the vector function $F(x) = [f_1(x), dots, f_m(x)]^T$ with input vector $x = (x_1, dots, x_n)$.

For each $f_i$ in $F(x)$,
$
  f_i (x) approx f_i (x_0) + sum^n_(j=1) (partial f_i)/(partial x_j)(x_0) Delta x_j \
$
We can then represent this in a vector-matrix form:
$
  F(x) approx F(x_0) + J(x_0) Delta x
$
Similar to the single-variable expansion, we set $F(x) = 0$:
$
  & => J(x^((k))) Delta x = - F(x^((k))) \
  & => Delta x = - J^(-1)(x^((k))) F(x^((k))) \
  & => x^((k + 1)) - x^((k)) = - J^(-1)(x^((k))) F(x^((k))) \
  & => x^((k + 1)) = x^((k)) - J^(-1)(x^((k))) F(x^((k))) \
$
This now allows us to perform Newton's method for SNLEs!

\

#section-subheading("4", "Newton's Method for Systems of Nonlinear Equations")

#h(2em)
When dealing with a System of Nonlinear Equations (SNLE), we want to find the specific variables where a vector of functions, denoted as *$F$*$(x)$, equals zero. Instead of finding the derivative of a single variable, we use the Jacobian matrix discussed above, which contains all the partial derivatives of our system.


#algorithm(name: "Newton's Method for SNLE")[\
Let *$F$*$(x)$ be a vector of $m$ functions with $n$ variables. To solve for *$F$*$=0$:

  1. *Compute the Jacobian Matrix:*
    - Find $J_F (x)$ by taking the partial derivatives of every function with respect to every variable.
  2. *Define an Initial Guess:*
    - Choose a starting point $x^(\(0\))$. The closer this guess is to the actual root, the faster the method converges.
  3. *Iterate to Refine the Guess:*
    - Solve the linear system $J_F (x^((k))) Delta x^((k)) = -F (x^((k)))$ to find the "correction" or step size $Delta x^((k))$.
    - Add this correction to your current guess to get the next guess, i.e., $x^((k+1)) = x^((k)) + Delta x^((k))$.
    - Repeat until the correction $Delta x$ is smaller than the tolerance limit ($epsilon_"tol"$), or until you hit a maximum number of allowed iterations ($n_"max"$).
]
\
To illustrate, here are some example walkthroughs:

#example(number: "1 (Circle-Hyperbola Intersection)")[
  Consider the problem from the lecture of finding where the circle $x^2 + y^2 = 3$ intersects the hyperbola $x y = 1$. \ First, we convert these into root-finding functions by moving all terms to one side: $f_1 (x,y) = x^2 + y^2 - 3$ and $f_2 (x,y) = x y - 1$. \ \
  *Step 1.* Derive the Jacobian matrix $J(x,y)$ by finding the partial derivatives. \
  - Row 1 (Partials of $f_1$): $partial/(partial x) (x^2 + y^2 - 3) = 2x$ and $partial/(partial y) (x^2 + y^2 - 3) = 2y$.
  - Row 2 (Partials of $f_2$): $partial/(partial x) (x y - 1) = y$ and $partial/(partial y) (x y - 1) = x$.
  This gives us the iterative system:
  $ mat(
      2x, 2y;
      y, x;
    )
    mat(Delta x; Delta y)
    =
    mat(-x^2 - y^2 + 3; -x y + 1) $

  *Step 2.* If we start with an initial guess of $x^((0)) = 0.5$ and $y^((0)) = 1.5$, we simply plug these values into our system.

  *Step 3.* \
  With this initial guess, the Jacobian evaluates to $mat(1.0, 3.0; 1.5, 0.5;)$ and $-$*$F$*$(x)$ evaluates to $mat(0.5; 0.25)$. Solving this linear system gives a correction of $Delta x = 0.125$ and $Delta y = 0.125$. \
  Adding this correction to our initial guess yields our first iteration: $x^((1))=0.625$ and $y^((1))=1.625$. Repeating this process one more time using the new coordinates yields a second iteration of $x^((2))=0.61806$ and $y^((2))=1.61806$, bringing us close to the true intersection point.  
]

#example(number: "2 (Parabola-Circle Intersection)")[
  Let's apply this to a new system: finding the intersection of a parabola $y = 5 - x^2$ and a circle $x^2 + y^2 = 5$.
Our functions are $f_1(x,y) = x^2 + y - 5$ and $f_2(x,y) = x^2 + y^2 - 5$.  \ \ 
  *Step 1.* The Jacobian matrix $J(x,y)$ is: 
    $mat(2x, 1; 2x, 2y)$

  *Step 2.* Let's use an initial guess of $x^{(0)} = 1$ and $y^{(0)} = 2$.

  *Step 3.* \
  We plug these into our system $J(x) Delta x = -$*$F$*$(x)$:
  $ mat(
      2(1), 1;
      2(1), 4(2);
    )
    mat(Delta x; Delta y)
    =
    -mat((1)^2+(2)-5; (1)^2 + (2)^2 - 5) $

    $ mat(
      2, 1;
      2, 4;
    )
    mat(Delta x; Delta y)
    =
    mat(2; 0) $
  Solving this linear system gives $3Delta y = -2$, so $Delta y approx -0.667$. Substituting back gives $2Delta x - 0.667 = 2$, meaning $Delta x approx 1.333$. \
  Our first iteration is simply our initial guess plus the correction:
    - $x^((1)) = 1 + 1.333 = 2.333$
    - $y^((1)) = 2 - 0.667 = 1.333$

  The true intersection in the first quadrant is $(2, 1)$. Thus, in just a single iteration, we see that Newton's Method shifted our initial guess of $(1, 2)$ heavily towards the true roots.
]