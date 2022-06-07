import 'package:shared_preferences/shared_preferences.dart';
import 'package:vp12_api_app/models/student.dart';

enum PrefKeys {
  loggedIn, id, fullName, email, gender, token
}

class SharedPrefController {

  static final SharedPrefController _instance = SharedPrefController._();
  late SharedPreferences _sharedPreferences;

  factory SharedPrefController() {
    return _instance;
  }
  SharedPrefController._();

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required Student student}) async {
    await _sharedPreferences.setBool(PrefKeys.loggedIn.toString(), true);
    await _sharedPreferences.setInt(PrefKeys.id.toString(), student.id);
    await _sharedPreferences.setString(PrefKeys.fullName.toString(), student.fullName);
    await _sharedPreferences.setString(PrefKeys.email.toString(), student.email);
    await _sharedPreferences.setString(PrefKeys.gender.toString(), student.gender);
    await _sharedPreferences.setString(PrefKeys.token.toString(), 'Bearer ${student.token}');
  }

  bool get loggedIn => _sharedPreferences.getBool(PrefKeys.loggedIn.toString()) ?? false;

  String get token => _sharedPreferences.getString(PrefKeys.token.toString()) ?? '';

  Future<bool> clear() async => await _sharedPreferences.clear();
}