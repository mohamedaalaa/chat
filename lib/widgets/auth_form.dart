import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {

  final void Function(String email, String password, String userName, bool isLogin) submitUser;

  const AuthForm({Key? key,required this.submitUser}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var isLogin = true;
  String _email = '';
  String _userName = '';
  String _password = '';
  final _formKey = GlobalKey<FormState>();

  void _trySubmit() {
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitUser(
        _email,_password,_userName,isLogin
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'please enter email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  if (!isLogin)
                    TextFormField(
                        key: const ValueKey('userName'),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 7) {
                            return 'User Name must be at length 7 chars';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userName = value!;
                        },
                        decoration:
                            const InputDecoration(labelText: 'User Name')),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'password must be at length 4 chars';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(isLogin ? 'Login' : 'Signup')),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLogin = false;
                        });
                      },
                      child: Text(isLogin
                          ? 'Create a anew account'
                          : 'I already have an account')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
