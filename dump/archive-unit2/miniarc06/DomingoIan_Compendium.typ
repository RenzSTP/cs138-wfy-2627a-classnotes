#import "../assets.typ": qa, note, solution-box

#set par(justify: true)
#set math.equation()
#set table(stroke: 0.5pt + rgb("#999999"), inset: 4pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")

// Problems: 
= Boundary Value Problems

== Compendium Problem 1
#qa(auth: "DOMINGO, ADRIAN CHRISTIAN E.")[
  *Source:* Exercise 24a from 13.1.6 of William Trench. Elementary Differential Equations with BVPs \

  Find the Green's function for the boundary value problem \
  $ x^2 y'' - 2 x y' + 2 y = F(x), y(1) = 0, y(2) = 0 $ 

  given that ${x, x^2}$ is a fundamental set of solutions of the complimentary equation. Then use the Green's function to solve (A) with  $F(x) = 2 x^3$
][
  Given that we did not discuss Green's function in class, we will solve this equation using CS138 concepts.

  Recall that a Cauchy-Euler equation follows the format:
  $ a x^2 y'' + b x y' + c y = 0 $ \

  We can use this to solve the BVP!

  Substituting $x = e^t$ then using chain substitution, we get: 

  $ (d^2 y)/(d t^2) - 2 (d y)/(d t) + 2y = 2 (e^t)^3 $
  $ y'' - 3y' + 2y = 2 e^(3t) $

  We solve for the homogeneous equation.

  $ y'' - 3y' + 2y = 0$
  $ r^2 - 3r + 2 = 0 $
  $ (r-1)(r-2) = 0 $
  $ therefore y_h (t) = c_1 e^t + c_2 e^(2t) $

  We then solve for the particular equation.

  $ y_p (t) = c_1 e^(3t) $
  $ y_p ' (t) = 3 c_1 e^(3t) $
  $ y_p '' (t) = 9 c_1 e^(3t) $
  $ 9 A e^(3t) - 3(3 c_1 e^(3t)) + 2( c_1 e^(3t)) = 2 e^(3t) $
  $ 9 c_1 e^(3t) - 9 c_1 e^(3t) + 2( c_1 e^(3t)) = 2 e^(3t) $
  $ 2 c_1 e^(3t) = 2 e^(3t) $
  $ c_1 = 1 $
  $ therefore y_p (t) =  e^(3t) $

  We now have the following equation:
  $ y(t) = y_h (t) + y_p (t) $
  $ y(t) = c_1 e^t + c_2 e^(2t) + e^(3t) $

  We substitute $t=ln x$:
  $ y(x) = c_1 e^(ln x) + c_2 e^(2 ln x) +  e^(3 ln x) $
  $ y(x) = c_1 x + c_2 x^2  + x^3 $

  *For $y(1) = 0$*:
  $ y(1) = c_1 (1) + c_2 (1^2) + (1^3) = 0 $
  $ => c_1 = -c_2 -1 $

  *For $y(2) = 0$*:
  $ y(2) = (-c_2 -1)(2) + c_2 (2^2) + (2^3) = 0 $
  $ (-2c_2 - 2) + 4c_2 + 8 = 0 $
  $ 2c_2 = -6 $
  $ c_2 = -3 $
  $ c_1 = -c_2 - 1 = -(-3) - 1 = 2 $

  Therefore, we have the final equation:
  #solution-box[$y(x)=2x-3x^2+x^3$]
]
== Compendium Problem 2 
#qa(auth: "DOMINGO, ADRIAN CHRISTIAN E.")[
  *Source:* Exercise 50 from 5.7.1 of Russel Herman. Math 420: Differential Equations

  Prove that if $y=y(x)$ satisfies the Cauchy-Euler equation
  $ a x^2 (d^2 y)/(d t^2) + b x (d y)/(d x) + c y = 0 $
  on $(0, infinity)$ then $y = y(t)$, where $t = -x$, satisfies A on $(- infinity, 0)$.

][
  Let $t = -x$. If $x in (- infinity, 0)$, then $t in (0, infinity)$

  We differentiate $y$ with respect to $x$ using the chain rule.
  $ (d y)/(d x) = (d y)/(d t) times (d t)/(d x) $
  wherein $(d t)/(d x) = -1$, then
  $ (d y)/(d x) = -(d y)/(d t) $

  We differentiate $y$ with respect to $x$ again to get:
  $ (d^2 y)/(d x^2) = d/(d x) ((d y)/(d x)) $
  $ (d^2 y)/(d x^2) = d/(d t) (-(d y)/(d t)) times (d t)/(d x) $
  $ (d^2 y)/(d x^2) = (- (d^2 y)/(d t^2)) times (-1) $
  $ (d^2 y)/(d x^2) = (d^2 y)/(d t^2) $

  We now have:
  $ a (-t)^2 (d^2 y)/(d x^2) + b (-t) (-(d y)/(d t)) + c y = 0 $
  $ a t^2 y'' + b t y' + c y = 0 $

  which is exactly in the same form as the Cauchy-Euler equation, but instead of $x$, it's $t$. The equation $y(t)$ satisfies the transformed equation since $t in (0, infinity)$ and $y$ satisfies the equation on $(0, infinity)$.

  $therefore y(-x)$ satisfies the original equation on $(-infinity, 0) qed$ 
]

== Remixed Problem
#qa(auth: "DOMINGO, ADRIAN CHRISTIAN E.")[
  Solve the boundary value problem
  $ x^2 y'' - 2 x y' + 2 y = F(x), y(-1) = 0, y(-2) = 0 $
  with $F(x) = 2x^3$
][
  We cannot substitute $t = ln x$ since $t = ln (-1)$ and $t = ln (-2)$ are undefined. We must do a different approach.
  
  Substitute $x = -t$:
  $ x = -t $
  $ (d y)/(d x) = -(d y)/(d t) $
  $ (d^2 y)/(d x^2) = (d^2 y)/(d t^2) $

  We then substitute to the BVP:
  $ (-t)^2 (d^2 y)/(d x^2) - 2 (-t) (-(d y)/(d t)) + 2y = 2(-t)^3$
  $ t^2 y'' - 2t y' + 2y = -2t^3 $

  This in turn transforms the boundary conditions.\
  For $y(x)$, it's $y(-1) = 0, y(-2) = 0$. \
  However, for $y(t)$, it's $y(1)=0, y(2)=0$ respectively.

  We now solve this using Cauchy-Euler substitution.\
  Let $t = e^s$. Using Cauchy-Euler substitution, we should get
  $ y'' + (-2 -1)y' + 2y = -2(e^s)^3 $
  $ y'' - 3y' + 2y = -2e^(3s) $

  We solve for the homogeneous equation.
  $ y(s)_h = y'' - 3y' + 2y = 0 $
  $ => r^2 - 3r + 2 = 0 $
  $ => (r-1)(r-2) = 0 $
  $ r = 1,2 $

  $therefore y(s)_h = c_1 e^s + c_2 e^(2s)$

  $ y_p (s) = c_1 e^(3s) $
  $ y_p ' (s) = 3 c_1 e^(3s) $
  $ y_p '' (s) = 9 c_1 e^(3s) $
  $ 9 A e^(3s) - 3(3 c_1 e^(3s)) + 2( c_1 e^(3s)) = -2 e^(3s) $
  $ 9 c_1 e^(3s) - 9 c_1 e^(3s) + 2( c_1 e^(3s)) = -2 e^(3s) $
  $ 2 c_1 e^(3s) = -2 e^(3s) $
  $ c_1 = -1 $
  $ therefore y_p (s) =  -e^(3s) $

  We now have the following equation:
  $ y(s) = y_h (s) + y_p (s) $
  $ y(s) = c_1 e^s + c_2 e^(2s) - e^(3s) $

  We substitute $s=ln t$:
  $ y(t) = c_1 e^(ln t) + c_2 e^(2 ln t) - e^(3 ln t) $
  $ y(t) = c_1 t + c_2 t^2  - t^3 $

  *For $y(1) = 0$*:
  $ y(1) = c_1 (1) + c_2 (1^2) - (1^3) = 0 $
  $ => c_1 = -c_2 + 1 $

  *For $y(2) = 0$*:
  $ y(2) = (-c_2 + 1)(2) + c_2 (2^2) - (2^3) = 0 $
  $ (-2c_2 + 2) + 4c_2 - 8 = 0 $
  $ 2c_2 = 6 $
  $ c_2 = 3 $
  $ c_1 = -c_2 + 1 = -3 + 1 = -2 $

  $ therefore y(t) = -2t + 3t^2 - t^3 $

  Recall that $t = -x$, then
  $ y(x) = -2(-x) + 3(-x)^2 - (-x)^3 $
  $ y(x) = 2x + 3(-1)^2 x^2 - (-1)^3 x^3 $
  
  Therefore, we have the final equation:
  #solution-box[$y(x)=2x-3x^2+x^3$] \
]

== Links to Exercises
\
[1] Herman, R. (2022, November 27). _5.7.1: Cauchy-Euler equations (Exercises)_. LibreTexts. https://math.libretexts.org/Courses/Cosumnes_River_College/Math_420%3A_Differential_Equations_(Breitenbach)/05%3A_Linear_Second_Order_Equations/5.07%3A_Cauchy-Euler_Equations/5.7.01%3A_Cauchy-Euler_Equations_(Exercises)

[2] Trench, W. (2024, June 23). _13.1E: Boundary value problems (Exercises)_. LibreTexts. https://math.libretexts.org/Courses/Cosumnes_River_College/Math_420%3A_Differential_Equations_(Breitenbach)/05%3A_Linear_Second_Order_Equations/5.07%3A_Cauchy-Euler_Equations/5.7.01%3A_Cauchy-Euler_Equations_(Exercises)