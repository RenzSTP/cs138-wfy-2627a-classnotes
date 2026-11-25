#set math.mat(delim: "[")


#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

#let problem(number: none, source: none, body) = block(
  fill: white,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: (left: 3pt + ink),
)[
  #text(fill: ink, weight: "bold")[Compendium Problem #if number != none [#number]]
  #if source != none [ #text(size: 9pt, fill: midgray)[(Source: #source)]]
  #linebreak()
  #body
]

#let solution-box(body) = align(center)[
  #box(
    stroke: 1pt,
    inset: 5pt,
  )[
    #body
  ]
]

#problem(number: "1", source: "Chapra & Canale, Numerical Methods for Engineers, Problems, #11.13a")[
  *Statement:* Use the Gauss-Seidel method without relaxation to solve the following system to a tolerance of $epsilon_S = 5%$. If necessary, rearrange the equations to achieve convergence.

  $ 2x_1 - 6x_2 - x_3 = -38 \
    -3x_1 - x_2 + 7x_3 = -34 \
    -8x_1 + x_2 - 2x_3 = -20 $


  *Solution:*
  Checking if the diagonal is dominant:
  
  Row 1: $|2| < |-6|+|-1|$
  
  Row 2: $|-1| < |-3|+|7|$
  
  Row 2: $|-2| < |-8|+|1|$
  
  Thus the original order the diagonal is not dominant. There is a chance that convergence is not guaranteed. We can reorder the equations as (3), (1), (2) to place the largest coefficient of each row on the diagonal, which is

  $ -8 x_1 + x_2 - 2 x_3 = -20 $
  $ 2 x_1 - 6 x_2 - x_3 = -38 $
  $ -3 x_1 - x_2 + 7 x_3 = -34 $
  
  Next to solving each equation for its diagonal unknown,
  
  $ x_1 = (20 + x_2 - 2 x_3) / 8 $
  $ x_2 = (38 + 2 x_1 - x_3) / 6 $
  $ x_3 = (-34 + 3 x_1 + x_2) / 7 $
    
  Using Gauss-Seidel, let the first iteration $x^((1))$ start with $x_1 = x_2 = x_3 = 0$ as the initial guess.
  
  *Iteration 1:*
  
  $ x_1 = (20 + 0 - 0) / 8 = 2.50000 $
  $ x_2 = (38 + 2(2.50000) - 0) / 6 = 7.16667 $
  $ x_3 = (-34 + 3(2.50000) + 7.16667) / 7 = -2.76190 $
  
  *Iteration 2:*
  
  $ x_1 = (20 + 7.16667 - 2(-2.76190)) / 8 = 4.08631 $
  $ x_2 = (38 + 2(4.08631) - (-2.76190)) / 6 = 8.15575 $
  $ x_3 = (-34 + 3(4.08631) + 8.15575) / 7 = -1.94076 $
  
  We can approximate the relative errors now by using $|(x^((1))_i - x^((0))_i)/x^((1))_i|$
  
  $ epsilon_(a,1) = abs((4.08631 - 2.50000) / 4.08631) times 100% = 38.8% $
  $ epsilon_(a,2) = abs((8.15575 - 7.16667) / 8.15575) times 100% = 12.1% $
  $ epsilon_(a,3) = abs((-1.94076 - (-2.76190)) / (-1.94076)) times 100% = 42.3% $
  
  It is obvious that the largest error exceeds 5%. We must repeat the iteration by now substituting the values from $x^((1))$.
  
  *Iteration 3:*
  
  $ x_1 = (20 + 8.15575 - 2(-1.94076)) / 8 = 4.00466 $
  $ x_2 = (38 + 2(4.00466) - (-1.94076)) / 6 = 7.99168 $
  $ x_3 = (-34 + 3(4.00466) + 7.99168) / 7 = -1.99919 $
  
  Approximate relative errors once again,
  
  $ epsilon_(a,1) = abs((4.00466 - 4.08631) / 4.00466) times 100% = 2.04% $
  $ epsilon_(a,2) = abs((7.99168 - 8.15575) / 7.99168) times 100% = 2.05% $
  $ epsilon_(a,3) = abs((-1.99919 - (-1.94076)) / (-1.99919)) times 100% = 2.92% $
  
  All three errors are below 5%, so the iteration stops, with values
  
  $ x_1 approx 4.00, quad x_2 approx 7.99, quad x_3 approx -2.00 $

  Therefore,
  
  #solution-box([$x_1 = 4$, $x_2 = 8$, $x_3 = -2$])
]

#pagebreak()

#problem(number: "2", source: "Burden & Faires, Numerical Analysis, Exercise 7.3, Item 9d")[
  *Statement:* The linear system 

  $ 2x_1 - x_2 + x_3 = -1 \
    2x_1 + 2x_2 + 2x_3 = 4 \
    -x_1 - x_2 + 2x_3 = -5 $

  has the solution $(1, 2, −1)^t$.

  Use the Gauss-Seidel method with $x^((0)) = 0$ to approximate the solution to the linear system to within $10^(−5)$ in the $l_infinity$ norm.
  
  *Solution:*
  We solve the system given the solution and the initial guess by first taking the iteration formula for each unknown value.
  
  $ 2x_1 - x_2 + x_3 = -1 arrow.double x_1^((k)) &= (-1 + x_2^((k-1)) - x_3^((k-1))) / 2 \ 
  2x_1 + 2x_2 + 2x_3 = 4 arrow.double x_2^((k)) &= 2 - x_1^((k)) - x_3^((k-1)) \
  -x_1 - x_2 + 2x_3 = -5 arrow.double x_3^((k)) &= (-5 + x_1^((k)) + x_2^((k))) / 2 $

  It is also stated that the solution should be stopped for $norm(bold(x)^((k)) - bold(x)^((k-1)))_infinity < 10^(-5)$.

  By tabulating all iterations in the table below, starting from Iteration 1 with input $x^((0)) = 0$, we reach the solution.

  #figure(
    table(
      columns: 5,
      align: center + horizon,
      table.header[*$k$*][*$x_1^((k))$*][*$x_2^((k))$*][*$x_3^((k))$*][*$norm(x^((k))-x^((k-1)))_infinity$*],
      [0], [$0.0000000$], [$0.0000000$], [$0.0000000$], [—],
      [1], [$-0.5000000$], [$2.5000000$], [$-1.5000000$], [$2.50 times 10^(0)$],
      [2], [$1.5000000$], [$2.0000000$], [$-0.7500000$], [$2.00 times 10^(0)$],
      [3], [$0.8750000$], [$1.8750000$], [$-1.1250000$], [$6.25 times 10^(-1)$],
      [4], [$1.0000000$], [$2.1250000$], [$-0.9375000$], [$2.50 times 10^(-1)$],
      [5], [$1.0312500$], [$1.9062500$], [$-1.0312500$], [$2.19 times 10^(-1)$],
      [6], [$0.9687500$], [$2.0625000$], [$-0.9843750$], [$1.56 times 10^(-1)$],
      [7], [$1.0234375$], [$1.9609375$], [$-1.0078125$], [$1.02 times 10^(-1)$],
      [8], [$0.9843750$], [$2.0234375$], [$-0.9960938$], [$6.25 times 10^(-2)$],
      [9], [$1.0097656$], [$1.9863281$], [$-1.0019531$], [$3.71 times 10^(-2)$],
      [10], [$0.9941406$], [$2.0078125$], [$-0.9990234$], [$2.15 times 10^(-2)$],
      [11], [$1.0034180$], [$1.99560545$], [$-1.0004883$], [$1.22 times 10^(-2)$],
      [12], [$0.9980469$], [$2.0024414$], [$-0.9997559$], [$6.84 times 10^(-3)$],
      [13], [$1.0010986$], [$1.9986572$], [$-1.0001221$], [$3.78 times 10^(-3)$],
      [14], [$0.9993896$], [$2.0007324$], [$-0.9999390$], [$2.08 times 10^(-3)$],
      [15], [$1.0003357$], [$1.9996033$], [$-1.0000305$], [$1.13 times 10^(-3)$],
      [16], [$0.9998169$], [$2.0002136$], [$-0.9999847$], [$6.10 times 10^(-4)$],
      [17], [$1.0000992$], [$1.9998856$], [$-1.0000076$], [$3.28 times 10^(-4)$],
      [18], [$0.9999466$], [$2.0000610$], [$-0.9999962$], [$1.75 times 10^(-4)$],
      [19], [$1.0000286$], [$1.9999676$], [$-1.0000019$], [$9.35 times 10^(-5)$],
      [20], [$0.9999847$], [$2.0000172$], [$-0.9999990$], [$4.96 times 10^(-5)$],
      [21], [$1.0000081$], [$1.9999909$], [$-1.0000005$], [$2.62 times 10^(-5)$],
      [22], [$0.9999957$], [$2.0000048$], [$-0.9999998$], [$1.38 times 10^(-5)$],
      [23], [$1.0000023$], [$1.9999975$], [$-1.0000001$], [$7.27 times 10^(-6)$],
      ),
    )

  It took 23 iterations to finally reach $norm(x^((k))-x^((k-1)))_infinity < 10^(-5).$ That is $norm(x^((23))-x^((22)))_infinity = 7.27 times 10^(-6) < 10^(-5).$
  Thus, the approximate solutions for this problem are
  
  #solution-box([$x^((23)) = (1.0000023, 1.9999975, −1.0000001)^t$])
]

#pagebreak()

#problem(number: "Remix", source: "Compendium Problem 2")[
  *Statement:* Let the linear systems be the same as the given in Compendium Problem 2 with the matrix representations being $ A = mat(2, -1, 1; 2, 2, 2; -1, -1, 2), b = mat(-1; 4; -5), x^* = mat(1; 2; -1) $

  Suppose you run exactly one iteration of the Gauss-Seidel method with $x^((0)) = (0, 0, 0)^t$ to obtain $x^((1))$. 

  Realizing that Gauss-Seidel might take too many iterations to hit the $10^(-5)$ tolerance, you decide to switch strategies. You compute the residual vector $r^((1)) = b - A x^((1))$, solve the correction system $A y = r^((1))$, and update your guess as $x^* = x^((1)) + y$.

  *(a)* Analytically prove that $x^*$ is the exact solution to $A x = b$ for any non-singular matrix.
  
  *(b)* Calculate the residual $r^((1))$, and the correction vector $y$ for the given system.

  *Solution:*

  *Part (a)*
  
  We are given $r^((1)) = b - A x^((1))$ and $A y = r^((1))$. 
  Substitute the first equation into the second in order to have the equation
  $ A y = b - A x^((1)) $
  Try rearranging by factoring out $A$ to get
  $ A y + A x^((1)) = b => A(y + x^((1)) = b $
  Since $x^* = x^((1)) + y$, we get $ A x^* = b $
  Therefore, $x^*$ is the exact solution. $qed$

  *Part (b)*
  
  From the iterations table of Compendium 2, we know that $x^((1))_1 = -0.5, x^((1))_2 = 2.5, x^((1))_3 = -1.5$. Thus, $x^((1)) = (-0.5, 2.5, -1.5)^t$.

  By using the values that are given, we can first find $A x^((1))$.
  $ A x^((1)) = mat(2, -1, 1; 2, 2, 2; -1, -1, 2) mat(-0.5; 2.5; -1.5) = mat(-1 - 2.5 - 1.5; -1 + 5 - 3; 0.5 - 2.5 - 3) $ 
  $ A x^((1)) = mat(-5; 1; -5) $

  Now all values can be substituted to find the residual vector
  $ r^((1)) = b - A x^((1)) $ 
  $ r^((1)) = mat(-1; 4; -5) - mat(-5; 1; -5) = mat(4; 3; 0) $

  By using the proof on part (a) which tells that $x_"exact" = x^{(1)} + y$, we know $y$ is just the error vector. But first we must determine if $A$ is non-singular.
  
  To determine singularity, we can calculate the determinant of the matrix using cofactor expansion along the first row.

  $ A = mat(2, -1, 1; 2, 2, 2; -1, -1, 2) $
  
  $ det(A) &= 2 mat(delim: "|", 2, 2; -1, 2) - (-1) mat(delim: "|", 2, 2; -1, 2) + 1 mat(delim: "|", 2, 2; -1, -1) \
           &= 2((2)(2) - (2)(-1)) + 1((2)(2) - (2)(-1)) + 1((2)(-1) - (2)(-1)) \
           &= 2(4 + 2) + 1(4 + 2) + 1(-2 + 2) \
           &= 2(6) + 1(6) + 1(0) \
           &= 12 + 6 + 0 \
           &= 18 $
  
  Because the determinant is 18 and not 0, the matrix is non-singular.

  Now we can use the proof. Using the known exact solution $x_"exact" = mat(1; 2; -1)$,
  $ y = x_"exact" - x^((1)) = mat(1; 2; -1) - mat(-0.5; 2.5; -1.5) = mat(1.5; -0.5; 0.5) $

  Therefore, we have obtained the residual and correction vectors without reiterating the Gauss-Seidel method.

  #solution-box([$ r^((1)) = mat(4; 3; 0),y = mat(1.5; -0.5; 0.5) $])  
]

+ Chapra, S. C., and Canale, R. P. _Numerical Methods for Engineers_. Chapter 11, Exercise 13a
+ Burden, R. L., and Faires, J. D. _Numerical Analysis_. Exercise Set 7.3, #9.