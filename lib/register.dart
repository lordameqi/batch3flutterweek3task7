import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController cUsername = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController cEmail = TextEditingController();

  final _formKeya = GlobalKey<FormState>();
  //deklarasi untuk masing-masing widget
  String nUsername, nPassword, nEmail;

  checkForm() {
    final form = _formKeya.currentState;
    if (form.validate()) {
      form.save();
      submitDataRegister();
    }
  }

  submitDataRegister() async {
    final responseData = await http.post(
        "http://192.168.1.6/flutterbatch3week7/inputkan.php",
        body: {"username": nUsername, "password": nPassword, "email": nEmail});

    final data = jsonDecode(responseData.body);
    int value = data['value'];
    String pesan = data['message'];

    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
    } else if (value == 2) {
      print(pesan);
    } else {
      print(pesan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REGISTER'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKeya,
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logokeren.jpg',
                    width: 380.0,
                    height: 180.0,
                    fit: BoxFit.cover,
                  ),
                  Text('REGISTER'),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: new InputDecoration(
                            hintText: "masukan Username Anda",
                            labelText: "Username",
                            icon: Icon(Icons.people),
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                          ),
                          controller: cUsername,
                          onSaved: (value) => nUsername = cUsername.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Username tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: new InputDecoration(
                            hintText: "masukan Password Anda",
                            labelText: "Password",
                            icon: Icon(Icons.build),
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                          ),
                          controller: cPassword,
                          onSaved: (value) => nPassword = cPassword.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: new InputDecoration(
                            hintText: "masukan Email Anda",
                            labelText: "Email",
                            icon: Icon(Icons.build),
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                          ),
                          controller: cEmail,
                          onSaved: (value) => nEmail = cEmail.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        RaisedButton(
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          onPressed: () {
                            if (_formKeya.currentState.validate()) {
                              setState(() {
                                checkForm();
                              });
                            }
                          },
                        ),
                        MaterialButton(
                            textColor: Colors.blueGrey,
                            child: Text('Sudah Punya Akun ? Silahkan Login'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                            })
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
