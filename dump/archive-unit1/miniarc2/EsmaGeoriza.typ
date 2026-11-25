Esma, Georiza

1. 
  *[Burden and Faires. Chapter 6. Exercise Set 6.6]*
  28. Prove the theorem. [_Hint:_ Show that $u_(i, i+1)<1$, for each $i = 1, 2, ..., n-1$, and that $abs(l_(i i)) > 0$, for each $i = 1, 2, ..., n$. Deduce that $det A = det L dot det U != 0$].
  
  *Theorem.*
  Suppose that $A = [a_(i j)]$ is tridiagonal with $a_(i, i-1) a_(i, i+1) != 0$ for each $i = 2, 3, ..., n-1$. 
  
  If $abs(a_11) > abs(a_12)$, 
  
  $abs(a_(i i)) >= abs(a_(i, i-1)) + abs(a_(i, i+1)))$ for each $i = 2, 3, ..., n-1$, and 
  
  $abs(a_(n n)) > abs(a_(n, n-1))$, 
  
  then $A$ is nonsingular and the values of $l_(i i)$ described in the Crout Factorization Algorithm are nonzero for each $i = 1, 2, ..., n$.

  *Proof.*
  
  We want to show that $u_(i, i+1)<1$, for each $i = 1, 2, ..., n-1$. We do this by induction.
  
  Base case. Since $abs(a_11) > abs(a_12)$,  $abs(u_(1 2)) = abs(a_(1 2) / a_(1 1) )< 1$.
  
  Suppose $u_(i-1, i)<1$ for each $i = 1, 2, ..., n-1$. 
  
  Then
  
  $abs(l_(i i)) = abs(a_(i i) - a_(i, i-1) u_(i-1, i)) &>= abs(a_(i i)) - abs(a_(i, i-1)) abs( u_(i-1, i)) \
  &> abs(a_(i i)) - abs(a_(i, i-1)) & "since " abs( u_(i-1, i)) < 0 \
  & >= abs(a_(i, i+1)) > 0
  & "by rearranging " abs(a_(i i)) >= abs(a_(i, i-1)) + abs(a_(i, i+1)) 
  $
  
  Thus, 1 > $abs(a_(i, i+1)) / abs(l_(i i)) = abs(u_(i, i+1))$.
  
  Hence, $u_(i, i+1)<1$, for each $i = 1, 2, ..., n-1$. Furthermore, $abs(l_(i i)) > 0$.
  
  Using the Crout factorization algorithm on $A$, we have $A = L U$.
  
  So, $det(A) = det(L U) = det(L) det(U) = det(L) (1) = det(L) != 0$ since $det(L)$ is the product of its diagonals.
  
  Therefore, $A$ is nonsingular. ∎

+ *[Remixed Problem.]*

  Without solving for the determinant or factorizing the matrix, determine $t$ such that the matrix is nonsingular. 
  
  $ mat(delim: "[", 3, t, 0, 0; 2, 4, 6, 0; 0, 1, 3, t; 0, 0, 1, t) $
  
  We can use the theorem to prove it is nonsingular. We want the matrix to be tridiagonal so $t != 0$.
  
  We also want to satisfy the following: $abs(a_11) > abs(a_12)$, $abs(a_(i i)) >= abs(a_(i, i-1)) + abs(a_(i, i+1)))$ for each $i = 2, 3, ..., n-1$, and 
  $abs(a_(n n)) > abs(a_(n, n-1))$.
  
  - So, $abs(3) > abs(t)$, 
  - $3 >= abs(1 + abs(t)) = 1 + abs(t) => 2 >= abs(t)$ , and
  - $abs(t) > abs(1)$.
  
  Considering all of this, the only possible value is *$t =2$*.

+ *[Burden and Faires. Chapter 6. Exercise Set 6.6]*
  24. Suppose $A$ and $B$ commute, that is, $A B = B A$. Must $A^t$ and $B^t$ also commute?

  *Proof.*
  Let $A$, $B$ be matrices such that $A B = B A$. Taking the transpose of both sides, $(A B)^t = (B A)^t$. By the socks-and-shoes property of transposes, $B^t A^t = A^t B^t$. Thus, $A^t$ and $B^t$ also commute.∎

+  *[Remixed Problem.]* 
  
  Given $M = A B$ where
  $A = mat(delim: "[", 1, 2; 2, 1)$
  $B = mat(delim: "[", 2, 3; 3, 2)$.

  a. Solve for the Crout decomposition of $M$. 


    #[
    #let lub(x) = text(fill: blue)[$#x$]
    #let lur(x) = text(fill: red)[$#x$]
    #let luv(x) = text(fill: violet)[$#x$]
    $
    M = A B = B = mat(delim: "[", 8, 7; 10, 8) => 
    mat(delim: "[", lub(8), lur(7/8); lub(10), lub(-3/4)) =>M = L_C U_C =mat(delim: "[", 8, 0; 10, -3/4)
    mat(delim: "[", 1, 7/8; 0, 1)
    $
    ]
    
  b. Without manually factorizing, find the Doolittle Decomposition of $A^t B^t$

    Notice that $A B = B A$. Given this, we have shown that $A^t$ and $B^t$ commute. So $
    A^t B^t = B^t A^t = (A B)^t = M^t = (L_C U_C)^t = U_C^t L_C^t =
    mat(delim: "[", 1, 0; 7/8, 1)
    mat(delim: "[", 8, 10; 0, -3/4)
    $.