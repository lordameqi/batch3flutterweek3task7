import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:animated_splash/animated_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimatedSplash(
        imagePath: 'assets/images/logokeren.jpg',
        home: MyHomePage(),
        duration: 2500,
        type: AnimatedSplashType.StaticDuration,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum statusLogin { signIn, notSignIn }

class _MyHomePageState extends State<MyHomePage> {
  statusLogin _loginStatus = statusLogin.notSignIn;
  final _formKey = GlobalKey<FormState>();
  String nUsername, nPassword;

  checkForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      submitDataLogin();
    }
  }

  submitDataLogin() async {
    final responseData = await http
        .post("http://192.168.1.6/flutterbatch3week7/loginkan.php", body: {
      "username": nUsername,
      "password": nPassword,
    });
    final data = jsonDecode(responseData.body);
    int value = data['value'];
    String pesan = data['message'];
    //ambil respom
    String dataUsername = data['username'];
    String dataEmail = data['email'];
    String dataIdUser = data['id_user'];

    if (value == 1) {
      setState(() {
        _loginStatus = statusLogin.signIn;
        //simpan data ke share preferene
        saveDataPref(value, dataIdUser, dataUsername, dataEmail);
      });
    } else if (value == 2) {
      print(pesan);
    } else {
      print(pesan);
    }
  }

  saveDataPref(int value, String dIdUser, dUsername, dEmail) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("value", value);
      sharedPreferences.setString("id_user", dIdUser);
      sharedPreferences.setString("username", dUsername);

      sharedPreferences.setString("email", dEmail);

      sharedPreferences.commit();
    });
  }

  var nvalue;
  //method untuk mengecek user sudah login atau tidak
  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      nvalue = sharedPreferences.getInt("value");
      _loginStatus = nvalue == 1 ? statusLogin.signIn : statusLogin.notSignIn;
    });
  }

  //method logout
  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("value", null);

      sharedPreferences.commit();
      _loginStatus = statusLogin.notSignIn;
    });
  }

  @override
  void initState() {
    getDataPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case statusLogin.notSignIn:
        return Scaffold(
          appBar: AppBar(
            title: Text('LOGIN'),
            centerTitle: true,
          ),
          body: Form(
            key: _formKey,
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
                      Text('LOGIN'),
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
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                              ),
                              onSaved: (value) => nUsername = value,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Username tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              obscureText: true,
                              onSaved: (value) => nPassword = value,
                              decoration: new InputDecoration(
                                hintText: "masukan Password Anda",
                                labelText: "Password",
                                icon: Icon(Icons.build),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Password tidak boleh kosong';
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
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    checkForm();
                                  });
                                }
                              },
                            ),
                            RaisedButton(
                              child: Text(
                                "Register",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()));
                              },
                            ),
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
        break;
      case statusLogin.signIn:
        return MainMenu(signOut);
        break;
    }
  }
}

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;
  MainMenu(this.signOut);
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool searching, error;
  var data;
  String query;
  String dataurl = "http://192.168.1.6/flutterbatch3week7/getkamus.php";
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

//  String email = "", nama = "";
//  TabController tabController;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
//      email = preferences.getString("email");
//      nama = preferences.getString("nama");
    });
  }

  @override
  void initState() {
    searching = false;
    error = false;
    query = "";
    super.initState();
    getPref();
  }

  void getSuggestion() async {
    //get suggestion function
    var res = await http.post(dataurl + "?query=" + Uri.encodeComponent(query));
    //in query there might be unwant character so, we encode the query to url
    if (res.statusCode == 200) {
      setState(() {
        data = json.decode(res.body);
        //update data value and UI
      });
    } else {
      //there is error
      setState(() {
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            leading: searching
                ? IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        searching = false;
                        //set not searching on back button press
                      });
                    },
                  )
                : Icon(Icons.play_arrow),
            title: searching
                ? searchField()
                : Text("Kamus Kesehatan(tekan disini)"),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      searching = true;
                    });
                  }),
              IconButton(
                onPressed: () {
                  signOut();
                },
                icon: Icon(Icons.lock_open),
              )
            ],
            backgroundColor: searching ? Colors.orange : Colors.deepOrange,
          ),
          body: SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                child: data == null
                    ? Container(
                        padding: EdgeInsets.all(20),
                        child: searching
                            ? Text("Please wait")
                            : Text("Cari SIngkatan lain")
                        //if is searching then show "Please wait"
                        //else show search peopels text
                        )
                    : Container(
                        child: searching
                            ? showSearchSuggestions()
                            : Text("Temukan Singkatan lain"),
                      )),
          ),
        ));
  }

  Widget showSearchSuggestions() {
    List<SearchSuggestion> suggestionlist =
        List<SearchSuggestion>.from(data["data"].map((i) {
      return SearchSuggestion.fromJSON(i);
    }));
    //serilizing json data inside model list.
    return Column(
      children: suggestionlist.map((suggestion) {
        return InkResponse(
            onTap: () {
              //when tapped on suggestion
              print(suggestion.id); //pint student id
            },
            child: SizedBox(
                width: double.infinity, //make 100% width
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      suggestion.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )));
      }).toList(),
    );
  }

  Widget searchField() {
    //search input field
    return Container(
        child: TextField(
      autofocus: true,
      style: TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.white, fontSize: 18),
        hintText: "Cari Singkatan",
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ), //under line border, set OutlineInputBorder() for all side border
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ), // focused border color
      ), //decoration for search input field
      onChanged: (value) {
        query = value; //update the value of query
        getSuggestion(); //start to get suggestion
      },
    ));
  }
}

class SearchSuggestion {
  String id, name;
  SearchSuggestion({this.id, this.name});

  factory SearchSuggestion.fromJSON(Map<String, dynamic> json) {
    return SearchSuggestion(
      id: json["id_kamus"],
      name: json["singkatan"],
    );
  }
}
