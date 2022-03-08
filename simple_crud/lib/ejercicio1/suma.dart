import 'package:flutter/material.dart';

class Suma extends StatefulWidget {
  static String tag = 'suma-page';
  @override
  _SumaPageState createState() => new _SumaPageState();
}

class _SumaPageState extends State<Suma> {
  String dropdownValue = 'Suma';
  TextEditingController numero1_ = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController numero2_ = new TextEditingController();
  double operacion = 0;
  double numero = 0;
  @override
  Widget build(BuildContext context) {
    final numero1 = TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Numero 1',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: numero1_,
    );

    final numero2 = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Numero 2',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: numero2_,
    );
    final combo = Center(
        child: DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Suma', 'Resta', 'Multiplicacion', 'Division']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ));
    final calcular = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Text(numero1_.text);
          print(numero1_.text);

          if (dropdownValue == 'Suma') {
            operacion =
                double.parse(numero1_.text) + double.parse(numero2_.text);
            print("suma");
          }
          if (dropdownValue == 'Resta') {
            operacion =
                double.parse(numero1_.text) - double.parse(numero2_.text);
            print("Resta");
          }
          if (dropdownValue == 'Multiplicacion') {
            operacion =
                double.parse(numero1_.text) * double.parse(numero2_.text);
            print("Multiplicacion");
          }
          if (dropdownValue == 'Division') {
            operacion =
                double.parse(numero1_.text) / double.parse(numero2_.text);
            print("Division");
          }

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text("Resultado"),
              content: Text("$operacion"),
              elevation: 24,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok")),
              ],
            ),
          );
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Calcular', style: TextStyle(color: Colors.white)),
      ),
    );

    final sqlite = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/home');
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('SQLITE tema 2', style: TextStyle(color: Colors.white)),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Text("Tema 1"),
            SizedBox(height: 48.0),
            numero1,
            SizedBox(height: 8.0),
            numero2,
            SizedBox(height: 24.0),
            combo,
            SizedBox(height: 24.0),
            calcular,
            SizedBox(height: 24.0),
            sqlite,
          ],
        ),
      ),
    );
  }
}
