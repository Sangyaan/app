import 'package:app/contants/letter_a.dart';
import 'package:app/contants/letter_b.dart';
import 'package:app/contants/letter_ka.dart';
import 'package:app/contants/letter_ta.dart';
import 'package:app/contants/letter_ya.dart';
import 'package:app/contants/number_4.dart';
import 'package:app/contants/number_5.dart';
import 'package:app/contants/number_6.dart';
import 'package:app/contants/number_dui.dart';
import 'package:app/contants/number_ek.dart';
import 'package:app/contants/letter_y.dart';
import 'package:app/contants/number_tin.dart';
import 'package:app/screens/dyscalculic/controllers/numberbasedcontroller.dart';
import 'package:app/screens/dyscalculic/controllers/wordbasedcontroller.dart';
import 'package:app/screens/dyscalculic/dyscalculic.dart';
import 'package:app/screens/dyscalculic/game/game/game.dart';
import 'package:app/screens/dyscalculic/game/screen/gameplay.dart';
import 'package:app/screens/dyscalculic/game/screen/main_menu.dart';
import 'package:app/screens/dyscalculic/numberbased.dart';
import 'package:app/screens/dyscalculic/wordbased.dart';
import 'package:app/screens/dysgraphic/controllers/drawing_controller_english_alphabets.dart';

import 'package:app/screens/dysgraphic/controllers/drawing_controller_english_numbers.dart';
import 'package:app/screens/dysgraphic/controllers/drawing_controller_nepali_letters.dart';
import 'package:app/screens/dysgraphic/controllers/drawing_controller_nepali_numbersdart';
import 'package:app/screens/dysgraphic/dysgraphic.dart';
import 'package:app/screens/dysgraphic/widgets/drawing_screen_english_alphabet.dart';

import 'package:app/screens/dysgraphic/widgets/drawing_screen_english_number.dart';
import 'package:app/screens/dysgraphic/widgets/drawing_screen_nepali_letters.dart';
import 'package:app/screens/dysgraphic/widgets/drawing_screen_nepali_numbers.dart';
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
        ChangeNotifierProvider(create: (_) => NumberBasedProvider()),
        ChangeNotifierProvider(
            create: (_) => DrawingControllerNepaliLetters(letter_ya)),
        ChangeNotifierProvider(
            create: (_) => DrawingControllerEnglishNumbers(number_4)),
        ChangeNotifierProvider(
            create: (_) => DrawingControllerEnglishAlphabet(letter_a)),
        ChangeNotifierProvider(
            create: (_) => DrawingControllerNepaliNumbers(number_tin))
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/dysgraphic",
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
            "/game": (context) => MathemagicaGame(),
            "/drawing_screen_english_numbers": (context) =>
                DrawingScreenEnglishNumbers(),
            "/drawing_screen_english_alphabets": (context) =>
                DrawingScreenEnglishAlphabets(),
            "/drawing_screen_nepali_numbers": (context) =>
                DrawingScreenNepaliNumbers(),
            "/drawing_screen_nepali_letters": (context) =>
                DrawingScreenNepaliLetters()
          }),
    );
  }
}
