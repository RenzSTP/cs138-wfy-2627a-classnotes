#import "../assets.typ": notes, definition, theorem, algorithm, example, note

#show: notes.with(
  title: [Normalized Power Method],
  subtitle: [ Arc 4 · Compendium · Gabriel Ian Carl Matias ])

== Problem 1 & 2

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
#set enum(numbering: n => text(weight: "bold")[#numbering("a.", n)])
 + Use the Geršgorin Circle Theorem to determine a region in the complex plane containing all the eigenvalues of A. 
 + Use the Power method to determine the dominant eigenvalue of the matrix and its associated eigenvector. (at the 14th iteration)
*Remix:*
  Perform 1 iteration of QR Factorization on A.

== Solution
#set enum(numbering: n => text(weight: "bold")[#numbering("a.", n)])
#show math.equation.where(block: true): set block(breakable: true)
+ Note that each Geršgorin disk $D_i$ is centered at $a_(i i)$ and each disk has a radius $R_i$ which the absolute sum of all the non-diagonal entries in row _i_ such that:
  $
  D_i (A) = {z in bb(C): |z-a_(i i)| <= |R_i|}\
  $
  Applying this form to the given matrix we get:
  $
    "Row 1:" D_1(A) &= {z in bb(C): |z-0| <= |0|+|2|+|4|}\
    &= {z in bb(C): z <= 6}\
    "Row 2:" D_2(A) &= {z in bb(C): |z-0| <= |1/2|+|0|+|0|}\
    &= {z in bb(C): z <= 1/2}\
    "Row 3:" D_3(A) &= {z in bb(C): |z-0| <= |0|+|1/4|+|0|}\
    &= {z in bb(C): z <= 1/4}\
    "Row 4:"D_4(A) &= {z in bb(C): |z-0| <= |0|+|0|+|1/8|} \
    &= {z in bb(C): z <= 1/8}\
  $

  To find the region containing all the eigenvalues, we take the union of all disks wherein:
  $
    z <= 6 union z <= 1/2 union  z <= 1/4 union z <= 1/8
  $
  Which is equivalent to $z <= 6$\
  This means all of the eigenvalues of A lie inside $D_1 = {z in bb(C): z <= 6}$.
  \
  \
+ We apply the Power Method on A with initial guess $x^((0)) =  mat(delim:"[",
,1,;
,1,;
,1,;
,1,;
column-gap: #0.5em,
)$ and normalize after every iteration using its infinity norm.

  *Iteration 1:*
  $
    y^((1)) &= A x^((0))\
    y^((1)) &= mat(delim:"[",
                ,0, 0, 2, 4,;
                ,1/2, 0, 0, 0,;
                ,0, 1/4, 0, 0,;
                ,0, 0, 1/8, 0,;
                column-gap: #1em,
                )
                mat(delim:"[",
                ,1,;
                ,1,;
                ,1,;
                ,1,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,6,;
                ,1/2,;
                ,1/4,;
                ,1/8,;
                column-gap: #0.5em,
                )\
    x^((1)) &= y^((1))/(||y^((1))||_infinity)\
            &= 1/6 mat(delim:"[",
                ,6,;
                ,1/2,;
                ,1/4,;
                ,1/8,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,1,;
                ,1/12,;
                ,1/24,;
                ,1/48,;
                column-gap: #0.5em,
                )\
  $

    *Iteration 2:*
  $
    y^((2)) &= mat(delim:"[",
                ,0, 0, 2, 4,;
                ,1/2, 0, 0, 0,;
                ,0, 1/4, 0, 0,;
                ,0, 0, 1/8, 0,;
                column-gap: #1em,
                )
                mat(delim:"[",
                ,1,;
                ,1/12,;
                ,1/24,;
                ,1/48,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,1/6,;
                ,1/2,;
                ,1/48,;
                ,1/192,;
                column-gap: #0.5em,
                )\
            x^((2)) &= 1/(1/2) mat(delim:"[",
                ,1/6,;
                ,1/2,;
                ,1/48,;
                ,1/192,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,1/3,;
                ,1,;
                ,1/24,;
                ,1/96,;
                column-gap: #0.5em,
                )\
  $

  *Iteration 3:*
  $
    y^((3)) &= mat(delim:"[",
                ,0, 0, 2, 4,;
                ,1/2, 0, 0, 0,;
                ,0, 1/4, 0, 0,;
                ,0, 0, 1/8, 0,;
                column-gap: #1em,
                )
                mat(delim:"[",
                ,1/3,;
                ,1,;
                ,1/24,;
                ,1/96,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,1/8,;
                ,1/6,;
                ,1/4,;
                ,1/192,;
                column-gap: #0.5em,
                )\
            x^((3)) &= 1/(1/4) mat(delim:"[",
                ,1/8,;
                ,1/6,;
                ,1/4,;
                ,1/192,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,1/2,;
                ,2/3,;
                ,1,;
                ,1/48,;
                column-gap: #0.5em,
                )\
  $

  *Iteration 4:*
  $
    y^((4)) &= mat(delim:"[",
                ,0, 0, 2, 4,;
                ,1/2, 0, 0, 0,;
                ,0, 1/4, 0, 0,;
                ,0, 0, 1/8, 0,;
                column-gap: #1em,
                )
                mat(delim:"[",
                ,1/2,;
                ,2/3,;
                ,1,;
                ,1/48,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,25/12,;
                ,1/4,;
                ,1/6,;
                ,1/8,;
                column-gap: #0.5em,
                )\
            x^((4)) &= 1/(25/12) mat(delim:"[",
                ,25/12,;
                ,1/4,;
                ,1/6,;
                ,1/8,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,1,;
                ,3/25,;
                ,2/25,;
                ,3/50,;
                column-gap: #0.5em,
                )\
  $

  *Iteration 5:*
  $
    y^((5)) &= mat(delim:"[",
                ,0, 0, 2, 4,;
                ,1/2, 0, 0, 0,;
                ,0, 1/4, 0, 0,;
                ,0, 0, 1/8, 0,;
                column-gap: #1em,
                )
                mat(delim:"[",
                ,1,;
                ,3/25,;
                ,2/25,;
                ,3/50,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,2/5,;
                ,1/2,;
                ,3/100,;
                ,1/100,;
                column-gap: #0.5em,
                )\
            x^((5)) &= 1/(1/2) mat(delim:"[",
                ,2/5,;
                ,1/2,;
                ,3/100,;
                ,1/100,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,4/5,;
                ,1,;
                ,3/50,;
                ,1/50,;
                column-gap: #0.5em,
                )\
  $

  *Iteration 6:*
  $
    y^((6)) &= mat(delim:"[",
                ,0, 0, 2, 4,;
                ,1/2, 0, 0, 0,;
                ,0, 1/4, 0, 0,;
                ,0, 0, 1/8, 0,;
                column-gap: #1em,
                )
                mat(delim:"[",
                ,4/5,;
                ,1,;
                ,3/50,;
                ,1/50,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,1/5,;
                ,2/5,;
                ,1/4,;
                ,3/400,;
                column-gap: #0.5em,
                )\
            x^((6)) &= 1/(2/5) mat(delim:"[",
                ,1/5,;
                ,2/5,;
                ,1/4,;
                ,3/400,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,1/2,;
                ,1,;
                ,5/8,;
                ,3/160,;
                column-gap: #0.5em,
                )\
  $

  *Iteration 7:*
  $
    y^((7)) &= mat(delim:"[",
                ,0, 0, 2, 4,;
                ,1/2, 0, 0, 0,;
                ,0, 1/4, 0, 0,;
                ,0, 0, 1/8, 0,;
                column-gap: #1em,
                )
                mat(delim:"[",
                ,1/2,;
                ,1,;
                ,5/8,;
                ,3/160,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,53/40,;
                ,1/4,;
                ,1/4,;
                ,5/64,;
                column-gap: #0.5em,
                )\
            x^((7)) &= 1/(53/40) mat(delim:"[",
                ,53/40,;
                ,1/4,;
                ,1/4,;
                ,5/64,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,1,;
                ,10/53,;
                ,10/53,;
                ,25/424,;
                column-gap: #0.5em,
                )\
  $

  *Iteration 8:*
  $
    y^((8)) &= mat(delim:"[",
                ,0, 0, 2, 4,;
                ,1/2, 0, 0, 0,;
                ,0, 1/4, 0, 0,;
                ,0, 0, 1/8, 0,;
                column-gap: #1em,
                )
                mat(delim:"[",
                ,1,;
                ,10/53,;
                ,10/53,;
                ,25/424,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,65/106,;
                ,1/2,;
                ,5/106,;
                ,5/212,;
                column-gap: #0.5em,
                )\
            x^((8)) &= 1/(65/106) mat(delim:"[",
                ,65/106,;
                ,1/2,;
                ,5/106,;
                ,5/212,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,1,;
                ,53/65,;
                ,1/13,;
                ,1/26,;
                column-gap: #0.5em,
                )\
  $

  *Iteration 9:*
  $
    y^((9)) &= mat(delim:"[",
                ,0, 0, 2, 4,;
                ,1/2, 0, 0, 0,;
                ,0, 1/4, 0, 0,;
                ,0, 0, 1/8, 0,;
                column-gap: #1em,
                )
                mat(delim:"[",
                ,1,;
                ,53/65,;
                ,1/13,;
                ,1/26,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,4/13,;
                ,1/2,;
                ,53/260,;
                ,1/104,;
                column-gap: #0.5em,
                )\
            x^((9)) &= 1/(1/2) mat(delim:"[",
                ,4/13,;
                ,1/2,;
                ,53/260,;
                ,1/104,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,8/13,;
                ,1,;
                ,53/130,;
                ,1/52,;
                column-gap: #0.5em,
                )\
  $

  *Iteration 10:*
  $
    y^((10)) &= mat(delim:"[",
                ,0, 0, 2, 4,;
                ,1/2, 0, 0, 0,;
                ,0, 1/4, 0, 0,;
                ,0, 0, 1/8, 0,;
                column-gap: #1em,
                )
                mat(delim:"[",
                ,8/13,;
                ,1,;
                ,53/130,;
                ,1/52,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,58/65,;
                ,4/13,;
                ,1/4,;
                ,53/1040,;
                column-gap: #0.5em,
                )\
            x^((10)) &= 1/(58/65) mat(delim:"[",
                ,58/65,;
                ,4/13,;
                ,1/4,;
                ,53/1040,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,1,;
                ,10/29,;
                ,65/232,;
                ,53/928,;
                column-gap: #0.5em,
                )\
  $

  *Iteration 11:*
  $
    y^((11)) &= mat(delim:"[",
                ,0, 0, 2, 4,;
                ,1/2, 0, 0, 0,;
                ,0, 1/4, 0, 0,;
                ,0, 0, 1/8, 0,;
                column-gap: #1em,
                )
                mat(delim:"[",
                ,1,;
                ,10/29,;
                ,65/232,;
                ,53/928,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,183/232,;
                ,1/2,;
                ,5/58,;
                ,65/1856,;
                column-gap: #0.5em,
                )\
            x^((11)) &= 1/(183/232) mat(delim:"[",
                ,183/232,;
                ,1/2,;
                ,5/58,;
                ,65/1856,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,1,;
                ,116/183,;
                ,20/183,;
                ,65/1464,;
                column-gap: #0.5em,
                )\
  $

  *Iteration 12:*
  $
    y^((12)) &= mat(delim:"[",
                ,0, 0, 2, 4,;
                ,1/2, 0, 0, 0,;
                ,0, 1/4, 0, 0,;
                ,0, 0, 1/8, 0,;
                column-gap: #1em,
                )
                mat(delim:"[",
                ,1,;
                ,116/183,;
                ,20/183,;
                ,65/1464,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,145/366,;
                ,1/2,;
                ,29/183,;
                ,5/366,;
                column-gap: #0.5em,
                )\
            x^((12)) &= 1/(1/2) mat(delim:"[",
                ,145/366,;
                ,1/2,;
                ,29/183,;
                ,5/366,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,145/183,;
                ,1,;
                ,58/183,;
                ,5/183,;
                column-gap: #0.5em,
                )\
  $

  *Iteration 13:*
  $
    y^((13)) &= mat(delim:"[",
                ,0, 0, 2, 4,;
                ,1/2, 0, 0, 0,;
                ,0, 1/4, 0, 0,;
                ,0, 0, 1/8, 0,;
                column-gap: #1em,
                )
                mat(delim:"[",
                ,145/183,;
                ,1,;
                ,58/183,;
                ,5/183,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,136/183,;
                ,145/366,;
                ,1/4,;
                ,29/732,;
                column-gap: #0.5em,
                )\
            x^((13)) &= 1/(136/183) mat(delim:"[",
                ,136/183,;
                ,145/366,;
                ,1/4,;
                ,29/732,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,1,;
                ,145/272,;
                ,183/544,;
                ,29/544,;
                column-gap: #0.5em,
                )\
  $

  *Iteration 14:*
  $
    y^((14)) &= mat(delim:"[",
                ,0, 0, 2, 4,;
                ,1/2, 0, 0, 0,;
                ,0, 1/4, 0, 0,;
                ,0, 0, 1/8, 0,;
                column-gap: #1em,
                )
                mat(delim:"[",
                ,1,;
                ,145/272,;
                ,183/544,;
                ,29/544,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,241/272,;
                ,1/2,;
                ,145/1088,;
                ,183/4352,;
                column-gap: #0.5em,
                )\
            x^((14)) &= 1/(241/272) mat(delim:"[",
                ,241/272,;
                ,1/2,;
                ,145/1088,;
                ,183/4352,;
                column-gap: #0.5em,
                )\
            &= mat(delim:"[",
                ,1,;
                ,136/241,;
                ,145/964,;
                ,183/3856,;
                column-gap: #0.5em,
                )\
  $

  We stop the iterating here in the interest of solution length.  At this point, the dominant eigenvalue is *$241/272$* and its corresponding eigenvector is 
 * $mat(delim:"[",
                ,1,;
                ,136/241,;
                ,145/964,;
                ,183/3856,;
                column-gap: #0.5em,
                )
  $*.
  
== Remixed Problem:
From A we have:
  $
    a_1 = mat(delim:"[",
                ,0,;
                ,1/2,;
                ,0,;
                ,0,;
                column-gap: #0.5em,
                )
                space space
    a_2 = mat(delim:"[",
                ,0,;
                ,0,;
                ,1/4,;
                ,0,;
                column-gap: #0.5em,
                )
                space space
    a_3 = mat(delim:"[",
                ,2,;
                ,0,;
                ,0,;
                ,1/8,;
                column-gap: #0.5em,
                )
                space space
    a_4 = mat(delim:"[",
                ,4,;
                ,0,;
                ,0,;
                ,0,;
                column-gap: #0.5em,
                )
  $
  
  Finding *$q_1$:*
  $
    v_1 = a_1 = mat(delim:"[",
                ,0,;
                ,1/2,;
                ,0,;
                ,0,;
                column-gap: #0.5em,
                ), space space space r_(11) = ||v_1||_(2) = sqrt(0^2 + 0^2 + (1/2)^2 + 0^2) = 1/2\
    \
  q_1 = v_1 / r_(11) = 2 mat(delim:"[",
                ,0,;
                ,1/2,;
                ,0,;
                ,0,;
                column-gap: #0.5em,
                ) = bold(mat(delim:"[",
                ,0,;
                ,1,;
                ,0,;
                ,0,;
                column-gap: #0.5em,
                ))
  $

 Finding *$q_2$:*
 $
  v_2 = a_2 - r_12q_1\
\
 r_12 = q_1 dot a_2 =  mat(delim:"[",
                ,0,;
                ,1,;
                ,0,;
                ,0,;
                column-gap: #0.5em,
                ) dot mat(delim:"[",
                ,0,;
                ,0,;
                ,1/4,;
                ,0,;
                column-gap: #0.5em,
                ) = 0\
\
v_2 = mat(delim:"[",
                ,0,;
                ,0,;
                ,1/4,;
                ,0,;
                column-gap: #0.5em,
                ) - 0 = mat(delim:"[",
                ,0,;
                ,0,;
                ,1/4,;
                ,0,;
                column-gap: #0.5em,
                )\
                \
r_22 = ||v_2|| _2 = sqrt(0^2+0^2+(1/4)^2+0^2) = 1/4\
\

q_2 = v_2 / r_22 = 4 mat(delim:"[",
                ,0,;
                ,0,;
                ,1/4,;
                ,0,;
                column-gap: #0.5em,
                ) = mat(delim:"[",
                ,0,;
                ,0,;
                ,1,;
                ,0,;
                column-gap: #0.5em,
                )
                \ 
 $

 Finding *q_3*:

 $
  v_3 = a_3 - r_13q_1 - r_23q_2\
  \
  r_13 = mat(delim:"[",
                ,0,;
                ,1,;
                ,0,;
                ,0,;
                column-gap: #0.5em,
                ) dot mat(delim:"[",
                ,2,;
                ,0,;
                ,0,;
                ,1/8,;
                column-gap: #0.5em,
                ) = 0\
                \
  r_23 =  mat(delim:"[",
                ,0,;
                ,0,;
                ,1,;
                ,0,;
                column-gap: #0.5em,
                ) dot mat(delim:"[",
                ,2,;
                ,0,;
                ,0,;
                ,1/8,;
                column-gap: #0.5em,
                ) = 0\
                \
                v_3 =  mat(delim:"[",
                ,2,;
                ,0,;
                ,0,;
                ,1/8,;
                column-gap: #0.5em,
                ) - 0 - 0 =  mat(delim:"[",
                ,2,;
                ,0,;
                ,0,;
                ,1/8,;
                column-gap: #0.5em,
              )\
              \
  r_33 =  ||v_3||_(2) = sqrt(2^2 + 0^2 + 0^2 + (1/8)^2) = sqrt(4+1/64) = sqrt(257)/8\
  \
  q_3 = v_3/r_33 = 8/sqrt(257) mat(delim:"[",
                ,2,;
                ,0,;
                ,0,;
                ,1/8,;
                column-gap: #0.5em,
              ) = mat(delim:"[",
                ,16/sqrt(257),;
                ,0,;
                ,0,;
                ,1/sqrt(257),;
                column-gap: #0.5em,
              )
 $

 Finding *$q_4$*:

$
  v_4 = a_4 - r_14q_1 - r_24q_2  - r_34q_3\
  \
  r_14 = mat(delim:"[",
                ,0,;
                ,1,;
                ,0,;
                ,0,;
                column-gap: #0.5em,
                ) dot mat(delim:"[",
                ,4,;
                ,0,;
                ,0,;
                ,0,;
                column-gap: #0.5em,
                ) = 0\
                
  r_24 = mat(delim:"[",
                ,0,;
                ,0,;
                ,1,;
                ,0,;
                column-gap: #0.5em,
                ) dot mat(delim:"[",
                ,4,;
                ,0,;
                ,0,;
                ,0,;
                column-gap: #0.5em,
                ) = 0\
                
  r_34 = mat(delim:"[",
                ,16/sqrt(257),;
                ,0,;
                ,0,;
                ,1/sqrt(257),;
                column-gap: #0.5em,
              ) dot mat(delim:"[",
                ,4,;
                ,0,;
                ,0,;
                ,0,;
                column-gap: #0.5em,
                ) = 64/sqrt(257)\
                \
  v_4 = mat(delim:"[",
                ,4,;
                ,0,;
                ,0,;
                ,0,;
                column-gap: #0.5em,
                ) - 0 - 0 - 64/sqrt(257) mat(delim:"[",
                ,16/sqrt(257),;
                ,0,;
                ,0,;
                ,1/sqrt(257),;
                column-gap: #0.5em,
              ) = mat(delim:"[",
                ,4 - 1024/257,;
                ,0,;
                ,0,;
                ,-64/257,;
                column-gap: #0.5em,
                )\
                = mat(delim:"[",
                ,4/257,;
                ,0,;
                ,0,;
                ,-64/257,;
                column-gap: #0.5em,
                )\
  r_44 = ||v_4||_(2) = sqrt((4/257)^2 + 0^2 + 0^2 + (-64/257)^2) = sqrt(4112)/257\
  = 4sqrt(257)/257 \
  q_4 = v_4/r_44 = 257 /(4sqrt(257)) mat(delim:"[",
                ,4/257,;
                ,0,;
                ,0,;
                ,-64/257,;
                column-gap: #0.5em,
                ) = mat(delim:"[",
                ,1/sqrt(257),;
                ,0,;
                ,0,;
                ,-16/sqrt(257),;
                column-gap: #0.5em,
                )\
$

Constructing $Q$ and $R$:

$
  Q = mat(delim:"[",
          ,0, 0, 16/sqrt(257), 1/sqrt(257),;
          ,1, 0, 0, 0,;
          ,0, 1, 0, 0,;
          ,0, 0, 1/sqrt(257), -16/sqrt(257),;
          column-gap: #1em,
          ), space space space 
  R = mat(delim:"[",
          ,1/2, 0, 2, 4,;
          ,0, 1/4, 0, 0,;
          ,0, 0, sqrt(257)/8, 64/sqrt(257),;
          ,0, 0, 0, 4/sqrt(257),;
          column-gap: #1em,
          ) 
$
Giving us:
$
A^((1)) = R Q = mat(delim:"[",
          ,0, 0, 8/sqrt(257), 1/(2 sqrt(257)),;
          ,1/4, 0, 0, 0,;
          ,0, sqrt(257)/8, 64/257, -1024/257,;
          ,0, 0, 1/sqrt(257), -64/257,;
          column-gap: #1em,
          )
$

= Reference:
1. Burden, R. L. & Faires, J. D. (1978). _Numerical Analysis_.

