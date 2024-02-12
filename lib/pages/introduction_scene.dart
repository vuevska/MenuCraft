import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:menu_craft/pages/root_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              body: 'Discover menus, explore restaurants, and satisfy your cravings with ease! \n\nStart your culinary adventure now!',
              image: buildImage("images/image_1.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Scan QR Codes',
              body: 'Scan QR codes effortlessly to access restaurant menus.\nNo need to wait or handle physical menus!\n\nSimply point, scan, and explore!',
              image: buildImage("images/image_2.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Discover Nearby Restaurants',
              body: '    Find nearby restaurants with menus available on our platform.\n Explore a variety of cuisines just around the corner. \n\nYour next delicious meal awaits!',
              image: buildImage("images/image_3.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Profiles and Favorites:',
              body: '    Create your profile to unlock personalized features. \n Have a favorite restaurant? Click the \u{1F5A4} icon and save it forever!\n\nTailor your experience to your tastes!',
              image: buildImage("images/image_3.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Get Started!',
              body: 'Ready to embark on your culinary journey?',
              image: buildImage("images/image_3.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
          ],
          onDone: () async {
            print("done");
            final SharedPreferences prefs = await SharedPreferences.getInstance();

            await prefs.setBool("intro", false);
            if(!context.mounted){
              return;
            }
            Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const RootPage()));
          },
          //ClampingScrollPhysics prevent the scroll offset from exceeding the bounds of the content.
          scrollPhysics: const ClampingScrollPhysics(),
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
  Widget buildImage(String imagePath) {
    return Center(
        child: Image.asset(
          imagePath,
          width: 450,
          height: 200,
        ));
  }

  //method to customise the page style
  PageDecoration getPageDecoration() {
    return const PageDecoration(
      imagePadding: EdgeInsets.only(top: 120),
      pageColor: Colors.white,
      bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
      titlePadding: EdgeInsets.only(top: 50),
      bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
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