import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/init_load_widget.dart';

class FirstTimeWidget extends StatelessWidget {
  const FirstTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Welcome to MENUCRAFT',
              body:
                  'Discover menus, explore restaurants, and satisfy your cravings with ease! \n\nStart your culinary adventure now!',
              image: buildImage(context, "images/intro_splash/logoGif.gif"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Scan QR Codes',
              body:
                  'Scan QR codes effortlessly to access restaurant menus.\nNo need to wait or handle physical menus!\n\nSimply point, scan, and explore!',
              image: buildImage(context, "images/intro_splash/qrGif.gif"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Discover Nearby Restaurants',
              body:
                  '    Find nearby restaurants with menus available on our platform.\n Explore a variety of cuisines just around the corner. \n\nYour next delicious meal awaits!',
              image: buildImage(context, "images/intro_splash/map.gif"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Profiles and Favorites:',
              body:
                  '    Create your profile to unlock personalized features. \n Have a favorite restaurant? Click the \u{1F5A4} icon and save it forever!\n\nTailor your experience to your tastes!',
              image: buildImage(context, "images/intro_splash/heart.gif"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Get Started!',
              body: 'Ready to embark on your culinary journey?',
              image: buildImage(context, "images/intro_splash/logoGif.gif"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
          ],
          onDone: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();

            await prefs.setBool("shouldIntro", false);
            if (!context.mounted) {
              return;
            }
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoadHomeScreen()));
          },
          //ClampingScrollPhysics prevent the scroll offset from exceeding the bounds of the content.
          // scrollPhysics: const ClampingScrollPhysics(),
          showDoneButton: true,
          showNextButton: true,
          showSkipButton: true,
          skip:
              const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600)),
          next: const Icon(Icons.forward),
          done:
              const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
          dotsDecorator: getDotsDecorator()),
    );
  }

  //widget to add the image on screen
  Widget buildImage(BuildContext context, String imagePath) {
    return Center(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: ClipRect(
        clipper: MyCustomClipper(),
        child: Image.asset(
          imagePath,
          height: 800,
        ),
      ),
    ));
  }

  //method to customise the page style
  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(
        fontFamily: 'Amatic',
        color: Colors.black,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      imagePadding: EdgeInsets.only(
        top: 30,
        left: 30,
        right: 30,
      ),
      pageColor: Colors.white,
      bodyPadding: EdgeInsets.only(
        top: 8,
        left: 20,
        right: 20,
      ),
      titlePadding: EdgeInsets.only(
        top: 50,
      ),
      bodyTextStyle: TextStyle(
        color: Colors.black54,
        fontSize: 16,
        fontFamily: 'Inter',
      ),
    );
  }

  //method to customize the dots style
  DotsDecorator getDotsDecorator() {
    return const DotsDecorator(
      spacing: EdgeInsets.symmetric(horizontal: 2),
      activeColor: Colors.indigo,
      color: Colors.grey,
      activeSize: Size(12, 5),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // Remove 5 pixels from each side
    return Rect.fromLTRB(5.0, 5.0, size.width - 5.0, size.height - 2.0);
  } //TODO: ako imam vreme da go popram ova

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}
