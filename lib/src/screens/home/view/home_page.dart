import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/src/app_ui/colors.dart';
import 'package:flutter_bloc_app/src/authentication/authentication.dart';
import 'package:flutter_bloc_app/gen/fonts.gen.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ConfettiController controllerTopCenter;

  @override
  void initState() {
    super.initState();
    setState(() {
      initController();
    });
  }

  void initController() {
    controllerTopCenter = ConfettiController(duration: const Duration(seconds: 1));

    Future.delayed(Duration.zero, () {
      controllerTopCenter.play();
    });
  }

  Align buildConfettiWidget(controller, double blastDirection) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        maximumSize: Size(30, 30),
        shouldLoop: false,
        confettiController: controller,
        blastDirection: blastDirection,
        blastDirectionality: BlastDirectionality.explosive,
        maxBlastForce: 10, // set a lower max blast force
        minBlastForce: 8, // set a lower min blast force
        emissionFrequency: 0.5,
        gravity: 1,
        numberOfParticles: 8,
        colors: [
          AppColors.appSecondarySubTitle,
          AppColors.appTertiary,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Travel with Karwaa'),
          backgroundColor: AppColors.appTertiary,
          actions: [
            IconButton(
              key: const Key('loginForm_continue_raisedButton'),
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                //controllerTopCenter.play();
                context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
              },
            )
          ],
        ),
        body: Stack(
          children: [
            buildConfettiWidget(controllerTopCenter, pi / 2),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Welcome Karwaa User',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: FontFamily.poppins,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Let\'s Travel World",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: FontFamily.poppins,
                      fontWeight: FontWeight.w600,
                      color: AppColors.appSecondarySubTitle,
                    ),
                  ),
                  // Builder(
                  //   builder: (context) {
                  //     final userId = context.select(
                  //       (AuthenticationBloc bloc) => bloc.state.user.id,
                  //     );
                  //     return Text('UserID: $userId');
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
