import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:instapro/app_constants.dart';

class StorageService extends GetxService {
  late SharedPreferences _prefs;

  // Keys for shared preferences
  static const String _keyIsPremium = 'is_premium';
  static const String _keyRemainingGridUses = 'remaining_grid_uses';
  static const String _keyRemainingCarouselUses = 'remaining_carousel_uses';
  static const String _keyFirstLaunch = 'first_launch';
  static const String _keyUserName = 'user_name';
  static const String _keyPhoneNumber = 'phone_number';
  static const String _keyIsLoggedIn = 'is_logged_in';

  // Default values
  static const int _defaultFreeGridUses = 3;
  static const int _defaultFreeCarouselUses = 3;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();

    // Initialize default values if first launch
    if (_prefs.getBool(_keyFirstLaunch) == null) {
      await _prefs.setBool(_keyFirstLaunch, false);
      await _prefs.setBool(_keyIsPremium, false);
      await _prefs.setInt(_keyRemainingGridUses, _defaultFreeGridUses);
      await _prefs.setInt(_keyRemainingCarouselUses, _defaultFreeCarouselUses);
      await _prefs.setBool(_keyIsLoggedIn, false);
    }

    return this;
  }

  // Premium status methods
  bool isPremium() {
    return _prefs.getBool(_keyIsPremium) ?? false;
  }

  Future<void> setPremiumStatus(bool isPremium) async {
    await _prefs.setBool(_keyIsPremium, isPremium);
  }

  // Grid uses methods
  int getRemainingGridUses() {
    return _prefs.getInt(_keyRemainingGridUses) ?? 0;
  }

  Future<void> setRemainingGridUses(int uses) async {
    await _prefs.setInt(_keyRemainingGridUses, uses);
  }

  Future<void> decrementGridUses() async {
    int currentUses = getRemainingGridUses();
    if (currentUses > 0) {
      await setRemainingGridUses(currentUses - 1);
    }
  }

  Future<void> resetGridUses() async {
    await setRemainingGridUses(_defaultFreeGridUses);
  }

  // Carousel uses methods
  int getRemainingCarouselUses() {
    return _prefs.getInt(_keyRemainingCarouselUses) ?? 0;
  }

  Future<void> setRemainingCarouselUses(int uses) async {
    await _prefs.setInt(_keyRemainingCarouselUses, uses);
  }

  Future<void> decrementCarouselUses() async {
    int currentUses = getRemainingCarouselUses();
    if (currentUses > 0) {
      await setRemainingCarouselUses(currentUses - 1);
    }
  }

  Future<void> resetCarouselUses() async {
    await setRemainingCarouselUses(_defaultFreeCarouselUses);
  }

  // Method to reset all usage limits (e.g., when subscription renews)
  Future<void> resetAllUsageLimits() async {
    await resetGridUses();
    await resetCarouselUses();
  }

  // Authentication methods
  String getUserName() {
    return _prefs.getString(_keyUserName) ?? '';
  }

  String getPhoneNumber() {
    return _prefs.getString(_keyPhoneNumber) ?? '';
  }

  bool isLoggedIn() {
    return _prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<void> setUserData(String name, String phone) async {
    await _prefs.setString(_keyUserName, name);
    await _prefs.setString(_keyPhoneNumber, phone);
    await _prefs.setBool(_keyIsLoggedIn, true);
  }

  Future<void> clearUserData() async {
    await _prefs.remove(_keyUserName);
    await _prefs.remove(_keyPhoneNumber);
    await _prefs.setBool(_keyIsLoggedIn, false);
  }

  // Clear all data (for testing or user logout)
  @override
  Future<void> clearAll() async {
    await _prefs.clear();
    // Reinitialize default values after clearing
    await init();
  }
}
