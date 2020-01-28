# flutter_tex_example
```dart
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

main() async {
  runApp(FlutterTeX());
}

class FlutterTeX extends StatefulWidget {
  @override
  _FlutterTeXState createState() => _FlutterTeXState();
}

class _FlutterTeXState extends State<FlutterTeX> {
  TextEditingController _teXHTMLEditingController =
      new TextEditingController(text: teXHTML);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text("Flutter TeX Example"),
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Material(
                shape: RoundedRectangleBorder(side: BorderSide()),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(labelText: "TeX HTML input"),
                    controller: _teXHTMLEditingController,
                    maxLines: 15,
                    onChanged: (string) {
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            Divider(
              height: 20,
            ),
            Text(
              "Rendered TeX HTML",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TeXView(
                    teXHTML: _teXHTMLEditingController.text,
                    loadingWidget: Center(
                      child: Text("My Custom Loading Widget"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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



```



[Complete working application Example](https://github.com/shahxadakram/flutter_tex/tree/master/example)
