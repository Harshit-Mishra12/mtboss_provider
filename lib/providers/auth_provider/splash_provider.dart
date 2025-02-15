import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:fixit_provider/firebase/firebase_api.dart';
import 'package:fixit_provider/model/system_language_model.dart';
import 'package:fixit_provider/providers/common_providers/notification_provider.dart';

import '../../config.dart';

class SplashProvider extends ChangeNotifier {
  double size = 10;
  double roundSize = 10;
  double roundSizeWidth = 10;
  AnimationController? controller;
  Animation<double>? animation;

  AnimationController? controller2;
  Animation<double>? animation2;

  AnimationController? controller3;
  Animation<double>? animation3;

  AnimationController? controllerSlide;
  Animation<Offset>? offsetAnimation;

  AnimationController? popUpAnimationController;

  onReady(TickerProvider sync, context) async {
    bool isAvailable = await isNetworkConnection();
    if (isAvailable) {

      onChangeSize();
      getAppSettingList(context);
      CustomNotificationController().initNotification(context);
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      var apiData = prefs.getString("selectedApi");
      log("apiData:::$apiData");
      var freelancer = prefs.getBool(session.isFreelancer) ?? false;
      var login = prefs.getBool(session.isLogin) ?? false;
      bool notification = prefs.getBool(session.isNotification) ?? true;
      log("FREEELANCEERRR $freelancer");
      prefs.setBool(session.isNotification, notification);
      isLogin = login;
      isFreelancer = freelancer;
      log("LOGGIINN $login");
      notifyListeners();
      dynamic userData = prefs.getString(session.user);

      notifyListeners();
      final commonApi = Provider.of<CommonApiProvider>(context, listen: false);
      final appSet = Provider.of<AppSettingProvider>(context, listen: false);
      bool isAuthenticate = false;
      if (userData != null) {
        isAuthenticate = await commonApi.checkForAuthenticate();
      }
      log("isAuthenticate:$isAuthenticate");
      appSet.onNotification(notification, context);
      commonApi.getKnownLanguage();
      commonApi.getSubscriptionPlanList(context);
      commonApi.getDocument();
      commonApi.getCountryState();
      commonApi.getZoneList();
      commonApi.getCurrency();
      commonApi.getBlog();
      commonApi.getAllCategory();
      commonApi.getTax();
      commonApi.getBookingStatus();
      commonApi.getPaymentMethodList();

      isLogin = login;
      log("isLogin::$isLogin");
      controller =
          AnimationController(vsync: sync, duration: const Duration(seconds: 1))
            ..addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                controller!.stop();
                notifyListeners();
              }
              if (status == AnimationStatus.dismissed) {
                controller!.forward();
                notifyListeners();
              }
            });

      animation = CurvedAnimation(parent: controller!, curve: Curves.easeIn);
      controller!.forward();

      controller2 = AnimationController(
          vsync: sync, duration: const Duration(seconds: 1));
      animation2 = CurvedAnimation(parent: controller2!, curve: Curves.easeIn);

      if (controller2!.status == AnimationStatus.forward ||
          controller2!.status == AnimationStatus.completed) {
        controller2!.reverse();
        notifyListeners();
      } else if (controller2!.status == AnimationStatus.dismissed) {
        Timer(const Duration(seconds: 1), () {
          controller2!.forward();
          notifyListeners();
        });
      }

      controllerSlide = AnimationController(
          vsync: sync, duration: const Duration(seconds: 1));

      offsetAnimation =
          Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
              .animate(controllerSlide!);

      controller3 =
          AnimationController(duration: const Duration(seconds: 1), vsync: sync)
            ..repeat();
      animation3 = CurvedAnimation(parent: controller3!, curve: Curves.easeIn);

      popUpAnimationController = AnimationController(
          vsync: sync, duration: const Duration(seconds: 1));

      Timer(const Duration(seconds: 1), () {
        popUpAnimationController!.forward();
        notifyListeners();
      });

      if (userData != null) {
        final commonApi =
            Provider.of<CommonApiProvider>(context, listen: false);
        await commonApi.selfApi(context);

        final locationCtrl =
            Provider.of<LocationProvider>(context, listen: false);

        locationCtrl.getUserCurrentLocation(context);
        final userApi =
            Provider.of<UserDataApiProvider>(context, listen: false);

        userApi.homeStatisticApi();
        userApi.getCategory();
        userApi.getPopularServiceList();
        userApi.getAllServiceList();
        userApi.getJobRequest();
        userApi.getBookingHistory(context);
        if (!isFreelancer) {
          userApi.getServicemenByProviderId();
        }
        userApi.getBankDetails();

        userApi.getDocumentDetails();
        userApi.getAddressList(context);
        userApi.getNotificationList();
        if (isFreelancer || !isServiceman) {
          userApi.getServicePackageList();
        }
        final chat = Provider.of<ChatHistoryProvider>(context, listen: false);
        chat.onReady(context);

        FirebaseApi().onlineActiveStatusChange(false);
      } else {
        final locationCtrl =
            Provider.of<LocationProvider>(context, listen: false);
        locationCtrl.getUserCurrentLocation(context);
      }
      Timer(const Duration(seconds: 2), () async {
        log("IS LOGINN $appSettingModel");
        onDispose();
        Provider.of<SplashProvider>(context, listen: false).dispose();
        if (appSettingModel != null &&
            appSettingModel!.activation!.maintenanceMode == "1") {
          route.pushReplacementNamed(context, routeName.maintenanceMode);
        } else {
          if (userData != null) {
            UserModel user = UserModel.fromJson(jsonDecode(userData));
            if (isAuthenticate) {
              if (user.role!.name == "provider") {
                if (!isSubscription) {
                  route.pushReplacementNamed(
                      context, routeName.subscriptionPlan);
                } else {
                  route.pushReplacementNamed(context, routeName.dashboard);
                }
              } else {
                route.pushReplacementNamed(context, routeName.dashboard);
              }
            } else {
              final dash =
                  Provider.of<DashboardProvider>(context, listen: false);
              dash.selectIndex = 0;
              dash.notifyListeners();
              prefs.remove(session.user);
              prefs.remove(session.accessToken);
              prefs.remove(session.isLogin);
              prefs.remove(session.isFreelancer);
              prefs.remove(session.isServiceman);
              prefs.remove(session.isLogin);
              userModel = null;
              userPrimaryAddress = null;
              provider = null;
              position = null;
              statisticModel = null;
              bankDetailModel = null;
              popularServiceList = [];
              servicePackageList = [];
              providerDocumentList = [];
              notificationList = [];
              notUpdateDocumentList = [];
              addressList = [];

              route.pushReplacementNamed(context, routeName.intro);
            }
          } else {
            route.pushReplacementNamed(context, routeName.intro);
          }
        }
      });
    } else {
      onDispose();
      log("isAvailableisAvailableisAvailable:::$isAvailable");
      /* Provider.of<SplashProvider>(context, listen: false).dispose();*/
      route.pushReplacementNamed(context, routeName.noInternet);
    }
  }

  onDispose() async {
    bool isAvailable = await isNetworkConnection();
    if (isAvailable) {
      controller2!.dispose();
      controller3!.dispose();
      controller!.dispose();
      controllerSlide!.dispose();
      popUpAnimationController!.dispose();
    }
  }

  onChangeSize() {
    size = size == 10 ? 115 : 115;
    notifyListeners();
  }

  //setting list
  getAppSettingList(BuildContext context) async {
    try {
      var value = await apiServices.getApi(api.settings, [], isData: true);

      if (value.isSuccess!) {
        appSettingModel = AppSettingModel.fromJson(value.data['values']);
       // log("appSettingModel::${value.data['values']}");

        if (context.mounted) {
          onUpdate(context, appSettingModel!.general!.defaultCurrency!);
          onUpdateLanguage(context, appSettingModel!.general!.defaultLanguage!);
          log("appSettingModel!.general!.defaultLanguage::${appSettingModel!.general!.defaultLanguage!.locale}");

          notifyListeners();
        }
      }
    } catch (e) {
      log("EEEE :getAppSettingList $e");
      if (context.mounted) {
        notifyListeners();
      }
    }
  }

  onUpdate(BuildContext context, CurrencyModel data) async {
    // Retrieve the provider reference once at the start
    final currencyData = Provider.of<CurrencyProvider>(context, listen: false);

    // Use SharedPreferences
    SharedPreferences pref = await SharedPreferences.getInstance();

    // Fetch stored currency data if it exists
    double? currencyVal = pref.getDouble(session.currencyVal);
    if (currencyVal != null) {
      final prefCurrency = pref.getString(session.currency);

      currencyData.currencyVal = currencyVal;
      currencyData.currency = CurrencyModel.fromJson(jsonDecode(prefCurrency!));
      currencyData.priceSymbol = pref.getString(session.priceSymbol)!;
    } else {
      // Set data from the provided `CurrencyModel`
      currencyData.priceSymbol = data.symbol.toString();
      currencyData.currency = data;
      currencyData.currencyVal = data.exchangeRate!;
    }

    // Save updated data to SharedPreferences
    await pref.setString(session.priceSymbol, currencyData.priceSymbol);
    Map<String, dynamic> cc = await currencyData.currency!.toJson();
    await pref.setString(session.currency, jsonEncode(cc));
    await pref.setDouble(session.currencyVal, currencyData.currencyVal);

    // Notify listeners at the end to update dependent widgets
    currencyData.notifyListeners();

    log("currency(context).priceSymbol : ${currencyData.priceSymbol}");
  }

  Locale? locale;

  onUpdateLanguage(context, DefaultLanguage data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // final languageProvider =
    //     Provider.of<LanguageProvider>(context, listen: false);
    if (pref.getString("selectedLocale") == null) {
      // languageProvider.currentLanguage = data.locale!;
      await pref.setString('selectedLocale', data.locale!);
      // languageProvider.changeLocale(data.locale as SystemLanguage);
      log("messagedatadatadata::${data.locale}");
      // locale = const Locale("en");
    } else {
      log("messagedatadatadavdsfsdta::${data.locale}");
    }

    // languageProvider.notifyListeners();
  }
}
