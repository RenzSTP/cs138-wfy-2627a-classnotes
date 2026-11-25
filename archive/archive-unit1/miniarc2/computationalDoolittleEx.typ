
// Form: $L U= mat(delim: "[", 1, 0; v/a_11, L') mat(delim: "[", a_11, w^T; 0, U')$


Consider $A = mat(delim: "[", 2, 3, 1, 4; 2, 6, 3, 5; 4, 3, 4, 9; 2, 9, 9, 13)$.

#let lub(x) = text(fill: blue)[$#x$]
#let lur(x) = text(fill: red)[$#x$]

#table(
  columns: (auto, 20%, auto, auto),
  row-gutter: 3%,
  align: (left, center, left, left),
  stroke: none,
  [
    // A_0
    $A_0 = mat(delim: "[", 2, lub(3), lub(1), lub(4); lur(2), 6, 3, 5; lur(4), 3, 4, 9; lur(2), 9, 9, 13)$], [
      // yes im crazy
      $ mat(delim: #none, lur("red"/2);  
        mat(delim: "[", lur(1); lur(2); lur(1)) times mat(delim: "[", lub(3), lub(1), lub(4))
      ) $
      
    ], [
      $mat(delim: "[", 2, lub(3), lub(1), lub(4); lur(1), 3, 1, 4; lur(2), 6, 2, 8; lur(1), 3, 1, 4)$
    ], [
      $A_1 &= mat(delim: "[", 6, 3, 5; 3, 4, 9; 9, 9, 13) - mat(delim: "[", 3, 1, 4; 6, 2, 8; 3, 1, 4) \ &= mat(delim: "[", 3, 2, 1; -3, 2, 1; 6, 8, 9)$
    ],
  [
    // A_1
    $A_1 = mat(delim: "[", 3, lub(2), lub(1); lur(-3), 2, 1; lur(6), 8, 9)$
    ], [
      $ mat(delim: #none, lur("red"/3); 
        mat(delim: "[", lur(-1); lur(2)) times mat(delim: "[", lub(2), lub(1))
      ) $
      
    ], [
      $mat(delim: "[", 3, lub(2), lub(1); lur(-1), -2, -1; lur(2), 4, 2)$
    ], [
      $A_2 = mat(delim: "[", 2, 1; 8, 9) - mat(delim: "[", -2, -1; 4, 2) = mat(delim: "[", 4, 2; 4, 7)$
    ],
  [
    // A_2
      $A_2 = mat(delim: "[", 4, lub(2); lur(4), 7)$
    ], [
      $ mat(delim: #none, lur("red"/4);
        mat(delim: "[", lur(1);) times mat(delim: "[", lub(2))
      ) $
    ], [
      $mat(delim: "[", 4, lub(2); lur(1), 2)$
    ], [
      $A_3 = mat(delim: "[", 7) - mat(delim: "[", 2) = mat(delim: "[", 5)$
    ],
  [
    // A_3
   $A_3 = mat(delim: "[", 5)$   
    ], [], [$mat(delim: "[", 5)$]
)

So we have, 

#table(
  columns: (auto, auto),
  align: (center, center),
  stroke: none,
  [$L = mat(delim: "[", 1, 0, 0, 0; 1, 1, 0, 0; 2, -1, 1, 0; 1, 2, 1, 1)$],
  [$U  = mat(delim: "[", 2, 3, 1, 4; 0, 3, 2, 1; 0, 0, 4, 2;0, 0, 0, 5)$]
)
