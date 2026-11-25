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

#show: notes.with(
  title: [Generalized Eigenvalue Problems]
)

// Justify and indent to preference (re-applied after show rule per assets note)
#set par(
  justify: true,
  first-line-indent: (amount: 2.0em, all: true)
)
#section-subheading("1", "Definition and General Form")

The eigenvalue problem $y'' + lambda y = 0$ is a special case of a more general second-order differential equation:

#definition(name: "Generalized Eigenvalue Problem")[
  \
  Find the eigenvalues $lambda$ and corresponding non-zero eigenfunctions $y(x)$ satisfying:

  $ P_0(x)y'' + P(x)y' + Q(x)y + lambda R(x)y = 0, quad x in [a,b] $

  where $P_0(x)$, $P(x)$, $Q(x)$, and $R(x)$ are known coefficient functions.
]

Compared with the simpler eigenvalue problem, the generalized form allows the coefficients to vary with $x$, and the eigenvalue parameter to be multiplied by a coefficient function $R(x)$. The prescribed boundary conditions then determine which values of $lambda$ allow non-zero solutions.

\

#section-subheading("2", "Boundary Conditions")

In addition to satisfying the differential equation, the solution must satisfy two boundary conditions, one at each endpoint of the interval.

The general boundary conditions are:

$ B_1(y) = alpha_1 y(a) + beta_1 y'(a) = 0 $

$ B_2(y) = alpha_2 y(b) + beta_2 y'(b) = 0 $

Here, $alpha_1$, $beta_1$, $alpha_2$, and $beta_2$ are constants that determine the required conditions on the function and its derivative at the endpoints.


The main idea is that not every value of $lambda$ will produce a non-zero solution satisfying both boundary conditions. Only the permitted values are eigenvalues of the problem.

#pagebreak()


#section-subheading("3", "Worked example")

Consider the generalized eigenvalue problem:

$ x^2 y'' + x y' + lambda y = 0 $

subject to the boundary conditions:

$ y'(1) = 0, quad y(e) = 0 $



#example(number: "1")[
  \
  *Step 1: Apply Cauchy-Euler substitution.*

  Let

  $ t = ln x $

  Define $Y(t)=y(e^t)$. Using the Cauchy-Euler substitution, the derivatives become:

  $ y'(x) = Y'(t)/x $

  $ y''(x) = (Y''(t)-Y'(t))/x^2 $

  Substituting into the original differential equation:

  $ x^2 y'' + x y' + lambda y = 0 \
    Y''(t)-Y'(t)+Y'(t)+lambda Y(t)=0 \
    Y''(t)+lambda Y(t)=0 $

  The original interval $1 <= x <= e$ becomes:

  $ 0 <= t <= 1 $

  We also transform the boundary conditions:

  $ y'(1)=0 arrow Y'(0)=0 $

  $ y(e)=0 arrow Y(1)=0 $

  Therefore, the transformed problem is:

  $ Y''(t)+lambda Y(t)=0 $

  subject to:

  $ Y'(0)=0, quad Y(1)=0 $

  *Step 2: Solve the resulting differential equation.*

  We consider three possible cases for $lambda$.

  *Case 1: $lambda=0$*

  The equation becomes:

  $ Y''(t)=0 $

  Its general solution is:

  $ Y(t)=C_1+C_2t $

  Applying the first boundary condition:

  $ Y'(0)=0 arrow C_2=0 $

  Applying the second boundary condition:

  $ Y(1)=0 arrow C_1=0 $

  Only the trivial solution exists, so $lambda=0$ is not an eigenvalue.

  *Case 2: $lambda<0$*

  Let $mu=sqrt(-lambda)$, where $mu>0$. The equation becomes:

  $ Y''(t)-mu^2Y(t)=0 $

  Its general solution is:

  $ Y(t)=C_1 cosh(mu t)+C_2 sinh(mu t) $

  Applying the first boundary condition:

  $ Y'(0)=0 arrow C_2 mu=0 $

  Since $mu>0$, we obtain $C_2=0$.

  Applying the second boundary condition:

  $ Y(1)=0 arrow C_1 cosh(mu)=0 $

  Since $cosh(mu)$ is always positive, $C_1=0$.

  Only the trivial solution exists, so $lambda<0$ does not produce an eigenvalue.

  *Case 3: $lambda>0$*

  The general solution is:

  $ Y(t)=C_1 cos(sqrt(lambda)t)+C_2 sin(sqrt(lambda)t) $

  Applying the first boundary condition:

  $ Y'(0)=0 arrow C_2 sqrt(lambda)=0 $

  Since $lambda>0$, we obtain $C_2=0$.

  Therefore:

  $ Y(t)=C_1 cos(sqrt(lambda)t) $

  *Step 3: Apply the second boundary condition.*

  Using $Y(1)=0$:

  $ C_1 cos(sqrt(lambda))=0 $

  For a non-trivial solution, $C_1 != 0$. Therefore:

  $ cos(sqrt(lambda))=0 $

  Since $cos$ is zero at odd multiples of $pi/2$:

  $ sqrt(lambda)=(n+1/2)pi $

  where $n=0,1,2,...$.

  Squaring both sides gives the eigenvalues:

  $ lambda_n = ((n+1/2)pi)^2, quad n=0,1,2,... $

  *Step 4: Determine the eigenfunctions.*

  Substituting the eigenvalues into the solution:

  $ Y_n (t)=C_1 cos((n+1/2)pi t) $

  Since $t=ln(x)$, convert the solution back to the original variable:

  $ y_n (x)=C_1 cos((n+1/2)pi ln(x)) $

  The arbitrary non-zero constant $C_1$ can be omitted when expressing the eigenfunctions.

  *Final Answer:*

  The eigenvalues are:

  $ lambda_n = ((n+1/2)pi)^2, quad n=0,1,2,... $

  The corresponding eigenfunctions are:

  $ y_n (x)=cos((n+1/2)pi ln(x)), quad n=0,1,2,... $
]


#pagebreak()

#section-subheading("4", "General Solution Procedure")

The specific method used to solve a generalized eigenvalue problem depends on the form of its differential equation. However, the general approach remains the same: find the values of $lambda$ for which a non-trivial solution satisfies both the differential equation and its boundary conditions.

#algorithm(name: "General Solution Procedure")[
  \
  1. Identify the differential equation, its interval, and the prescribed boundary conditions.
  2. Solve the differential equation in terms of $lambda$, keeping the arbitrary constants in the general solution.
  3. Apply the first boundary condition to obtain a relationship between the arbitrary constants.
  4. Apply the remaining boundary condition(s). Require a non-trivial solution, which produces a condition involving $lambda$.
  5. Solve this condition to determine the allowable values of $lambda$, which are the eigenvalues.
  6. Substitute each eigenvalue into the general solution and apply the boundary conditions to determine its corresponding eigenfunction.
]

#note(name: "Choosing a solution method")[
  The technique used to solve the differential equation depends on its form. For example, constant-coefficient equations can be solved using characteristic equations, while Cauchy-Euler equations can be simplified using the substitution $t=ln x$.
]