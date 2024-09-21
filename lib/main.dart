import 'package:app/screens/dyscalculic/controllers/numberbasedcontroller.dart';
import 'package:app/screens/dyscalculic/controllers/wordbasedcontroller.dart';
import 'package:app/screens/dyscalculic/dyscalculic.dart';
import 'package:app/screens/dyscalculic/game/game/game.dart';
import 'package:app/screens/dyscalculic/game/screen/gameplay.dart';
import 'package:app/screens/dyscalculic/game/screen/main_menu.dart';
import 'package:app/screens/dyscalculic/numberbased.dart';
import 'package:app/screens/dyscalculic/wordbased.dart';
import 'package:app/screens/dysgraphic/dysgraphic.dart';
import 'package:app/screens/dyslexic/dyslexic.dart';
import 'package:app/screens/home/controllers/dashboard.dart';
import 'package:app/screens/home/home.dart';
import 'package:app/screens/signup/controllers/email_controller.dart';
import 'package:app/screens/signup/controllers/password_controller.dart';
import 'package:app/screens/signup/signup.dart';
import 'package:app/screens/test/controllers/question_controller.dart';
import 'package:app/screens/test/test_score_page.dart';
import 'package:app/screens/test/take_test.dart';
import 'package:app/screens/test/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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
        ChangeNotifierProvider(create: (_) => DashboardController()),
        ChangeNotifierProvider(create: (_) => WordBasedProvider()),
        ChangeNotifierProvider(create: (_) => NumberBasedProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/signup",
          routes: {
            '/signup': (context) => const SignUpPage(),
            "/taketest": (context) => const TakeTestPage(),
            "/test": (context) => TestPage(),
            "/score": (context) => const TestScorePage(),
            "/home": (context) => const HomePage(),
            "/dyslexic": (context) => const DyslexicPage(),
            "/dysgraphic": (context) => const DysgraphicPage(),
            "/dyscalculic": (context) => const DyscalculicPage(),
            "/wordbased": (context) => WordBasedQuiz(),
            "/numberbased": (context) => NumberBasedQuiz(),
            "/mainMenu": (context) => MainMenu(),
            "/game": (context) => MathemagicaGame()
          }),
    );
  }
}
