import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService with ChangeNotifier {
  static const _kSelectedProfileKey = 'selected_profile';

  String? _selectedProfile;

  String? get selectedProfile => _selectedProfile;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedProfile = prefs.getString(_kSelectedProfileKey);
    notifyListeners();
  }

  Future<void> setProfile(String profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kSelectedProfileKey, profile);
    _selectedProfile = profile;
    notifyListeners();
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kSelectedProfileKey);
    _selectedProfile = null;
    notifyListeners();
  }
}
