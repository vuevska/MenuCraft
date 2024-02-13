import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../models/providers/user_provider.dart';
import '../pages/root_page.dart';
import '../services/auth_service.dart';
import '../services/db_auth_service.dart';
import '../utils/location_services.dart';
import '../utils/toastification.dart';

class LoadHomeScreen extends StatefulWidget {
  const LoadHomeScreen({super.key});

  @override
  State<LoadHomeScreen> createState() => _LoadHomeScreenState();
}

class _LoadHomeScreenState extends State<LoadHomeScreen> {
  final bool isDebug = false; // TODO: poprajte go ova ama ce vi treba

  final DbAuthService _db = DbAuthService();
  Color currentColor = Colors.white;

  late ValueAdapter animationController = ValueAdapter(0.0, animated: true);
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();

    context.read<LocationService>().determinePosition().catchError((onError) {
      InterfaceUtils.show(context, onError.toString(),
          type: ToastificationType.error);
    }).whenComplete(() {
      if (!mounted) {
        return;
      }
      setState(() {
        currentColor = const Color.fromRGBO(16, 20, 24, 1);
        opacity = 0.0;
        animationController.value = 1.0;
      });

      if (AuthService.isUserLoggedIn()) {
        if (context.read<UserProvider>().user == null) {
          _db.getUser(AuthService.user!.uid).then((user) {
            context.read<UserProvider>().setUser(user);
          }).whenComplete(() async {
            await Future.delayed(Duration(seconds: 1));
            if (!context.mounted) {
              return;
            }

            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => const RootPage()),
                (route) {
              return false;
            });
          });
        }
      } else {
        Future.delayed(Duration(seconds: 1)).whenComplete(() {
          if (!context.mounted) {
            return;
          }

          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => const RootPage()),
              (route) {
            return false;
          }); //TODO: sigurno postoj podobar nacin
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isDebug
        ? RootPage()
        : Scaffold(
            body: FadeInUp(
              duration: const Duration(seconds: 1),
              child: AnimatedContainer(
                color: currentColor,
                curve: Curves.easeInOut,
                duration: const Duration(seconds: 1),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(seconds: 1),
                          opacity: opacity,
                          child: Image.asset(
                            "images/intro_splash/logoGif.gif",
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        const Text(
                          "MenuCraft",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                            .animate(
                              adapter: animationController,
                              autoPlay: false,
                            )
                            .tint(
                              duration: const Duration(milliseconds: 300),
                              color: Colors.white,
                            )
                            .then(
                              delay: const Duration(milliseconds: 500),
                            )
                            .fadeOut(
                                duration: const Duration(milliseconds: 500)),
                        SizedBox(height: 20),
                        AnimatedOpacity(
                          duration: const Duration(seconds: 1),
                          opacity: opacity,
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
