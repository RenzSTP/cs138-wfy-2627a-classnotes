#import "../assets.typ": qa, note, solution-box

#set par(justify: true)
#set math.equation()
#set table(stroke: 0.5pt + rgb("#999999"), inset: 4pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")

// Problems: 
= Cauchy-Euler Equations

== Compendium Problem 1
#qa(auth: "HANNA CHARISSE O. TINGIN")[
  *Source:* Exercise 1 from 5.7.1 of Russel Herman. Math 420: Differential Equations \

  Find the general solution of the given equation on $(0, infinity)$.
  $ 12 x^2 y'' - 5 x y' + 6 y = 0 $ 
][
  Assume a solution of the form $y = x^r$. \
  Substituting $y$, $y'$, and $y''$ into the differential equation, we get the auxiliary equation:
  
  $ 12 r(r - 1) - 5 r + 6 &= 0 \
  12 r^2 - 12 r - 5 r + 6 &= 0 \
  12 r^2 - 17 r + 6 &= 0 $
  
  Factoring the quadratic equation gives us:
  $ (4r - 3)(3r - 2) = 0 $
  
  The roots are $r_1 = 3/4$ and $r_2 = 2/3$.
  
  Since the roots are real and distinct, the general solution is:
  #solution-box[$ y(x) = c_1 x^(3/4) + c_2 x^(2/3) $]
]

== Compendium Problem 2 
#qa(auth: "HANNA CHARISSE O. TINGIN")[
  *Source:* Exercise 51 from 5.7.1 of Russel Herman. Math 420: Differential Equations \

  Find the solution of the given initial value problem on $(-infinity, 0)$.
  $ 4 x^2 y'' + y = 0; quad y(-1) = 2, quad y'(-1) = 4 $
][
  Since the interval is $x < 0$, we substitute $t = -x$. \
  The differential equation becomes:
  $ 4 t^2 y'' + y = 0 $ for $t > 0$.
  
  Assume $y = t^r$. \
  The auxiliary equation is:
  $ 4 r(r - 1) + 1 &= 0 \
  4 r^2 - 4 r + 1 &= 0 \
  (2r - 1)^2 &= 0 $
  
  The repeated root is $r = 1/2$. \
  Thus, the general solution for $t > 0$ is:
  $ y(t) = c_1 t^(1/2) + c_2 t^(1/2) ln t $
  
  Substituting $t = -x$ back in, we have:
  $ y(x) = c_1 (-x)^(1/2) + c_2 (-x)^(1/2) ln(-x) $
  
  Applying the initial condition $y(-1) = 2$, we get:
  $ y(-1) = c_1 (1)^(1/2) + c_2 (1)^(1/2) ln(1) = c_1 = 2 $
  
  Computing its derivative:
  $ y'(x) = -1/2 c_1 (-x)^(-1/2) - 1/2 c_2 (-x)^(-1/2) ln(-x) - c_2 (-x)^(1/2) 1/x $
  
  Evaluating at $x = -1$, we obtain:
  $ y'(-1) &= -1/2 (2) (1) - 1/2 c_2 (1) (0) - c_2 (1) (-1) \
  4 &= -1 + c_2 \
  c_2 &= 5 $
  
  Therefore, we have the final equation:
  #solution-box[$ y(x) = 2(-x)^(1/2) + 5(-x)^(1/2) ln(-x) $]
]

== Remixed Problem
#qa(auth: "HANNA CHARISSE O. TINGIN")[
  Find the solution of the given initial value problem on $(-infinity, 0)$:
  $ 12 x^2 y'' - 5 x y' + 6 y = 0; quad y(-1) = 2, quad y'(-1) = 4 $
][
  Because the interval is $x < 0$, we use the substitution $t = -x$. As established in Problem 2, the form of the Cauchy-Euler equation remains unchanged under this substitution, so we use the equation:
  
  $ 12 t^2 (d^2 y)/(d t^2) - 5 t (d y)/(d t) + 6 y = 0 $ for $t > 0$.
  
  From Problem 1, we know the roots to the corresponding auxiliary equation are $r_1 = 3/4$ and $r_2 = 2/3$.
  
  Thus, the general solution in terms of $t$ is:
  $ y(t) = c_1 t^(3/4) + c_2 t^(2/3) $
  
  Substituting $t = -x$ back in, we get the general solution for $x < 0$:
  $ y(x) = c_1 (-x)^(3/4) + c_2 (-x)^(2/3) $
  
  Applying the initial condition $y(-1) = 2$, we obtain:
  $ y(-1) = c_1 (1)^(3/4) + c_2 (1)^(2/3) \
  c_1 + c_2 = 2 $
  
  Computing the derivative:
  $ y'(x) = -3/4 c_1 (-x)^(-1/4) - 2/3 c_2 (-x)^(-1/3) $
  
  Evaluating at $x = -1$, we get:
  $ y'(-1) &= -3/4 c_1 (1) - 2/3 c_2 (1) \
  4 &= -3/4 c_1 - 2/3 c_2 $
  
  We now have a system of two equations: 
  $ text((1) space space) c_1 + c_2 = 2 => c_2 = 2 - c_1 $
  $ text((2) space space) -3/4 c_1 - 2/3 c_2 = 4 $
  
  Substituting equation (1) into equation (2), we have:
  $ -3/4 c_1 - 2/3 (2 - c_1) &= 4 \
  -3/4 c_1 - 4/3 + 2/3 c_1 &= 4 $
  
  Simplifying to get $c_1$:
  $ -9/12 c_1 + 8/12 c_1 &= 4 + 4/3 \
  -1/12 c_1 &= 16/3 \
  c_1 &= -12(16/3) = -48 $
  
  Using $c_2 = 2 - c_1$:
  $ c_2 = 2 - (-48) = 50 $
  
  Therefore, we have the final equation:
  #solution-box[$ y(x) = -48(-x)^(3/4) + 50(-x)^(2/3) $]
]

== Links to Exercises
\
[1] Herman, R. (2022, November 27). _5.7.1: Cauchy-Euler equations (Exercises)_. LibreTexts. https://math.libretexts.org/Courses/Cosumnes_River_College/Math_420%3A_Differential_Equations_(Breitenbach)/05%3A_Linear_Second_Order_Equations/5.07%3A_Cauchy-Euler_Equations/5.7.01%3A_Cauchy-Euler_Equations_(Exercises)