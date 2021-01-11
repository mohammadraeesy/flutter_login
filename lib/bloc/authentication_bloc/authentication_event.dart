import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) ;
}

class AppStarted extends AuthenticationEvent {


  @override
  // TODO: implement props
  List<Object> get props => ['AppStarted'];
}

class LoggedIn extends AuthenticationEvent {
  final String token;

  LoggedIn({@required this.token}) : super([token]);


  @override
  // TODO: implement props
  List<Object> get props => ['LoggedIn { token: $token }'];
}

class LoggedOut extends AuthenticationEvent {


  @override
  // TODO: implement props
  List<Object> get props => ['LoggedOut'];
}