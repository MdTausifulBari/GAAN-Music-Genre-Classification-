import 'package:flutter/material.dart';
import 'package:gaan/screens/services/auth.dart';
import 'package:gaan/shared/constrains.dart';
import 'package:gaan/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Register for GAAN'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign In"),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: "Email"),
                      validator: (val) => val!.isEmpty ? 'Enter an Email': null,
                      onChanged: (val){
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: "Password"),
                      obscureText: true,
                      validator: (val) => val!.length < 6 ? 'Enter a password 6 or more charecter': null,
                      onChanged: (val){
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0,),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          setState(() => loading = true);
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                          if(result == null){
                            setState(() {
                              error = "Please recheck the information";
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
        ),
    );
  }
}
