import 'dart:convert';

import 'package:demo_digitalin/src/view/screen/login.dart';

import '../widget/dialogs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageRegister extends StatefulWidget {
  const PageRegister({Key? key}) : super(key: key);

  @override
  _PageRegisterState createState() => _PageRegisterState();
}

class HeadClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _PageRegisterState extends State<PageRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var txtNama = TextEditingController();
  var txtEditEmail = TextEditingController();
  var txtEditPwd = TextEditingController();
  var txtUmur = TextEditingController();


  Widget inputNama() {
    return TextFormField(
        cursorColor: Colors.white,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        controller: txtNama,
        onSaved: (String? val) {
          txtNama.text = val!;
        },
        decoration: InputDecoration(
          hintText: 'Masukkan Nama',
          hintStyle: const TextStyle(color: Colors.white),
          labelText: "Masukkan Nama",
          labelStyle: const TextStyle(color: Colors.white),
          prefixIcon: const Icon(
            Icons.supervised_user_circle_outlined,
            color: Colors.white,
          ),
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
        style: const TextStyle(fontSize: 16.0, color: Colors.white));
  }



  Widget inputEmail() {
    return TextFormField(
        cursorColor: Colors.white,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        validator: (email) => email != null && !EmailValidator.validate(email)
            ? 'Masukkan email yang valid'
            : null,
        controller: txtEditEmail,
        onSaved: (String? val) {
          txtEditEmail.text = val!;
        },
        decoration: InputDecoration(
          hintText: 'Masukkan Email',
          hintStyle: const TextStyle(color: Colors.white),
          labelText: "Masukkan Email",
          labelStyle: const TextStyle(color: Colors.white),
          prefixIcon: const Icon(
            Icons.email_outlined,
            color: Colors.white,
          ),
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
        style: const TextStyle(fontSize: 16.0, color: Colors.white));
  }


  Widget inputPassword() {
    return TextFormField(
      cursorColor: Colors.white,
      keyboardType: TextInputType.text,
      autofocus: false,
      obscureText: true, //make decript inputan
      validator: (String? arg) {
        if (arg == null || arg.isEmpty) {
          return 'Password harus diisi';
        } else {
          return null;
        }
      },
      controller: txtEditPwd,
      onSaved: (String? val) {
        txtEditPwd.text = val!;
      },
      decoration: InputDecoration(
        hintText: 'Masukkan Password',
        hintStyle: const TextStyle(color: Colors.white),
        labelText: "Masukkan Password",
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: Colors.white,
        ),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
      style: const TextStyle(fontSize: 16.0, color: Colors.white),
    );
  }

  Widget inputUmur() {
    return TextFormField(
        cursorColor: Colors.white,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        controller: txtUmur,
        onSaved: (String? val) {
          txtNama.text = val!;
        },
        decoration: InputDecoration(
          hintText: 'Masukkan Umur',
          hintStyle: const TextStyle(color: Colors.white),
          labelText: "Masukkan Umur",
          labelStyle: const TextStyle(color: Colors.white),
          prefixIcon: const Icon(
            Icons.man_outlined,
            color: Colors.white,
          ),
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
        style: const TextStyle(fontSize: 16.0, color: Colors.white));
  }

  void _validateInputs() {
    if (_formKey.currentState!.validate()) {
      //If all data are correct then save data to out variables
      _formKey.currentState!.save();
      doRegister(txtNama.text, txtEditEmail.text, txtEditPwd.text, txtUmur.text);
    }
  }

  doRegister(nama, email, password, umur) async {
    final GlobalKey<State> _keyLoader = GlobalKey<State>();
    Dialogs.loading(context, _keyLoader, "Proses ...");

    try {
      final response = await http.post(
          Uri.parse("https://mental-meds.up.railway.app/api/register"),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            "nama": nama,
            "email": email,
            "password": password,
            "umur": umur
          }));

      final output = jsonDecode(response.body);
      if (response.statusCode == 201) {
        print(response.body);
        Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PageLogin()),
              );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            output['message'],
            style: const TextStyle(fontSize: 16),
          )),
        );

         
      }
    } catch (e) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: false).pop();
      Dialogs.popUp(context, '$e');
      debugPrint('$e');
    }
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        margin: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blueAccent, Color.fromARGB(255, 21, 236, 229)],
        )),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ClipPath(
                clipper: HeadClipper(),
                child: Container(
                  margin: const EdgeInsets.all(0),
                  width: double.infinity,
                  height: 180,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo-white-sm.png'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text(
                  "Register APP",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      inputNama(),
                      const SizedBox(height: 5.0),
                      inputEmail(),
                      const SizedBox(height: 5.0),
                      inputPassword(),
                      const SizedBox(height: 5.0),
                      inputUmur(),
                      const SizedBox(height: 5.0),

                    ],
                  )),
              Container(
                padding:
                    const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: const BorderSide(color: Colors.blue),
                        ),
                        elevation: 10,
                        minimumSize: const Size(200, 58)),
                    onPressed: () => _validateInputs(),
                    icon: const Icon(Icons.arrow_right_alt),
                    label: const Text(
                      "Register",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}