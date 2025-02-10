import 'dart:convert';
import 'dart:developer';

import '../../config.dart';

class CommonApiProvider extends ChangeNotifier {
  //self api
  selfApi(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      await apiServices.getApi(api.self, [], isToken: true).then((value) async {
        if (value.isSuccess!) {
          userModel = UserModel.fromJson(value.data);
          notifyListeners();
          isServiceman = userModel!.role!.name == "provider" ? false : true;
          isSubscription = userModel!.activeSubscription == null ? false : true;
          activeSubscription = userModel!.activeSubscription;
          log("userModel!.type :${userModel!.type}");
          isFreelancer = userModel!.role!.name == "provider"
              ? userModel!.type == null
                  ? false
                  : userModel!.type == "company"
                      ? false
                      : true
              : false;
          pref.setBool(session.isFreelancer, isFreelancer);
          pref.setBool(session.isServiceman, isServiceman);
          notifyListeners();
          log("isServiceman :$isServiceman");
          if (isServiceman) {
            log("userModel!.providerId::${userModel!.providerId}");
            await getProviderById(context, userModel!.providerId);
          }

          pref.setString(
              session.user, json.encode(UserModel.fromJson(value.data)));
          notifyListeners();

          final userApi =
              Provider.of<UserDataApiProvider>(context, listen: false);
          userApi.getWalletList(context);
          userApi.getServicemanWalletList(context);
          userApi.statisticDetailChart();
          userApi.getTotalEarningByCategory();
          userApi.commissionHistory(false);
          userApi.getMyReview();
          log("PROVIDER :$provider");
          appArray.companyDetailList.asMap().entries.forEach((element) {
            if (element.value['title'] == appFonts.phone) {
              element.value['subtitle'] = userModel!.company != null
                  ? "${userModel!.company!.code!} ${userModel!.company!.phone!}"
                  : "${userModel!.code!} ${userModel!.phone!}";
            } else if (element.value['subtitle'] == "") {
              if (!isServiceman) {
                element.value['title'] = userModel!.company != null &&
                        userModel!.company!.primaryAddress != null
                    ? "${userModel!.company!.primaryAddress!.address} ${userModel!.company!.primaryAddress!.area}, ${userModel!.company!.primaryAddress!.state!.name} - ${userModel!.company!.primaryAddress!.postalCode}, ${userModel!.company!.primaryAddress!.country!.name}"
                    : userModel!.primaryAddress != null
                        ? "${userModel!.primaryAddress!.address} ${userModel!.primaryAddress!.area}, ${userModel!.primaryAddress!.state!.name} - ${userModel!.primaryAddress!.postalCode}, ${userModel!.primaryAddress!.country!.name}"
                        : "";
              }
            } else if (element.value['title'] == appFonts.experience) {
              debugPrint(
                  "userModel!.company :${userModel!.experienceDuration}");
              element.value['subtitle'] = userModel!.experienceDuration !=
                          null &&
                      userModel!.experienceInterval != null
                  ? "${userModel!.experienceDuration ?? "0"} ${userModel!.experienceInterval != null ? capitalizeFirstLetter(userModel!.experienceInterval) : "Years"} ${appFonts.of} ${language(context, appFonts.experience).toLowerCase()}"
                  : "0 ${language(context, appFonts.experience).toLowerCase()}";
            } else if (element.value['title'] ==
                appFonts.noOfCompletedService) {
              element.value['subtitle'] = userModel!.served ?? "0";
            }
          });
        } else {
          /*
          if(value.message.toLowerCase() == "unauthenticated."){
            final dash = Provider.of<DashboardProvider>(context, listen: false);
            dash.selectIndex = 0;
            dash.notifyListeners();
            pref.remove(session.user);
            pref.remove(session.accessToken);
            pref.remove(session.isLogin);
            pref.remove(session.isFreelancer);
            pref.remove(session.isServiceman);
            pref.remove(session.isLogin);
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
            notifyListeners();
            route.pushNamedAndRemoveUntil(context, routeName.intro);
          }*/
        }
      });
    } catch (e) {
      log("SELF :$e");
      notifyListeners();
    }
  }

  //KnownLanguage list
  getKnownLanguage({search}) async {
    try {
      String apiURL = api.language;
      if (search != null) {
        apiURL = "${api.language}?search=$search";
        log("apiURL::;$apiURL");
      } else {
        apiURL = api.language;
      }

      await apiServices.getApi(apiURL, []).then((value) {
        if (value.isSuccess!) {
          List language = value.data;
          knownLanguageList = [];
          for (var data in language) {
            knownLanguageList.add(KnownLanguageModel.fromJson(data));
            notifyListeners();
          }

          notifyListeners();
        }
      });
    } catch (e) {
      log("EEE apiURL::;$e");
      notifyListeners();
    }
  }

  //plan list
  getSubscriptionPlanList(context) async {
    try {
      await apiServices.getApi(api.subscriptionPlans, []).then((value) {
        if (value.isSuccess!) {
          List planList = value.data;
          subscriptionList = [];
          log("getSubscriptionPlanList :${planList.length}");
          for (var data in planList) {
            notifyListeners();
            SubscriptionModel subscriptionModel =
                SubscriptionModel.fromJson(data);
            List<String> benefits = [];
            for (var d in appArray.benefits) {
              if (d == "service") {
                benefits.add(appFonts.addUpToServicePlan(
                    context, subscriptionModel.maxServices.toString()));
              } else if (d == "servicemen") {
                benefits.add(appFonts.addUpToServicemanPlan(
                    context, subscriptionModel.maxServicemen.toString()));
              } else if (d == "serviceLocation") {
                benefits.add(appFonts.addUpToLocationPlan(
                    context, subscriptionModel.maxAddresses.toString()));
              } else if (d == "packages") {
                benefits.add(appFonts.addUpToServicePackagePlan(
                    context, subscriptionModel.maxServicePackages.toString()));
              }
              notifyListeners();
            }
            if (!subscriptionList.contains(subscriptionModel)) {
              subscriptionModel.benefits = benefits;
              notifyListeners();
              subscriptionList.add(subscriptionModel);
            }
            notifyListeners();
          }
          log("subscriptionList:${subscriptionList.length}");
          notifyListeners();
        }
      });
    } catch (e) {
      log("EEEE getSubscriptionPlanList :$e" );
      notifyListeners();
    }
  }

  //Document list
  getDocument() async {
    try {
      await apiServices.getApi(api.document, []).then((value) {
        if (value.isSuccess!) {
          List language = value.data;
          documentList = [];
          for (var data in language) {
            documentList.add(DocumentModel.fromJson(data));
            notifyListeners();
          }

          notifyListeners();
        }
      });
    } catch (e) {
      notifyListeners();
      log("EEEE getDocument : $e");
    }
  }

  // country state list
  getCountryState() async {
    countryStateList = [];
    notifyListeners();
    try {
      await apiServices.getApi(api.country, []).then((value) {
        if (value.isSuccess!) {
          List co = value.data;
          for (var data in value.data) {
            if (!countryStateList.contains(CountryStateModel.fromJson(data))) {
              countryStateList.add(CountryStateModel.fromJson(data));
            }
            notifyListeners();
          }

          stateList = countryStateList[0].state!;

          notifyListeners();
        }
      });
    } catch (e) {
      log("ERRROEEE getCountryState $e");
      notifyListeners();
    }
  }

  // zone list
  getZoneList() async {
    zoneList = [];
    notifyListeners();
    try {
      await apiServices.getApi(api.zone, []).then((value) {
        if (value.isSuccess!) {
          for (var data in value.data) {
            if (!zoneList.contains(ZoneModel.fromJson(data))) {
              zoneList.add(ZoneModel.fromJson(data));
            }
            notifyListeners();
          }

          notifyListeners();
        }
      });
    } catch (e) {
      log("ERRROEEE getCountryState $e");
      notifyListeners();
    }
  }

  //setting list
  getPaymentMethodList() async {
    try {
      await apiServices.getApi(api.paymentMethod, []).then((value) {
        //log("VALUE  PAYMENT:${value.data}");
        if (value.isSuccess!) {
          paymentMethods = [];
          for (var d in value.data) {
            paymentMethods.add(PaymentMethods.fromJson(d));
          }
          notifyListeners();
        }

        notifyListeners();
      });
    } catch (e) {
      log("EEEE getPaymentMethodList:$e");
      notifyListeners();
    }
  }

  //get provider detail id
  getProviderById(context, id) async {
    try {
      await apiServices
          .getApi("${api.provider}/$id", [], isData: true)
          .then((value) {
        if (value.isSuccess!) {
          provider = ProviderModel.fromJson(value.data);
          log(" getProviderById : ${provider!.id}");
          notifyListeners();
        }
      });
    } catch (e) {
      log("ERRROEEE getProviderById : $e");
      notifyListeners();
    }
  }

  //currency list
  getCurrency() async {
    try {
      await apiServices.getApi(api.currency, []).then((value) {
        log("value :R::${value.data}");
        if (value.isSuccess!) {
          currencyList = [];
          for (var data in value.data) {
            currencyList.add(CurrencyModel.fromJson(data));
            log("fbhgfvhg:${currencyList.length}");
            log("fbhgfvhgSA:${data}");
            notifyListeners();
          }
        }
      });
    } catch (e) {
      log("EEEE getCurrency::$e}");

      notifyListeners();
    }
  }

  /*//getLanguage list
  getLanguage() async {
    try {
      await apiServices.getApi(api.language, []).then((value) {
        // log("value :R$value");
        if (value.isSuccess!) {
          for (var data in value.data) {
            currencyList = [];
            currencyList.add(CurrencyModel.fromJson(data));
            notifyListeners();
          }
        }
      });
    } catch (e) {
      log("EEEE getCurrency ::$e}");

      notifyListeners();
    }
  }*/

  //blog list
  getBlog() async {
    try {
      await apiServices.getApi(api.blog, []).then((value) {
        if (value.isSuccess!) {
          List service = value.data['data'];
          blogList = [];
          for (var data in service.reversed.toList()) {
            blogList.add(BlogModel.fromJson(data));
            notifyListeners();
          }
          if (blogList.length >= 6) {
            firstTwoBlogList = blogList.getRange(0, 6).toList();
          }
          notifyListeners();
        }
      });
    } catch (e) {
      log("EEEE getBlog : $e");
      notifyListeners();
    }
  }

  //booking status list
  getBookingStatus() async {
    try {
      await apiServices
          .getApi(api.bookingStatus, [], isToken: true)
          .then((value) {
        log("VALUE :$value");
        if (value.isSuccess!) {
          bookingStatusList = [];
          for (var data in value.data) {
            bookingStatusList.add(BookingStatusModel.fromJson(data));
            notifyListeners();
          }
        }
      });
      int cancelIndex = bookingStatusList.indexWhere((element) =>
          element.slug!
                  .toLowerCase()
                  .replaceAll("-", "")
                  .replaceAll(" ", "")
                  .replaceAll("_", "") ==
              "cancel" ||
          element.slug!
                  .toLowerCase()
                  .replaceAll("-", "")
                  .replaceAll(" ", "")
                  .replaceAll("_", "") ==
              "cancelled");
      if (cancelIndex >= 0) {
        appFonts.cancel = bookingStatusList[cancelIndex].slug!;
      }
      int acceptedIndex = bookingStatusList.indexWhere((element) =>
          element.slug!
                  .toLowerCase()
                  .replaceAll("-", "")
                  .replaceAll(" ", "")
                  .replaceAll("_", "") ==
              "accepted" ||
          element.slug!
                  .toLowerCase()
                  .replaceAll("-", "")
                  .replaceAll(" ", "")
                  .replaceAll("_", "") ==
              "accept");
      if (acceptedIndex >= 0) {
        appFonts.accepted = bookingStatusList[acceptedIndex].slug!;
      }

      int assignedIndex = bookingStatusList.indexWhere((element) =>
          element.slug!
                  .toLowerCase()
                  .replaceAll("-", "")
                  .replaceAll(" ", "")
                  .replaceAll("_", "") ==
              "assign" ||
          element.slug!
                  .toLowerCase()
                  .replaceAll("-", "")
                  .replaceAll(" ", "")
                  .replaceAll("_", "") ==
              "assigned");
      if (assignedIndex >= 0) {
        appFonts.assigned = bookingStatusList[assignedIndex].slug!;
      }

      int onTheWayIndex = bookingStatusList.indexWhere((element) =>
          element.slug!
              .toLowerCase()
              .replaceAll("-", "")
              .replaceAll(" ", "")
              .replaceAll("_", "") ==
          "ontheway");
      if (onTheWayIndex >= 0) {
        appFonts.ontheway = bookingStatusList[onTheWayIndex].slug!;
      }

      int onGoingIndex = bookingStatusList.indexWhere((element) =>
          element.slug!
              .toLowerCase()
              .replaceAll("-", "")
              .replaceAll(" ", "")
              .replaceAll("_", "") ==
          "ongoing");
      if (onGoingIndex >= 0) {
        appFonts.onGoing = bookingStatusList[onGoingIndex].slug!;
      }

      int onHoldIndex = bookingStatusList.indexWhere((element) =>
          element.slug!
              .toLowerCase()
              .replaceAll("-", "")
              .replaceAll(" ", "")
              .replaceAll("_", "") ==
          "onhold");
      if (onHoldIndex >= 0) {
        appFonts.onHold = bookingStatusList[onHoldIndex].slug!;
      }

      int restartIndex = bookingStatusList.indexWhere((element) =>
          element.slug!
              .toLowerCase()
              .replaceAll("-", "")
              .replaceAll(" ", "")
              .replaceAll("_", "") ==
          "restart");
      if (restartIndex >= 0) {
        appFonts.restart = bookingStatusList[restartIndex].slug!;
      }

      int startAgainIndex = bookingStatusList.indexWhere((element) =>
          element.slug!
              .toLowerCase()
              .replaceAll("-", "")
              .replaceAll(" ", "")
              .replaceAll("_", "") ==
          "startagain");
      if (startAgainIndex >= 0) {
        appFonts.startAgain = bookingStatusList[startAgainIndex].slug!;
      }

      int completedIndex = bookingStatusList.indexWhere((element) =>
          element.slug!
                  .toLowerCase()
                  .replaceAll("-", "")
                  .replaceAll(" ", "")
                  .replaceAll("_", "") ==
              "completed" ||
          element.slug!
                  .toLowerCase()
                  .replaceAll("-", "")
                  .replaceAll(" ", "")
                  .replaceAll("_", "") ==
              "complete");
      if (completedIndex >= 0) {
        appFonts.completed = bookingStatusList[completedIndex].slug!;
      }
    } catch (e) {
      notifyListeners();
      log("EEEE getBookingStatus :$e");
    }
  }

  //all category list
  getAllCategory({search}) async {
    // notifyListeners();
    try {
      await apiServices.getApi(api.categoryList, []).then((value) {
        if (value.isSuccess!) {
          allCategoryList = [];
          List category = value.data;
          for (var data in category.reversed.toList()) {
            if (!allCategoryList.contains(CategoryModel.fromJson(data))) {
              allCategoryList.add(CategoryModel.fromJson(data));
            }
            notifyListeners();
          }
        }
      });
    } catch (e) {
      log("EEEE AllCategory:::$e");
      notifyListeners();
    }
  }

  //tax list
  getTax() async {
    // notifyListeners();
    try {
      await apiServices.getApi(api.tax, []).then((value) {
        if (value.isSuccess!) {
          taxList = [];
          List tax = value.data;
          for (var data in tax.reversed.toList()) {
            if (!taxList.contains(TaxModel.fromJson(data))) {
              taxList.add(TaxModel.fromJson(data));
            }
            notifyListeners();
          }
        }
        log("taxList :$taxList");
      });
    } catch (e) {
      log("EEEE getTax $e");
      notifyListeners();
    }
  }

  //all data is necessary in the app
  commonApi(context) {
    getBlog();
    getAllCategory();
    getPaymentMethodList();
    getBookingStatus();
    getDocument();
    getCurrency();
    getKnownLanguage();

    getTax();

    getSubscriptionPlanList(context);
  }

  Future<bool> checkForAuthenticate() async {
    bool isAuth = false;
    try {
      await apiServices
          .getApi(api.statisticCount, [], isToken: true)
          .then((value) {
        log("sdhfjsdkhf :${value.data}");
        if (value.isSuccess!) {
          isAuth = true;
          notifyListeners();
          return isAuth;
        } else {
          if (value.message.toLowerCase() == "unauthenticated.") {
            isAuth = false;
            notifyListeners();
            return isAuth;
          } else {
            isAuth = false;
            notifyListeners();
            return isAuth;
          }
        }
      });
    } catch (e) {
      log("EEE homeStatisticApi :$e");
      return isAuth;
    }
    log("isAuth:$isAuth");
    return isAuth;
  }
}
