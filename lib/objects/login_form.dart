import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/bloc/Login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/Login_bloc/login_event.dart';
import '../bloc/Login_bloc/login_state.dart';
import 'package:flutter_login/bloc/authentication_bloc/authentication_bloc.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authenticationBloc,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

 // LoginBloc get _loginBloc => widget.loginBloc;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LoginBloc, LoginState>(

      builder: (
          BuildContext context,
          LoginState state,
          ) {
        final LoginBl = BlocProvider.of<LoginBloc>(context);
        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'username'),
                controller: _usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'password'),
                controller: _passwordController,
                obscureText: true,
              ),
              RaisedButton(
                onPressed:
                state is! LoginLoading ? _onLoginButtonPressed(LoginBl) : null,
                child: Text('Login'),
              ),
              Container(
                child:
                state is LoginLoading ? CircularProgressIndicator() : null,
              ),
            ],
          ),
        );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed(Bloc LoginBloc) {
    LoginBloc.add(LoginButtonPressed(
      username: _usernameController.text,
      password: _passwordController.text,
    ));
  }
}