import 'package:shared_preferences/shared_preferences.dart';

class AppService {
  static const _key = 'last_opened_date';

  Future<DateTime?> loadLastOpeneddate() async {
    final prefs = await SharedPreferences.getInstance();

    final dateString = prefs.getString(_key);

    if (dateString == null) {
      return null;
    }

    return DateTime.parse(dateString);
  }

  Future<void> saveLastOpenedDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_key, date.toIso8601String());
  }
}
