import 'package:flutter/material.dart';

class CheckboxController extends ChangeNotifier {
  bool isDyslexic = false;
  bool isDysgraphic = false;
  bool isDyscalculic = false;

  void setDyslexic() {
    isDyslexic = true;
    notifyListeners();
  }

  void setDysgraphic() {
    isDysgraphic = true;
    notifyListeners();
  }

  void setDyscalculic() {
    isDyscalculic = false;
    notifyListeners();
  }
}
