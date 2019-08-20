import 'package:flutter/material.dart';


//?projeto calculadora Simples 
// Leonel da Costa | 19 de Agosto 2019


void main() => runApp(MaterialApp(

      debugShowCheckedModeBanner: false,
      title: "Minha Calculadora Simples",
      home: MyCalculadoraApp(),
      theme: ThemeData(     

          brightness: Brightness.dark,
          primaryColor: Color.fromRGBO(155, 7, 94, 1),
          accentColor: Colors.indigoAccent,

      
      ),
       )
       );

class MyCalculadoraApp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {    
    return _MyCalculadoraAppState();
  }

}




class _MyCalculadoraAppState extends State<MyCalculadoraApp> {
 
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Kwanza','Dolar','Euro'];
  final _mininumPadding = 5.0;

  //variaveis forme 
  var _currentItemSelected = '';
  var displayText = '';

  @override
  void initState(){
//! garante que o estado da combox fique sempre com o valor kwanza
    super.initState();
    _currentItemSelected = _currencies[0];
  }


  //Controler para as TextField
  TextEditingController principalController = TextEditingController();
  TextEditingController roiControleler = TextEditingController();
  TextEditingController termControler = TextEditingController(); 

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Calculadora Simples - Corydesigner"),
        //  backgroundColor: Color.fromRGBO(155, 7, 94, 1),
          ) ,
        body: Form(
          key: _formKey,
          child:Padding(
            padding:  EdgeInsets.all(_mininumPadding*2),
         // margin: EdgeInsets.all(_mininumPadding*2),
          child: ListView(                   
                children: <Widget>[


              getMyimages(), //? Widget Imagem
              getCampoPrincipal(textStyle,principalController),
              getCampoRate(textStyle,roiControleler),

              Padding( 
                padding: EdgeInsets.only(top:_mininumPadding, bottom: _mininumPadding),                
                child:Row(                
                         children: <Widget>[
                          getCampoTerm(textStyle, termControler),
                          Container(width: _mininumPadding*5), //! Truque para adicionar espaço entre os dois elementos(Expanded)
                          getCampoDropdown(_currentItemSelected),

                  ],

              )),

              Padding( 
                padding: EdgeInsets.only(top:_mininumPadding, bottom: _mininumPadding),   
                child:
                      Row(
                         children: <Widget>[
                           getBtnCalcular(),
                           Container(width: _mininumPadding*5),//! Truque para adicionar espaço entre os dois elementos(Expanded)
                           getBtnReset()
                ],


              )),
               getLabelText(textStyle),

          ],

         
        )), 


        )
      );
    
  }

  Widget getMyimages() {
    
      AssetImage assetImage = AssetImage("images/money-bag.png");

      Image image = Image(image: assetImage, width: 250.0, height: 120.0,);

      return  Container(
        // margin: EdgeInsets.fromLTRB(15, 20, 0, 5),
        margin: EdgeInsets.all(_mininumPadding*10),
        child: image,
      );

  }//end getMyimages()

  Widget getCampoPrincipal(TextStyle textStyle, TextEditingController principalControle) {
    
     return Padding( //! como adicionar padding individual
                padding: EdgeInsets.only(top: _mininumPadding, bottom: _mininumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalControle,
                  validator: (String value){

                      if(value.isEmpty){
                          return 'Please enter principal amount';
                      }

                  },
                decoration: InputDecoration(
                  hintText: 'Valor Principal',
                  labelText: 'Principal',
                  labelStyle: textStyle,
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(5.0)
                  // )
                ),
                textDirection: TextDirection.ltr,
                
              ),
              );

  }//end getCampoPrincipal


  Widget getCampoRate(TextStyle textStyle,TextEditingController roiControleler ){

    return Padding( //! como adicionar padding individual
                padding: EdgeInsets.only(top: _mininumPadding, bottom: _mininumPadding),
                child: TextFormField(
                   keyboardType: TextInputType.number,
                   style: textStyle,
                   controller: roiControleler,
                   validator: (String value){
                    
                      if(value.isEmpty){
                          return 'Please enter principal amount';
                      }

                  },
                   decoration: InputDecoration(
                   hintText: 'Valor Principal',
                   labelText: 'Rate of Interest',
                   labelStyle: textStyle,
                  //  border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(5.0)
                  // )
                ),                  
                textDirection: TextDirection.ltr,
                
              ),
              );
    
  }// getCampoRate


  Widget getCampoTerm(TextStyle textStyle, TextEditingController termControler){

    return Expanded( 
      
        child:TextFormField(
                   keyboardType: TextInputType.number,
                   style: textStyle,
                   controller: termControler,
                   validator: (String value){ //! Atributo de validação do campo
                    
                      if(value.isEmpty){
                          return 'Please enter principal amount';
                      }

                  },
                   decoration: InputDecoration(
                   hintText: 'Term',
                   labelText: 'Term in Years',
                   labelStyle: textStyle,
                  //  border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(5.0)
                  // )
                ),                  
                textDirection: TextDirection.ltr,
                
              ));

  }//end campoTerm 

  Widget getCampoDropdown(var _currentItemSelected){

    return Expanded(
      
      child:DropdownButton<String>(

          items: _currencies.map((String value){

              return DropdownMenuItem(

                  value: value,
                  child: Text(value),


              );
            }).toList(),

            value: _currentItemSelected,

            onChanged: (String newValueSelected){
              //nosso code quando mudar alguma coisa 
              _onDropDownItemSelected(newValueSelected);
            },

        ) ,
        
        );
     

  }//end Dropdown 

   Widget getBtnCalcular(){

    return Expanded( 
      
        child:RaisedButton(
          //Theme individual e com valores definido por mim
            color: Color.fromRGBO(204, 0, 153, 1),
            textColor: Colors.white,
            child: Text("Calcular",textScaleFactor: 1.5,),
            onPressed: (){
              //all actions 
              
              setState(() {
                if(_formKey.currentState.validate()){

                    this.displayText =  _calculateTotalReturns();

              }                
              });

            },


        )
        
        );

  }//end btn calcular 

  Widget getBtnReset(){

    return Expanded( 
      
        child:RaisedButton(
 //Theme individual e com valores definido por mim
          color: Color.fromRGBO(0, 0, 0, 1),
          textColor: Colors.white,
            child: Text("Reset", textScaleFactor: 1.5,),
            onPressed: (){//all actions 
                setState(() {
                  _resetForm();
                });
              
            },


        )
        
        );

  }//end btn reset 


   Widget getLabelText(TextStyle textStyle){

    return  Padding(
        padding: EdgeInsets.all(_mininumPadding*2),
        child: Text(this.displayText, style: textStyle,),

    );

  }//end btn reset 

  //Só metodos para manipulação do formulario

void _onDropDownItemSelected(String newValueselected){
  setState(() {
    this._currentItemSelected = newValueselected;
  });
}

String _calculateTotalReturns(){

    double principal = double.parse(principalController.text);
    double roi = double.parse(roiControleler.text);
    double term = double.parse(termControler.text);

    double totalAmountPayable = principal + (principal*roi*term)/100;

    String result = 'After $term years, your investiment will be worth $totalAmountPayable $_currentItemSelected';

    return result;
}

void _resetForm(){

  principalController.text = '';
  roiControleler.text = '';
  termControler.text = '';
  displayText = '';
  _currentItemSelected = _currencies[0];

}

}//FIM

// Inicios Meus Widget como componentes 


  



// class CampoTextPrincipal extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//     return Padding( //! como adicionar padding individual
//                 padding: EdgeInsets.fromLTRB(20, 5, 20,0),
//                 child: TextField(
//                   keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   hintText: 'Valor Principal',
//                   labelText: 'Principal',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5.0)
//                   )
//                 ),
//                 textDirection: TextDirection.ltr,
                
//               ),
//               );
      
    
//   }
// }

// class CampoTextRate extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//     return Padding( //! como adicionar padding individual
//                 padding: EdgeInsets.fromLTRB(20, 5, 20,0),
//                 child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Valor Principal',
//                   labelText: 'Rate of Interest'
//                 ),
//                 textDirection: TextDirection.ltr,
                
//               ),
//               );
      
    
//   }
// }

class CampoTerm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container( //! como adicionar padding individual
                width: 40.0,
                height: 50.0,
                padding: EdgeInsets.fromLTRB(20, 5, 20,0),
                child: TextField(
                decoration: InputDecoration(
                  hintText: 'Valor Principal',
                  labelText: 'Term',                  
                ),
                textDirection: TextDirection.ltr,
                
              ),
              );
      
    
  }
}



