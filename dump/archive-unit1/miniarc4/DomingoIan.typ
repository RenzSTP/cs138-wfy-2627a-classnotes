#import "../assets.typ": notes, definition, theorem, algorithm, example, note

#show: notes.with(
  title: [Rayleigh's Quotient],
  subtitle: [ Arc 4 · Part 6 · Compendium])

== Problem 1

\
*Exercise 27.1.* Let $A in CC^(m times m)$ be given, not necessarily hermitian. Show that a number $z in CC$ is a Rayleigh quotient of $A$ if and only if it is a diagonal entry of $Q^* A Q$ for some unitary matrix $Q$. Thus Rayleigh quotients are just diagonal entries of matrices, once you transform orthogonally to the right coordinate system.

(Trefethen & Bau, 1997, p. 209)
\

== Solution

We know that some unit vector $x$ exists such that it satisfies 

#align(center)[$z = frac(x^T A x, x^T x) = x^T A x$ ]
since $z$ is a Rayleigh Quotient of $A$. Then, suppose we have unitary matrix $Q$ such that it has $x$ as its first column. When we calculate entry $(1,1)$ of $Q^T A Q$, we are essentially multiplying the first column of $Q$ by $A$, and then by the conjugate transpose of that same column. This would produce $x^T A x$ that is equal to $z$. 

#align(center)[$(Q^T A Q)_((1, 1)) = q_1^T A q_1 = x^T A x = z$]

$therefore z$ must be a diagonal entry of $Q^T A Q qed$
\

== Problem 2
#let a1 = $mat(-4,14,0;-5,13,0;-1,0,2, delim: "[")$;

\
*Example 1.* Use the Power method to approximate the dominant eigenvalue of the matrix,

#align(center)[#text(size: 1.4em)[$A=#a1$]]

and then apply Aitken’s $Delta^2$ method to the approximations to the eigenvalue of the matrix
to accelerate the convergence (Burden & Faires, 1978, p. 580).

\
== Solution

Instead of solving this with power method, we will use the Rayleigh's Quotient algorithm as stated above. 

1. Select an initial guess:
#let x = $mat(1;1;1, delim: "[")$;
#let xT = $mat(1,1,1, delim: "[")$;

#align(center)[$x^((0))= #x$]

2. Get the first approximate eigenvalue $lambda^((0))$:

  #align(center)[$lambda^((0))=frac((x^((0)))^T A x^((0)), (x^((0)))^T x^((0)))$]

  #align(center)[$=frac(#xT #a1 #x, #xT #x)$]

  #align(center)[$=frac(mat(-10, 27, 2, delim: "[")  #x, 3)$]

  #align(center)[$=frac(19, 3)approx 6.3333$]

=== Iteration k = 0:
#line(stroke: black, length: 6.5em)

#let k = 0;
#let kk = 1;
#let lamb = $frac(16,3)$;

#h(1em) a) Get $y^((#k))$:

#align(center)[$(A - lambda^((#k)) I) y^((#k)) = x^((#k))$]

#align(center)[$(#a1 - mat(lamb,0,0;0,lamb,0;0,0,lamb, delim:"[")) y^((#k)) = #x$]

#let yk = $mat(57/14;39/14;-213/140, delim: "[")$;
#align(center)[$y^((#k)) = #yk$]

#h(1em) b) Get $||y^((#k))||_(infinity):$

#align(center)[$||y^((#k))||_(infinity) = |57/14|=57/14$]

#let x = $mat(1;13/19;-71/190, delim: "[")$;
#let xT = $mat(1,13/19,-71/190, delim: "[")$;

#h(1em) c) Get $x^((#kk))$:
#align(center)[$x^((#kk))= 14/57 #yk = #x  $]

#h(1em) d) Get $lambda^((#kk))$:

#align(center)[$lambda^((#kk))=frac((x^((#kk)))^T A x^((#kk)), (x^((#kk)))^T x^((#kk)))$]

#align(center)[$lambda^((#kk))= frac(#xT #a1 #x, #xT #x)$]

#align(center)[$lambda^((#kk))= frac(8.8967, 1.6078)approx 5.53346$]

=== Iteration k = 1:
#line(stroke: black, length: 6.5em)

#let k = 1;
#let kk = 2;
#let lamb = 5.53346;

#h(1em) a) Get $y^((#k))$:

#align(center)[$(A - lambda^((#k)) I) y^((#k)) = x^((#k))$]

#align(center)[$(#a1 - mat(lamb,0,0;0,lamb,0;0,0,lamb, delim:"[")) y^((#k)) = #x$]

#let yk = $mat(1.7872; 1.2884; -0.4000, delim: "[")$;
#align(center)[$y^((#k)) = #yk$]

#h(1em) b) Get $||y^((#k))||_(infinity):$

#align(center)[$||y^((#k))||_(infinity) = |1.7872|=1.7872$]

#let x = $mat(1; 0.7209; -0.2238, delim: "[")$;
#let xT = $mat(1, 0.7209, -0.2238, delim: "[")$;

#h(1em) c) Get $x^((#kk))$:
#align(center)[$x^((#kk))= 1/1.7872 #yk = #x  $]

#h(1em) d) Get $lambda^((#kk))$:

#align(center)[$lambda^((#kk))=frac((x^((#kk)))^T A x^((#kk)), (x^((#kk)))^T x^((#kk)))$]

#align(center)[$lambda^((#kk))= frac(#xT #a1 #x, #xT #x)$]

#align(center)[$lambda^((#kk))= frac(9.5690, 1.5699)approx 6.09529$]

=== Iteration k = 2:
#line(stroke: black, length: 6.5em)

#let k = 2;
#let kk = 3;
#let lamb = 6.09529;

#h(1em) a) Get $y^((#k))$:

#align(center)[$(A - lambda^((#k)) I) y^((#k)) = x^((#k))$]

#align(center)[$(#a1 - mat(lamb,0,0;0,lamb,0;0,0,lamb, delim:"[")) y^((#k)) = #x$]

#let yk = $mat(-10.8096; -7.7233; 2.6941, delim: "[")$;
#align(center)[$y^((#k)) = #yk$]

#h(1em) b) Get $||y^((#k))||_(infinity):$

#align(center)[$||y^((#k))||_(infinity) = |-10.8096|=10.8096$]

#let x = $mat(-1; -0.7145; 0.2492, delim: "[")$;
#let xT = $mat(-1, -0.7145, 0.2492, delim: "[")$;

#h(1em) c) Get $x^((#kk))$:
#align(center)[$x^((#kk))= 1/1.7872 #yk = #x  $]

#h(1em) d) Get $lambda^((#kk))$:

#align(center)[$lambda^((#kk))=frac((x^((#kk)))^T A x^((#kk)), (x^((#kk)))^T x^((#kk)))$]

#align(center)[$lambda^((#kk))= frac(#xT #a1 #x, #xT #x)$]

#align(center)[$lambda^((#kk))= frac(9.4402, 1.5726)approx 6.00293$]

=== Iteration k = 3:
#line(stroke: black, length: 6.5em)

#let k = 3;
#let kk = 4;
#let lamb = 6.00293;

#h(1em) a) Get $y^((#k))$:

#align(center)[$(A - lambda^((#k)) I) y^((#k)) = x^((#k))$]

#align(center)[$(#a1 - mat(lamb,0,0;0,lamb,0;0,0,lamb, delim:"[")) y^((#k)) = #x$]

#let yk = $mat(341.6129; 244.0093; -85.4030, delim: "[")$;
#align(center)[$y^((#k)) = #yk$]

#h(1em) b) Get $||y^((#k))||_(infinity):$

#align(center)[$||y^((#k))||_(infinity) = |341.6129|=341.6129$]

#let x = $mat(1; -0.7143; 0.2500, delim: "[")$;
#let xT = $mat(1, -0.7143, 0.2500, delim: "[")$;

#h(1em) c) Get $x^((#kk))$:
#align(center)[$x^((#kk))= 1/1.7872 #yk = #x  $]

#h(1em) d) Get $lambda^((#kk))$:

#align(center)[$lambda^((#kk))=frac((x^((#kk)))^T A x^((#kk)), (x^((#kk)))^T x^((#kk)))$]

#align(center)[$lambda^((#kk))= frac(#xT #a1 #x, #xT #x)$]

#align(center)[$lambda^((#kk))= frac(9.4362, 1.5727)= 6.0000$]

It was stated in the problem that the eigenvalues for the matrix A was $lambda = 6, 3, 2$. So, we got an eigenvalue after 4 iterations.

\
#align(center)[#box(outset: 1em, stroke: black)[6.0000]]

\

== Remix Problem
Using the non-symmetric matrix $A$ from Problem 2, prove that your answer in Problem 1 is true by constructing a unitary matrix $Q$ and show that the Rayleigh quotient does appear as a diagonal entry of $Q^T A Q$.


== Solution
=== From Previous Solutions

On iteration k = 0, we showed that 
#align(center)[$x^((1))= mat(1;13/19;-71/190, delim: "[")  $]
#align(center)[$lambda^((1))= frac(8.8967, 1.6078)approx 5.53346$]

We calculate $||x^((1))||_2$ and use it normalize $x^((1))$.

#align(center)[$||x^((1))||_2=||mat(1;13/19;-71/190, delim: "[")||_2= sqrt(1^2 + (13/19)^2 + (-71/190)^2) approx 1.2680$]
#align(center)[$frac(x^((1)), ||x^((1))||_2) = 1/1.2680 mat(1;13/19;-71/190, delim: "[") = mat(0.7886; 0.5396; -0.2947, delim: "[")$]

This will be used as the first column for our unitary matrix $Q$.

\
=== Unitary Matrix $Q$ via Gram-Schmidt Process.

First, we select a random guess vector for $u_2$. Suppose we select $mat(1; 1; 1, delim: "[")$.

#align(center)[$u_2 =  mat(1; 1; 1, delim: "[") - frac(mat(1, 1, 1, delim: "[")  mat(0.7886; 0.5396; -0.2947, delim: "["), mat(0.7886, 0.5396, -0.2947, delim: "[") mat(0.7886; 0.5396; -0.2947, delim: "[")) mat(0.7886; 0.5396; -0.2947, delim: "[") = mat(1; 1; 1, delim: "[") - mat(0.8151; 0.5577; -0.3046, delim: "[")$]
#align(center)[$u_2= mat(0.1849; 0.4423; 1.3046, delim: "[")$]

We also normalize $u_2$ to get the second column of $Q$.

#align(center)[$||mat(0.1849; 0.4423; 1.3046, delim: "[")||_2 = sqrt(0.1849^2 + 0.4423^2 + 1.3046^2) approx 1.3899$]
#align(center)[$=>  1/1.3899 mat(0.1849; 0.4423; 1.3046, delim: "[") approx mat(0.1330; 0.3182; 0.9386, delim: "[")$]

We then get the third column of $Q$ by cross multiplying the first two columns.


#align(center)[$mat(0.7886; 0.5396; -0.2947, delim: "[") times mat(0.1330; 0.3182; 0.9386, delim: "[") = mat(0.6002; -0.7794; -0.1792, delim: "[") $]

Thus, we have unitary matrix $Q$.

#align(center)[$Q = mat(0.7886, 0.1330, 0.6002; 0.5396, 0.3182, -0.7794; -0.2947, 0.9386, -0.1792, delim: "[")$]

Computing $Q^T A Q$:

#align(center)[$Q^T A Q = mat(0.7886, 0.1330, 0.6002; 0.5396, 0.3182, -0.7794; -0.2947, 0.9386, -0.1792, delim: "[")^T #a1 mat(0.7886, 0.1330, 0.6002; 0.5396, 0.3182, -0.7794; -0.2947, 0.9386, -0.1792, delim: "[")$]

#align(center)[$=> mat(5.53347, 4.4528, -17.3023; 0.2693, 3.2635, -6.8493; 0.4937, -0.6639, 2.4177, delim: "[")$]

Notice that we can see $lambda^((1))$ as the first entry of $Q^T A Q$; thus, proving the theorem stated in Problem 1. $therefore$ True $qed$

#note[The first entry is off by a digit from $lambda^((1))$ because of rounding errors in the calculations. Nonetheless, it should be the same.]

= References

1. Burden, R. L. & Faires, J. D. (1978). _Numerical Analysis_.

2. Trefethen, L. & Bau, D. (1997). _Numerical Linear Algebra_