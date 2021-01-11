import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/Pages/splash_page.dart';
import 'package:flutter_login/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_login/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_login/bloc/authentication_bloc/authentication_bloc.dart';
import './repository/usr_repository.dart';
import './bloc/authentication_bloc/authentication_event.dart';

import './bloc/authentication_bloc/authentication_state.dart';

import 'Pages/home_page.dart';
import 'Pages/login_page.dart';
import 'bloc/authentication_bloc/authentication_bloc.dart';
import 'bloc/authentication_bloc/authentication_bloc.dart';
import 'objects/LoadingIndicato.dart';



void main() {
 // BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App(userRepository: UserRepository()));
}

class App extends StatefulWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AuthenticationBloc authenticationBloc;
  UserRepository get userRepository => widget.userRepository;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    authenticationBloc.add(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
//    authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context)=>authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(

          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            }
            if (state is AuthenticationAuthenticated) {
              return HomePage();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: userRepository);
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
          },
        ),
      ),
    );
  }
}