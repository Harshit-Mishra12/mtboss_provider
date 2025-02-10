import 'dart:developer';

import 'package:fixit_provider/common/languages/language_helper.dart';

import '../../config.dart';

class LanguageProvider with ChangeNotifier {
  String? currentLanguage;
  String selectLanguage = appFonts.english;
  String? apiLanguage;
  Locale? locale;
  int selectedIndex = 0;
  final SharedPreferences sharedPreferences;
  bool isAdminChange = false;

  LanguageProvider(this.sharedPreferences) {
    if (sharedPreferences.getString("selectedLocale") == null) {
      var selectedApi = sharedPreferences.getString("selectedApi");
      notifyListeners();
      log("selectedApi:::fdi::$selectedApi");
      if (selectedApi != null) {
        // set language which came from storage if save any language
        locale = Locale(selectedApi);
      }
      setVal(selectedApi);
    } else {
      var selectedLocale = sharedPreferences.getString("selectedLocale");
      log("locale language :: $selectedLocale");
      var listenIndex = sharedPreferences.getInt("index");
      if (listenIndex != null) {
        selectedIndex = listenIndex;
      } else {
        selectedIndex = 0;
      }
      if (selectedLocale != null) {
        // set language which came from storage if save any language
        locale = Locale(selectedLocale);
      } else {
        // set default
        selectedLocale = "english";
        locale = const Locale("en");
      }
      setVal(selectedLocale);
    }
  }

  //
  // LanguageProvider(this.sharedPreferences) {
  //   var selectedLocale = sharedPreferences.getString("selectedLocale") ?? "en";
  //   var listenIndex = sharedPreferences.getInt("index");
  //   if (listenIndex != null) {
  //     selectedIndex = listenIndex;
  //   } else {
  //     selectedIndex = 0;
  //   }
  //   log("selectedLocaleDJISJ::$selectedLocale");
  //   if (selectedLocale != null) {
  //     locale = Locale(selectedLocale);
  //   } else {
  //     selectedLocale = "english";
  //     locale = const Locale("en");
  //   }
  //   setVal(selectedLocale);
  // }

  LanguageHelper languageHelper = LanguageHelper();

  //on language selection radio tap
  onRadioChange(index, value) {
    selectedIndex = index;
    selectLanguage = value["title"];
    sharedPreferences.setInt("index", selectedIndex);

    notifyListeners();
  }

  //change language in locale
  changeLocale(String newLocale) {
    log("sharedPreferences a1: $selectLanguage");
    Locale convertedLocale;

    currentLanguage = selectLanguage;
    log("CURRENT $currentLanguage");
    convertedLocale = languageHelper.convertLangNameToLocale(selectLanguage);

    log("convertedLocale $convertedLocale");

    locale = convertedLocale;
    log("CURRENT LOCAL ${locale!.languageCode.toString()}");
    sharedPreferences.setString(
        'selectedLocale', locale!.languageCode.toString());
    notifyListeners();
  }

  //change language from onboard
  onBoardLanguageChange(String newLocale) {
    log("sharedPreferences a1: $newLocale");
    Locale convertedLocale;

    currentLanguage = newLocale;
    log("CURRENT $currentLanguage");
    convertedLocale = languageHelper.convertLangNameToLocale(newLocale);

    locale = convertedLocale;
    log("CURRENT LOCAL $locale");
    sharedPreferences.setString(
        'selectedLocale', locale!.languageCode.toString());
    notifyListeners();
  }

  //fetch saved language from shared pref
  getLocal() {
    var selectedLocale;
    if (sharedPreferences.getString("selectedLocale") == null) {
      selectedLocale = sharedPreferences.getString("selectedApi");
    } else {
      selectedLocale = sharedPreferences.getString("selectedLocale");
    }

    return selectedLocale;
  }

  // // Update the language based on admin change
  // void updateLanguageFromAdmin(String newLanguage) {
  //   setVal(newLanguage);
  //   changeLocale(newLanguage);
  // }

  //set language value
  setVal(value) {
    log("value");
    if (value == "en") {
      currentLanguage = "english";
    } else if (value == "fr") {
      currentLanguage = "french";
    } else if (value == "es") {
      currentLanguage = "spanish";
    } else if (value == "ar") {
      currentLanguage = "arabic";
    } else {
      currentLanguage = "english";
    }
    notifyListeners();
    // changeLocale(currentLanguage);
  }
}
