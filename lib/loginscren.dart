import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/services.dart';
import 'registerform.dart';
import 'resetpass.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emcrontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();
  String _email = "";
  String _password = "";
  bool _checkBoxValue = false;
  int countE = 0;

  @override
  void initState() {
    print(_email.length);
    loadpref();
    print('Init: $_email');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressAppBar,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Image.asset(
                      'assets/images/logo2.png',
                      scale: 1.5,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Container(
                        child: Column(children: <Widget>[
                      TextField(
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Poppins-Bold",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: 'Email',
                        ),
                        controller: _emcrontroller,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextField(
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Poppins-Bold",
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          icon: Icon(Icons.security),
                          labelText: 'Password',
                        ),
                        controller: _pwcontroller,
                      ),
                    ])),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 8, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          value: _checkBoxValue,
                          onChanged: (bool newValue) {
                            setState(() {
                              _checkBoxValue = newValue;
                              saveperf(newValue);
                            });
                          },
                        ),
                        Text(
                          'Remember me',
                          style: TextStyle(fontSize: 16, letterSpacing: 0.6),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: MaterialButton(
                      child: Text(
                        'Log in',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            letterSpacing: 0.8),
                      ),
                      minWidth: 350,
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        setState(() {});
                      },
                      color: Colors.greenAccent[400],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Divider(),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetAcc()));
                          },
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontFamily: 'Georgia',
                                letterSpacing: 0.6),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Divider(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Divider(),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Don't have account? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Georgia',
                          ),
                        ),
                        GestureDetector(
                          onTap: _Register,
                          child: Text(
                            'Sign up now >',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontFamily: 'Georgia',
                                letterSpacing: 0.7),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Divider(),
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        ));
  }

  void saveperf(bool newValue) async {
    print('Inside saveperf');
    _email = _emcrontroller.text;
    _password = _pwcontroller.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (newValue) {
      if (_isEmailValid(_email) && (_password.length > 5)) {
        await prefs.setString('email', _email);
        await prefs.setString('pass', _password);
        print('Save pref $_email');
        print('Save pref $_password');

        prefs.setInt('count', countE);
        Toast.show('Preferences have been saved', context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        print('No email');
        setState(() {
          _checkBoxValue = false;
        });
        Toast.show('Check your credentials', context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    } else {
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      setState(() {
        _emcrontroller.text = '';
        _pwcontroller.text = '';
        _checkBoxValue = false;
      });
      print('Remove pref');
      Toast.show('Preferences have been removed', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  void loadpref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email'));
    _password = (prefs.getString('pass'));
    print(_email);
    print(_password);
    if (_email.length > 1) {
      _emcrontroller.text = _email;
      _pwcontroller.text = _password;
      setState(() {
        _checkBoxValue = true;
      });
    } else {
      print('No pref');
      setState(() {
        _checkBoxValue = false;
      });
    }
  }

  Future<bool> _onBackPressAppBar() async {
    SystemNavigator.pop();
    print('Backpress');
    return Future.value(false);
  }

  _Register() {
    print('Go to Registerpage');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterForm()));
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
