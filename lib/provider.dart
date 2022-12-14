import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class schoolProvider extends ChangeNotifier{

  bool school = false;

  savevote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    school = prefs.getBool("school")!;
    notifyListeners();
}

}