import 'package:cnupogo/data/database_helper.dart';
import 'package:cnupogo/models/user.dart';
import 'package:flutter/material.dart';

import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  bool _isLoading;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password;
  LoginPagePresenter _presenter;
  final dbHelper = new DatabaseHelper();
  bool _obscureText = true;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      //  rebuild widget
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    var loginButton = RaisedButton(
        onPressed: _submit, child: Text("Login"), color: Colors.red);

    // Toggles the password show status
    void _toggle() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }

    var loginForm = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Poke App Login",
          textScaleFactor: 2.0,
        ),
        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Username',
                      icon: const Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: const Icon(Icons.account_box),
                      )),
                  validator: null,
                  onSaved: (val) => _username = val,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      icon: const Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: const Icon(Icons.lock),
                      )),
                  validator: (val) =>
                      val.length < 6 ? 'Password too short.' : null,
                  onSaved: (val) => _password = val,
                  obscureText: _obscureText,
                ),
              ),
              new FlatButton(
                  onPressed: _toggle,
                  child: new Text(_obscureText ? "Show" : "Hide")),
              new FlatButton(
                  onPressed: () {
                    _navigate('/signup');
                  },
                  child: new Text('Sign Up!')),
            ],
          ),
        ),
        loginButton
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      key: scaffoldKey,
      body: Container(
        child: Center(
          child: loginForm,
        ),
      ),
    );
  }

  void _navigate(String route) {
    Navigator.of(context).pushNamed(route);
  }

  @override
  void onLoginError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    _showSnackBar(user.username + ' ' + user.password);
    setState(() {
      _isLoading = false;
    });
    var db = new DatabaseHelper();
    await db.saveUser(user);
    Navigator.of(context).pushNamed('/home');
  }
}
