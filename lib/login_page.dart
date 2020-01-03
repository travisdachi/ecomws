import 'package:ecomws/actions.dart';
import 'package:ecomws/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider_for_redux/provider_for_redux.dart';

class LoginPage extends StatefulWidget {
  static Future<bool> login(BuildContext context) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ReduxConsumer<AppState>(
      builder: (context, store, state, dispatch, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Login')),
          body: SafeArea(
            minimum: EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    enabled: !isLoading,
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: (s) {
                      if (s.isEmpty) {
                        return 'username must not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    enabled: !isLoading,
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (s) {
                      if (s.length < 8) {
                        return 'password must be at least 8 charactor';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  if (isLoading) Center(child: CircularProgressIndicator()),
                  if (!isLoading)
                    RaisedButton(
                      child: Text('Login'),
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          await store.dispatchFuture(LoginAction(emailController.text, passwordController.text));
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pop(context, true);
                        }
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
