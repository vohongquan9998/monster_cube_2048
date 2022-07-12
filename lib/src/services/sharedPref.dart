import 'package:flutter_2048_program_language/src/model/board.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSevices {
  static SharedPreferences preferences;

  static Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future setData(double scores, int skills) async {
    await preferences.setDouble("scores", scores);
    await preferences.setInt("skill", skills);
  }

  static Future getData() async {
    final data = {
      'scores': preferences.getDouble('scores') ?? 0.0,
      'skills': preferences.getInt('skills') ?? 0,
    };
    return data;
  }

  static Future resetData() async {
    await preferences.clear();
  }
}
