import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final formulario = new GlobalKey<FormState>();
  String _user;
  String _passw;
  String _CMail;

  String name = '';
  String passw = '';
  String Ccorreo = '';

  final _Ucontr = TextEditingController();
  final _Ccont = TextEditingController();
  final _Ccor = TextEditingController();

  String Sname = '';
  String Smail = '';


  @override
  Widget build(BuildContext context) {
    setState(() {
      obtener();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text('Cuenta nueva', style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Container(
                width: 100,
                height: 100,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Form(
              key: formulario,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.supervised_user_circle,
                                size: 25,
                                color: Colors.green,
                              ),
                              onPressed: null),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 22.0, left: 22.0),
                              child: TextFormField(
                                validator: (valor) =>
                                valor.length < 1 ? 'Ingrese un nombre correcto' : null,
                                controller: _Ucontr,
                                onSaved: (valor) => _user = valor,
                                decoration:
                                InputDecoration(labelText: 'Nombre'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.screen_lock_portrait,
                                  size: 25, color: Colors.green),
                              onPressed: null),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 22.0, left: 22.0),
                              child: TextFormField(
                                controller: _Ccont,
                                validator: (valor) => valor.length < 7
                                    ? 'La contraseña debe ser mayor a siete digitos'
                                    : null,
                                onSaved: (valor) => _passw = valor,
                                decoration:
                                InputDecoration(labelText: 'Contraseña'),
                                obscureText: true,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.contact_mail,
                                  size: 30, color: Colors.green),
                              onPressed: null),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 22.0, left: 22.0),
                              child: TextFormField(
                                controller: _Ccor,
                                validator: (valor) => !valor.contains('@')
                                    ? 'Ingrese un mail correcto'
                                    : null,
                                onSaved: (valor) => _CMail = valor,
                                decoration: InputDecoration(labelText: 'Correo electronico'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: 30,
                          child: RaisedButton(
                            onPressed: () {
                              final form = formulario.currentState;
                              if (form.validate()) {
                                setState(() {
                                  name = _Ucontr.text;
                                  Ccorreo= _Ccor.text;
                                  guardar();
                                });
                                Page();
                              }
                            },

                            child: Text(
                              'Iniciar sesion',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _Login();
  }


  Future _Login() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('_sesion')) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.greenAccent,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'Bienvenido',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Este es su nuevo usuario',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('$Sname'),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('$Smail'),
              ),
              SizedBox(height: 22.0),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 40,
                    child: MaterialButton(
                      onPressed: () {
                        salir();
                      },
                      color: Colors.green,
                      child: Text(
                        'salir',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }));
    }
  }


  void Page() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('_sesion', true);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Bienvenido',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Se ingresaron estos datos:',
                style: TextStyle(fontSize: 21),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(name),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(Ccorreo),
            ),
            SizedBox(height: 22.0),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 60,
                  child: MaterialButton(
                    onPressed: () {
                      salir();
                    },
                    color: Colors.green,
                    child: Text(
                      'Salir',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }));
  }

  Future<void> salir() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('_sesion', false);
    setState(() {
      Sname = '';
      Smail = '';
    });
    Navigator.pop(context);
  }


  Future<void> obtener() async {
    SharedPreferences datos = await SharedPreferences.getInstance();
    setState(() {
      Sname = datos.get('nombre') ?? name;
      Smail = datos.get('correo') ?? Ccorreo;
    });
  }


  Future<void> guardar() async {
    SharedPreferences datos = await SharedPreferences.getInstance();
    datos.setString('nombre', _Ucontr.text);
    datos.setString('correo', _Ccor.text);
  }
}