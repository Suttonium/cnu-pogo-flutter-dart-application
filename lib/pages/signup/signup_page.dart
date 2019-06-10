import 'package:cnupogo/data/database_helper.dart';
import 'package:cnupogo/models/user.dart';
import 'package:cnupogo/pages/signup/signup_presenter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpPage extends StatefulWidget {
  @override
  State createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin
    implements SignUpPageContract {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password;
  SignUpPagePresenter _presenter;
  final dbHelper = new DatabaseHelper();
  bool _obscureText = true;

  _SignUpPageState() {
    _presenter = new SignUpPagePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  void _submit(String username, String password) {
    final form = formKey.currentState;

    if (form.validate()) {
      //  rebuild widget
      setState(() {
        form.save();
        _presenter.doSignUp(_username, _password);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: new Stack(fit: StackFit.expand, children: <Widget>[
        new Image(
          image: new AssetImage("assets/Pokeball.jpg"),
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.darken,
          color: Colors.black87,
        ),
        new Theme(
          data: new ThemeData(
              brightness: Brightness.dark,
              inputDecorationTheme: new InputDecorationTheme(
                // hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
                labelStyle:
                    new TextStyle(color: Colors.white70, fontSize: 25.0),
              )),
          isMaterialAppTheme: true,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.all(40.0),
                child: new Form(
                  key: formKey,
                  autovalidate: true,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Username',
                            icon: const Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: const Icon(Icons.account_box),
                            )),
                        keyboardType: TextInputType.text,
                        onSaved: (val) => _username = val,
                      ),
                      new TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            icon: const Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: const Icon(Icons.lock),
                            )),
                        obscureText: _obscureText,
                        keyboardType: TextInputType.text,
                        onSaved: (val) => _password = val,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                      ),
                      new FlatButton(
                          onPressed: _toggle,
                          child: new Text(_obscureText ? "Show" : "Hide")),
                      new MaterialButton(
                        height: 50.0,
                        minWidth: 150.0,
                        color: Colors.yellow,
                        splashColor: Colors.yellowAccent,
                        textColor: Colors.black,
                        child: new Icon(FontAwesomeIcons.signInAlt),
                        onPressed: () {
                          _submit(_username, _password);
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void onSignUpError(String error) {
    // TODO: implement onSignUpError
  }

  @override
  void onSignUpSuccess(User user) async {
    var db = new DatabaseHelper();
    await db.saveUser(user);
    Navigator.of(context).pushNamed('/login');
  }
}
