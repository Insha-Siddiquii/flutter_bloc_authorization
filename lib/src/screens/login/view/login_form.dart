import 'package:flutter/material.dart';
import 'package:flutter_bloc_app/src/screens/login/login.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/src/app_ui/colors.dart';
import 'package:flutter_bloc_app/gen/assets.gen.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  FocusNode _emailFocusNode = FocusNode();
  Color _emailColor = AppColors.appSecondarySubTitle;
  Color _pswdColor = AppColors.appSecondarySubTitle;

  @override
  void initState() {
    _emailFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: ListView(
        children: [
          Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Travel better with us',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.appSecondarySubTitle,
                      ),
                    ),
                    Text(
                      'Join now',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.appTertiary),
                    ),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 400, minHeight: 400),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Assets.imgs.loginImg.image(),
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 35,
                    right: 35,
                    top: 45,
                    bottom: 10,
                  ),
                  child: Focus(
                    onFocusChange: (focusChange) {
                      setState(
                        () {
                          _emailColor = focusChange ? AppColors.appTertiary : AppColors.appSecondarySubTitle;
                        },
                      );
                    },
                    child: UserEmailInput(
                      emailFocusNode: _emailFocusNode,
                      emailColor: _emailColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 35,
                    right: 35,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Focus(
                    onFocusChange: (focusChange) {
                      setState(
                        () {
                          _pswdColor = focusChange ? AppColors.appTertiary : AppColors.appSecondarySubTitle;
                        },
                      );
                    },
                    child: UserPasswordInput(pswdColor: _pswdColor),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                LoginButton()
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  _triggerFieldValidation(
    LoginState state,
    BuildContext context,
  ) {
    context.read<LoginBloc>().add(LoginPasswordChanged(state.password.value));
    context.read<LoginBloc>().add(LoginUsernameChanged(state.username.value));

    if (state.password.invalid || state.username.invalid) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Please enter login information'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator(
                color: AppColors.appSecondarySubTitle,
              )
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : () {
                        _triggerFieldValidation(
                          state,
                          context,
                        );
                      },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.appTertiary,
                  ),
                  fixedSize: MaterialStateProperty.all(
                    Size(300, 40),
                  ),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                child: Text('Log In'),
              );
      },
    );
  }
}

class UserPasswordInput extends StatelessWidget {
  const UserPasswordInput({
    Key? key,
    required Color pswdColor,
  })  : _pswdColor = pswdColor,
        super(key: key);

  final Color _pswdColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          keyboardType: TextInputType.text,
          cursorWidth: 1,
          style: TextStyle(
            color: AppColors.appSecondarySubTitle,
            fontSize: 13,
          ),
          onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          cursorColor: AppColors.appTertiary,
          decoration: new InputDecoration(
            errorText: state.password.invalid ? 'invalid password' : null,
            focusColor: AppColors.appTertiary,
            focusedBorder: new OutlineInputBorder(
              borderSide: new BorderSide(
                color: AppColors.appTertiary,
              ),
            ),
            labelText: 'Password',
            labelStyle: TextStyle(
              color: _pswdColor,
              fontSize: 13,
            ),
            border: new OutlineInputBorder(
              borderSide: new BorderSide(
                color: AppColors.appSecondarySubTitle,
              ),
            ),
          ),
        );
      },
    );
  }
}

class UserEmailInput extends StatelessWidget {
  const UserEmailInput({
    Key? key,
    required FocusNode emailFocusNode,
    required Color emailColor,
  })  : _emailFocusNode = emailFocusNode,
        _emailColor = emailColor,
        super(key: key);

  final FocusNode _emailFocusNode;
  final Color _emailColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          cursorWidth: 1,
          style: TextStyle(
            color: AppColors.appSecondarySubTitle,
            fontSize: 13,
          ),
          keyboardType: TextInputType.emailAddress,
          focusNode: _emailFocusNode,
          cursorColor: AppColors.appTertiary,
          decoration: new InputDecoration(
            focusColor: AppColors.appTertiary,
            focusedBorder: new OutlineInputBorder(
              borderSide: new BorderSide(
                color: AppColors.appTertiary,
              ),
            ),
            labelText: 'Email',
            labelStyle: TextStyle(
              color: _emailColor,
              fontSize: 13,
            ),
            border: new OutlineInputBorder(
              borderSide: new BorderSide(
                color: AppColors.appSecondarySubTitle,
              ),
            ),
            errorText: state.username.invalid ? 'Invalid Email' : null,
          ),
          onChanged: (username) => context.read<LoginBloc>().add(LoginUsernameChanged(username)),
        );
      },
    );
  }
}
