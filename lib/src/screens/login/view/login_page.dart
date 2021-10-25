import 'package:flutter/material.dart';
import 'package:flutter_bloc_app/src/app_ui/colors.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/src/screens/login/login.dart';

class LoginCustomScreen extends StatelessWidget {
  const LoginCustomScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginCustomScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.appPrimary,
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
          );
        },
        child: LoginForm(),
      ),
    );
  }
}
