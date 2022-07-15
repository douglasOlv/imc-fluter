import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void _calculateIMC() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 39.9) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(onPressed: _resetFields, icon: Icon(Icons.refresh))
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
          child: Form(
            key: _formKey,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Icon(Icons.person_outline, size: 120, color: Colors.green),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Peso (Kg)',
                        labelStyle: TextStyle(color: Colors.green)),
                    controller: weightController,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'insira seu Peso!';
                      }
                    },
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25)),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Altrura (Cm)',
                      labelStyle: TextStyle(color: Colors.green)),
                  controller: heightController,
                  validator: (value){
                   if (value!.isEmpty){
                     return 'Insira sua Altura!';
                   }
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (){
                            if (_formKey.currentState!.validate()){
                              _calculateIMC();
                            }
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.green),
                          child: const Text('Calcular',
                              style:
                              TextStyle(color: Colors.white, fontSize: 25)),
                        ))),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                )
              ],
            ),
          ),
        ));
  }
}
