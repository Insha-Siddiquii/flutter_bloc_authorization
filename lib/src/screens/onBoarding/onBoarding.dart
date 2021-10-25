import 'package:flutter/material.dart';
import 'package:flutter_bloc_app/gen/fonts.gen.dart';
import 'package:flutter_bloc_app/src/app_ui/styles.dart';
import 'package:flutter_bloc_app/src/config/constants.dart';
import 'package:flutter_bloc_app/src/screens/login/login.dart';
import 'package:introduction_screen/introduction_screen.dart';

// import '../screens.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => OnBoarding());
  }
}

class _OnBoardingState extends State<OnBoarding> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void preLoadImgs() {
    for (int i = 0; i < AppContants.onBoardingImgPath.length; i++) {
      precacheImage(AssetImage(AppContants.onBoardingImgPath[i]), context);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    preLoadImgs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.appPrimary,
        body: IntroductionScreen(
          showDoneButton: true,
          initialPage: 0,
          globalBackgroundColor: AppColors.appPrimary,
          doneColor: AppColors.appTertiary,
          showNextButton: true,
          dotsDecorator: const DotsDecorator(
            size: const Size(10.0, 10.0),
            color: AppColors.appSecondarySubTitle,
            activeSize: const Size(22.0, 10.0),
            activeColor: AppColors.appTertiary,
            activeShape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          done: OnBoardingSideButtons(
            icon: Icons.check_circle_outline_outlined,
          ),
          pages: [
            for (int i = 0; i < 3; i++)
              PageViewModel(
                image: AppContants.onBoardingImg[i],
                titleWidget: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppContants.onBoardingTitle[i],
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: FontFamily.poppins,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                bodyWidget: Text(
                  AppContants.onBoardingSubTitle[i],
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 14, fontFamily: FontFamily.poppins, fontWeight: FontWeight.w500, color: AppColors.appSecondarySubTitle),
                ),
              )
          ],
          next: Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(
                bottom: 15,
                left: 35,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 5.0),
                    blurRadius: 8.0,
                  ),
                ],
                color: AppColors.appTertiary,
                borderRadius: BorderRadius.circular(
                  25,
                ),
              ),
              child: const Icon(
                Icons.east_outlined,
                size: 25,
                color: AppColors.appPrimary,
              )),
          onDone: () {
            print('click to login');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginCustomScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class OnBoardingSideButtons extends StatelessWidget {
  OnBoardingSideButtons({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      margin: const EdgeInsets.only(left: 15),
      child: ElevatedButton(
        onPressed: () {
          print('click to login');

          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginCustomScreen()));
        },
        child: Center(
          child: Icon(
            icon,
            size: 25,
          ),
        ),
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size(
            52,
            52,
          )),
          elevation: MaterialStateProperty.all(5),
          shape: MaterialStateProperty.all(CircleBorder()),
          backgroundColor: MaterialStateProperty.all(AppColors.appTertiary),
        ),
      ),
    );
  }
}
