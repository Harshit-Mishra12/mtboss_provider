import 'dart:developer';

import 'package:fixit_provider/common/languages/ar.dart';
import 'package:fixit_provider/common/languages/language_helper.dart';
import 'package:fixit_provider/model/translation_model.dart';

import '../../config.dart';
import '../../model/system_language_model.dart';

class LanguageProvider with ChangeNotifier {
  LanguageProvider(this.sharedPreferences) {
    getLanguageTranslate();
    var selectedLocale = sharedPreferences.getString("selectedLocale");

    if (selectedLocale != null) {
      locale = Locale(selectedLocale);
    } else {
      selectedLocale = "english";
      locale = const Locale("en");
    }

    setVal(selectedLocale);
    getLanguage();
  }

  String currentLanguage = appFonts.english;
  Locale? locale;
  int selectedIndex = 0;
  List<SystemLanguage> languageList = [];
  final SharedPreferences sharedPreferences;
  String? apiLanguage;
  int addSelectedIndex = 0; // Store selected index
  var selectedLocaleService = "en";

  void setSelectedIndex(int index, String locale) async {
    addSelectedIndex = index;
    selectedLocaleService = locale;
    log("Selected Language Updated: $selectedLocaleService");

    // Save selected language persistently
    await sharedPreferences.setString("selectedLocaleService", locale);

    // Notify listeners to update UI
    notifyListeners();

    // Reload service details in the new language
    final serviceProvider = Provider.of<AddNewServiceProvider>(
        navigatorKey.currentContext!,
        listen: false);
    if (serviceProvider.services != null) {
      serviceProvider.getServiceDetails(
          navigatorKey.currentContext!, serviceProvider.services!.id!);
    }
  }

/*  void setSelectedIndex(int index, String locale) async {
    addSelectedIndex = index;
    selectedLocaleService = locale;
    log("selectedLocaleService::$selectedLocaleService");

    // Save selected language persistently
    await sharedPreferences.setString("selectedLocaleService", locale);
    notifyListeners();
  }*/

  getLanguage() async {
    try {
      translations = Translation.defaultTranslations();
      await apiServices
          .getApi(api.systemLanguage, [], isToken: false)
          .then((value) {
        if (value.isSuccess!) {
          log("VALue :%${value.data}");
          for (var item in value.data) {
            SystemLanguage systemLanguage = SystemLanguage.fromJson(item);
            if (!languageList.contains(systemLanguage)) {
              languageList.add(systemLanguage);
            }
          }
        }
        notifyListeners();
      });
    } catch (e) {
      debugPrint("EEEE NOTI getBookingDetailById $e");
    }
  }

  LanguageHelper languageHelper = LanguageHelper();

  void changeLocale(SystemLanguage newLocale) {
    log("sharedPreferences a1: $newLocale");
    Locale convertedLocale;

    currentLanguage = newLocale.name!;
    convertedLocale = Locale(
        newLocale.appLocale!.split("_")[0], newLocale.appLocale!.split("_")[1]);

    locale = convertedLocale;
    sharedPreferences.setString(
        'selectedLocale', locale!.languageCode.toString());

    getLanguageTranslate();
    notifyListeners();
  }

  getLocal() {
    var selectedLocale = sharedPreferences.getString("selectedLocale");
    return selectedLocale;
  }

  //translateText api
  getLanguageTranslate() async {
    try {
      translations = Translation.defaultTranslations();
      final response = await apiServices.getApi(
          "${api.translate}/${locale!.languageCode}", [],
          isToken: false, isData: true);

      if (response.isSuccess!) {
        translations =
            Translation.fromJson(response.data); // Directly pass the map
        log("Loaded translations: ${response.data}");
        notifyListeners();
      } else {
        log('Failed to load translations, using defaults');
        translations = Translation.defaultTranslations();
      }
    } catch (e) {
      log('Error Translation: $e');
      translations = Translation.defaultTranslations();
    } finally {
      notifyListeners();
    }
  }

  // //change language from onboard
  // onBoardLanguageChange(String newLocale) {
  //   log("sharedPreferences a1: $newLocale");
  //   Locale convertedLocale;
  //
  //   currentLanguage = newLocale;
  //   log("CURRENT $currentLanguage");
  //   convertedLocale = languageHelper.convertLangNameToLocale(newLocale);
  //
  //   locale = convertedLocale;
  //   log("CURRENT LOCAL $locale");
  //   sharedPreferences.setString(
  //       'selectedLocale', locale!.languageCode.toString());
  //   notifyListeners();
  // }

  // Map<String, String> translations! = {};

  setVal(value) {
    notifyListeners();
    int index = languageList.indexWhere((element) => element.locale == value);
    if (index >= 0) {
      SystemLanguage systemLanguage = languageList[index];
      changeLocale(systemLanguage);
    }
  }

  // onRadioChange(index, value) {
  //   selectedIndex = index;

  //   sharedPreferences.setInt("index", selectedIndex);
  //
  //   notifyListeners();
  // }

  setIndex(index) {
    selectedIndex = index;
    sharedPreferences.setInt("index", selectedIndex);
    notifyListeners();
  }
}
/*
import 'dart:developer';

import 'package:fixit_provider/common/languages/language_helper.dart';

import '../../config.dart';

class LanguageProvider with ChangeNotifier {
  String? currentLanguage;
  String selectLanguage = translations!.english;
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
*/
