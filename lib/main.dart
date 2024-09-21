import 'package:app/screens/dyscalculic/dyscalculic.dart';
import 'package:app/screens/dysgraphic/dysgraphic.dart';
import 'package:app/screens/dyslexic/dyslexic.dart';
import 'package:app/screens/home/controllers/dashboard.dart';
import 'package:app/screens/home/home.dart';
import 'package:app/screens/signup/controllers/email_controller.dart';
import 'package:app/screens/signup/controllers/password_controller.dart';
import 'package:app/screens/signup/signup.dart';
import 'package:app/screens/test/controllers/question_controller.dart';
import 'package:app/screens/test/score_page.dart';
import 'package:app/screens/test/take_test.dart';
import 'package:app/screens/test/test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(const Sangyaan());
}

class Sangyaan extends StatelessWidget {
  const Sangyaan({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmailController()),
        ChangeNotifierProvider(create: (_) => PasswordController()),
        ChangeNotifierProvider(create: (_) => QuestionProvider()),
        ChangeNotifierProvider(create: (_) => DashboardController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/signup",
        routes: {
          '/signup': (context) => const SignUpPage(),
          "/taketest": (context) => const TakeTestPage(),
          "/test": (context) => TestPage(),
          "/score": (context) => const ScorePage(),
          "/home": (context) => const HomePage(),
          "/dyslexic": (context) => const DyslexicPage(),
          "/dysgraphic": (context) => const DysgraphicPage(),
          "/dyscalculic": (context) => const DyscalculicPage(),
        },
      ),
    );
  }
}
