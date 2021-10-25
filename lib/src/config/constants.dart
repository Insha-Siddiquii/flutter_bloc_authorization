import 'package:flutter/material.dart';
import 'package:flutter_bloc_app/gen/assets.gen.dart';

class AppContants {
  static const String appFonts = 'Poppins';

  static const List<String> onBoardingTitle = [
    'Welcome to Karwaa',
    'Explore the world with us',
    'Get started with Karwaa'
  ];
  static const List<String> onBoardingSubTitle = [
    'The real voyage of discovery consists not in seeking new landscapes, but in having new eyes',
    'Once the Travel bug bites there is no known antidote, and I know that I shall be happily infected until the end of my life.',
    'It’s not what you look at that matters. It’s what you see.'
  ];

  static List<Widget> onBoardingImg = [
    Assets.imgs.onbOne.image(),
    Assets.imgs.onbTwo.image(),
    Assets.imgs.onbThree.image(),
  ];

  static List<String> onBoardingImgPath = [
    Assets.imgs.onbOne.path,
    Assets.imgs.onbTwo.path,
    Assets.imgs.onbThree.path,
  ];
}
