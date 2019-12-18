String teXHTML = r"""
     
     <style>
       .card {
         box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
         transition: 0.3s;
         width: 100%;
       }
 
       .card:hover {
         box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
       }
 
       .container {
         padding: 2px 16px;
       }
     </style>


   <p>
     A simple Example to render \( \rm\\TeX \) in flutter with full <B>HTML</B> support<br>
 


           \begin{align}
           \dot{x} & = \sigma(y-x) \\
           \dot{y} & = \rho x - y - xz \\
           \dot{z} & = -\beta z + xy
           \end{align}
   
     <br>
 
     When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
 
     $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br>
 
 
     $$ \oint_C {E \cdot d\ell = - \frac{d}{{dt}}} \int_S {B_n dA} $$<br>
 
 
     $$ y = \frac{{n!}}{{k!\left( {n - k} \right)!}}p^k q^{n - k}  = \left( {\begin{array}{*{20}c}
   n  \\
   k  \\
\end{array}} \right)p^k q^{n - k} $$
 
     Bohr Radius
 
     \( a_0 = \frac{{\hbar ^2 }}{{m_e ke^2 }} \)<br>
 
     Relationship between Energy and Principal Quantum Number
 
     \( E_n = - R_H \left( {\frac{1}{{n^2 }}} \right) = \frac{{ - 2.178 \times 10^{ - 18} }}{{n^2 }}joule \)<br><br>
  
     <br><br>
   </p>




    <B>Inline Chemistry Equations</B> <br>

    <div class="card" style="font-size:4vw;">
       <div class="container">

         <p>    
     \( \ce{CO2 + C -> 2 CO} \) <br>
  
     \( \ce{Hg^2+ ->[I-] HgI2 ->[I-] [Hg^{II}I4]^2-} \) <br>
 
     \( \ce{x Na(NH4)HPO4 ->[\Delta] (NaPO3)_x + x NH3 ^ + x H2O} \) <br>
  
         </p>
       
       </div>
     </div>

   """;
