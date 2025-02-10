import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:fixit_provider/common/languages/ar.dart';
import 'package:fixit_provider/config.dart';
import 'package:fixit_provider/model/index.dart';
import 'package:fixit_provider/screens/auth_screens/current_location_screen/layouts/google.dart';
import 'package:fixit_provider/screens/auth_screens/sign_up_company_screen/layouts/zone_list_sheet.dart';
import 'package:fixit_provider/services/user_services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import '../../firebase/firebase_api.dart';

class SignUpCompanyProvider with ChangeNotifier {
  GlobalKey<FormState> signupFormKey1 = GlobalKey<FormState>();
  GlobalKey<FormState> signupFormKey2 = GlobalKey<FormState>();
  GlobalKey<FormState> signupFormKey3 = GlobalKey<FormState>();
  GlobalKey<FormState> signupFreelanceFormKey1 = GlobalKey<FormState>();
  GlobalKey<FormState> signupFreelanceFormKey2 = GlobalKey<FormState>();
  double slider = 0.0;
  String dialCode = "+91";
  String providerDialCode = "+91";
  List<ValueItem<int>> languageSelect = [];
  List<ZoneModel> zoneSelect = [];
  String? chosenValue;
  List<CountryStateModel> countryList = [];
  List<ZoneModel> zonesList = [];
  List<StateModel> statesList = [];
  int countryValue = -1, stateValue = -1;
  bool isNewPassword = true, isConfirmPassword = true;

  //String? identityValue;
  int pageIndex = 0;
  int fPageIndex = 0;
  CountryModel? countryCompany, countryProvider, stateCompany, stateProvider;
  CountryStateModel? country;
  ZoneModel? zone;
  StateModel? state;

  ScrollController controller = ScrollController();

  TextEditingController companyName = TextEditingController();
  TextEditingController companyPhone = TextEditingController();
  TextEditingController companyMail = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController identityNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController reEnterPassword = TextEditingController();

  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipCode = TextEditingController();

  TextEditingController countryCtrl = TextEditingController();
  TextEditingController zoneCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();

  TextEditingController ownerName = TextEditingController();
  TextEditingController providerEmail = TextEditingController();
  TextEditingController providerNumber = TextEditingController();

  final FocusNode companyNameFocus = FocusNode();
  final FocusNode phoneNameFocus = FocusNode();
  final FocusNode companyMailFocus = FocusNode();
  final FocusNode experienceFocus = FocusNode();
  final FocusNode descriptionFocus = FocusNode();
  final FocusNode providerNumberFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode langFocus = FocusNode();

  final FocusNode identityNumberFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode reEnterPasswordFocus = FocusNode();

  TextEditingController filterSearchCtrl = TextEditingController();
  final FocusNode filterSearchFocus = FocusNode();

  FocusNode latFocus = FocusNode();
  FocusNode longFocus = FocusNode();
  FocusNode areaFocus = FocusNode();
  FocusNode streetFocus = FocusNode();
  FocusNode cityFocus = FocusNode();
  FocusNode zipcodeFocus = FocusNode();
  FocusNode stateFocus = FocusNode();
  FocusNode countryFocus = FocusNode();

  dynamic areaData;

  FocusNode ownerNameFocus = FocusNode();
  FocusNode providerPhoneNumberFocus = FocusNode();
  FocusNode providerEmailFocus = FocusNode();

  String? documentModel;
  XFile? imageFile, docFile;

  //new password see tap
  newPasswordSeenTap() {
    isNewPassword = !isNewPassword;
    notifyListeners();
  }

  //confirm password see tap
  confirmPasswordSeenTap() {
    isConfirmPassword = !isConfirmPassword;
    notifyListeners();
  }

  // GET IMAGE FROM GALLERY
  Future getImage(context, source, {isLogo = true}) async {
    final ImagePicker picker = ImagePicker();
    XFile image = (await picker.pickImage(source: source, imageQuality: 70))!;
    route.pop(context);
    if (isLogo) {
      imageFile = image;
    } else {
      docFile = image;
    }
    notifyListeners();
  }

  //country selection function
  onChangeCountryCompany(context, val, CountryStateModel c) {
    countryValue = val;

    country = c;

    int index = countryList.indexWhere((element) => element.id == c.id);
    log("countryList :${index}");
    if (index >= 0) {
      state = null;
      statesList = countryList[index].state!;
      notifyListeners();
      /*   stateValue = locationCtrl.stateList[0].id!;
      state = locationCtrl.stateList[stateValue!]*/
    }
    log("countryList :${statesList.length}");
    notifyListeners();
  }

  // state selection function
  onChangeStateCompany(val, StateModel c) {
    stateValue = val;
    state = c;
    notifyListeners();
  }

  //image picker option
  onImagePick(context, {isLogo = true}) {
    showLayout(context, onTap: (index) {
      if (index == 0) {
        getImage(context, ImageSource.gallery, isLogo: isLogo);
      } else {
        getImage(context, ImageSource.camera, isLogo: isLogo);
      }
      notifyListeners();
    });
  }

  getLocation(context) async {
    route.pushNamed(context, routeName.location, arg: {"isSignUp": true}).then(
        (e) {
      log("EEEE :$e");
      if (e != null) {
        final loc = Provider.of<LocationProvider>(context, listen: false);
        log("loc.street :${loc.place!}");
        int ind = countryList.indexWhere((element) =>
            element.name!.toLowerCase() == loc.place!.country!.toLowerCase());
        log("DDD :$ind");
        areaData = loc.street;
        if (ind >= 0) {
          country = countryList[ind];
          countryValue = ind;

          statesList = countryList[ind].state!;
        }
        int stateIndex = statesList.indexWhere((element) =>
            element.name!.toLowerCase() ==
            loc.place!.administrativeArea!.toLowerCase());
        log("stateIndex :$stateIndex");
        if (stateIndex >= 0) {
          state = statesList[stateIndex];
          stateValue = stateIndex;
        }
        notifyListeners();
        log("STATT:#$state");
        street.text = loc.place!.street ?? "";
        area.text = (loc.place!.locality != null ? loc.place!.locality! : "") +
            (loc.place!.subLocality != null
                ? ", ${loc.place!.subLocality}"
                : "");
        latitude.text = loc.position!.latitude.toString();
        longitude.text = loc.position!.longitude.toString();
        city.text = loc.place!.postalCode!;
        zipCode.text = loc.place!.street!;
        notifyListeners();
      }
    });
    /* showLoading(context);
    notifyListeners();
    final loc = Provider.of<LocationProvider>(context, listen: false);

    await loc.getUserCurrentLocation(context);
    await Future.delayed(Durations.short4);
    notifyListeners();
    areaData = loc.street;
    latitude.text = loc.position!.latitude.toString();
    longitude.text = loc.position!.longitude.toString();
    city.text = loc.place!.postalCode!;
    zipCode.text = loc.place!.street!;
    hideLoading(context);
    notifyListeners();
    log("AREA :$areaData");*/
  }

  getAddressFromLatLng(context) async {
    await placemarkFromCoordinates(position!.latitude, position!.longitude)
        .then((List<Placemark> placeMarks) async {
      Placemark? place = placeMarks[0];

      String data =
          '${place.name}, ${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      areaData = data;
      latitude.text = position!.latitude.toString();
      longitude.text = position!.longitude.toString();
      city.text = place.postalCode!;
      zipCode.text = place.street!;

      await Future.delayed(Durations.short4);
      hideLoading(context);
      notifyListeners();
    }).catchError((e) {
      hideLoading(context);
      notifyListeners();
      debugPrint("ee getAddressFromLatLng : $e");
    });
  }

  //language selection
  onLanguageSelect(options) {
    log("options :$options");
    languageSelect = options;
    notifyListeners();
  }

  //zone selection
  onZoneSelect(options) {
    if (!zoneSelect.contains(options)) {
      zoneSelect.add(options);
    } else {
      zoneSelect.remove(options);
    }
    notifyListeners();
  }

  onBottomSheet(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return const ZoneBottomSheet();
      },
    );
  }

  //on location delete tap
  onLocationDelete(index, context, sync) {
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.location, appFonts.delete,
        appFonts.areYiuSureDeleteLocation, () {
      appArray.serviceAvailableAreaList.removeAt(index);
      route.pop(context);
      notifyListeners();
    });
    value.notifyListeners();
  }

  //on page initialize
  onReady() {
    pageIndex = 0;
    fPageIndex = 0;
    notifyListeners();
    countryList = countryStateList;
    statesList = stateList;
    zonesList = zoneList;
    countryValue = countryList[0].id!;
    country = null;
    countryValue = -1;
    stateValue = -1;
    state = null;
    descriptionFocus.addListener(() {
      notifyListeners();
    });
    log("signup.countryList :${countryList.length}");
    notifyListeners();
  }

  //phone dial code selection
  changeDialCode(CountryCodeCustom country) {
    dialCode = country.dialCode!;
    notifyListeners();
  }

  //provider phone dial code selection

  changeProviderDialCode(CountryCodeCustom country) {
    providerDialCode = country.dialCode!;
    notifyListeners();
  }

  //experience duration select
  onDropDownChange(choseVal) {
    chosenValue = choseVal;
    notifyListeners();
  }

  //location range selection
  slidingValue(newValue) {
    slider = newValue;
    notifyListeners();
  }

  onIdentityChange(val) {
    log("SS ::4$val");
    documentModel = val.toString();
    notifyListeners();
  }

  scrollAnimated(double position) {
    controller.animateTo(position,
        duration: const Duration(seconds: 1), curve: Curves.ease);
    notifyListeners();
  }

//freelancer on save tap validation
  onFreelancerTap(context) async {
    log("fPageIndex ;$fPageIndex");

    if (fPageIndex == 0) {
      if (signupFreelanceFormKey1.currentState!.validate()) {
        if (languageSelect.isNotEmpty) {
          if (documentModel != null) {
            if (docFile != null) {
              if (chosenValue != null) {
                scrollAnimated(1);
                fPageIndex++;
              } else {
                snackBarMessengers(context,
                    message:
                        language(context, appFonts.pleaseSelectDurationUnit));
              }
            } else {
              snackBarMessengers(context,
                  message: language(context, appFonts.pleaseUploadDocument));
            }
          } else {
            snackBarMessengers(context,
                message: language(context, appFonts.pleaseSelectIdentityType));
          }
        } else {
          snackBarMessengers(context,
              message: language(context, appFonts.pleaseSelectLanguage));
        }
      }
    } else if (fPageIndex == 1) {
      if (signupFreelanceFormKey2.currentState!.validate()) {
        if (country != null) {
          if (state != null) {
            if (zonesList.isNotEmpty) {
              scrollAnimated(1);
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              fPageIndex++;

              if (fPageIndex == 2) {
                log("fghj");
                prefs.setBool(session.isLogin, true);
                prefs.setBool(session.isFreelancer, true);
                signUpAsFreelance(context);
                isFreelancer = true;
              }
            } else {
              snackBarMessengers(context,
                  message: language(context, appFonts.selectZone));
            }
          } else {
            snackBarMessengers(context,
                message: language(context, appFonts.pleaseSelectState));
          }
        } else {
          snackBarMessengers(context,
              message: language(context, appFonts.pleaseSelectCountry));
        }
      }
    }
  }

  //on next button tap with validation
  onNext(context) async {
    log("INDEX :$pageIndex");

    if (pageIndex == 0) {
      if (signupFormKey1.currentState!.validate()) {
        if (imageFile != null) {
          scrollAnimated(1);
          pageIndex++;
        } else {
          snackBarMessengers(context,
              message: language(context, appFonts.addCompanyLogo));
        }
      }
    } else if (pageIndex == 1) {
      if (signupFormKey2.currentState!.validate()) {
        if (country != null) {
          if (state != null) {
            if (zonesList.isNotEmpty) {
              scrollAnimated(1);
              pageIndex++;
            } else {
              snackBarMessengers(context,
                  message: language(context, appFonts.selectZone));
            }
          } else {
            snackBarMessengers(context,
                message: language(context, appFonts.selectState));
          }
        } else {
          snackBarMessengers(context,
              message: language(context, appFonts.selectCountry));
        }
      }
    } else if (pageIndex == 2) {
      if (signupFormKey3.currentState!.validate()) {
        if (languageSelect.isNotEmpty) {
          if (documentModel != null) {
            if (docFile != null) {
              scrollAnimated(1);
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              pageIndex++;
              if (pageIndex == 3) {
                prefs.setBool(session.isLogin, true);
                signUp(context);
                // route.pushReplacementNamed(context, routeName.dashboard);
              }
            } else {
              snackBarMessengers(context,
                  message: language(context, appFonts.pleaseUploadDocument));
            }
          } else {
            snackBarMessengers(context,
                message: language(context, appFonts.pleaseSelectIdentityType));
          }
        } else {
          snackBarMessengers(context,
              message: language(context, appFonts.pleaseSelectLanguage));
        }
      }
    }

    log("INDEXEPAGE $pageIndex");
    notifyListeners();
  }

  //sign up as company
  signUp(context) async {
    try {
      showLoading(context);
      notifyListeners();
      List langList = [];

      for (var d in languageSelect) {
        if (!langList.contains(d.value)) {
          langList.add(d.value);
        }
      }

      log("langList: ${langList.length}");
      String token = await getFcmToken();
      final mimeTypeData =
          lookupMimeType(imageFile!.path, headerBytes: [0xFF, 0xD8])!
              .split('/');
      final docMimeType =
          lookupMimeType(docFile!.path, headerBytes: [0xFF, 0xD8])!.split('/');
      final uploadList = <dio.MultipartFile>[];

      uploadList.add(await dio.MultipartFile.fromFile(docFile!.path.toString(),
          filename: docFile!.name.toString(),
          contentType: MediaType(docMimeType[0], docMimeType[1])));

      var body = {
        "type": isFreelancer ? "freelancer" : "company",
        'company_logo': await dio.MultipartFile.fromFile(
            imageFile!.path.toString(),
            filename: imageFile!.name.toString(),
            contentType: MediaType(mimeTypeData[0], mimeTypeData[1])),
        "company_name": companyName.text,
        "company_email": companyMail.text,
        "company_code": dialCode,
        "company_phone": companyPhone.text,
        "description": description.text,
        "name": ownerName.text,
        "email": providerEmail.text,
        "phone": providerNumber.text,
        "code": providerDialCode,
        "experience_interval": chosenValue ?? "Years",
        "experience_duration": experience.text,
        "password": password.text,
        "password_confirmation": reEnterPassword.text,
        "known_languages": langList,
        "document_id": documentModel,
        'identity_no': identityNumber.text,
        'document_images': uploadList,
        for (var i = 0; i < zoneSelect.length; i++)
          "zoneIds[$i]": zoneSelect[i].id,
        "fcm_token": token,
        "company_address": {
          "latitude": latitude.text,
          "longitude": longitude.text,
          "area": area.text,
          "address": street.text,
          "country_id": country!.id,
          "state_id": state!.id,
          "city": city.text,
          "postal_code": zipCode.text,
          "is_primary": "1"
        }
      };
      log("Final request body: ${body.toString()}");
      log("BODU :$body");

      dio.FormData formData = dio.FormData.fromMap(body);
      await apiServices.postApi(api.register, formData).then((value) async {
        log("API Response: ${value.toJson()}");
        hideLoading(context);
        notifyListeners();
        log("API Response check  :${value.isSuccess}");
        if (value.isSuccess!) {
          final commonApi =
              Provider.of<CommonApiProvider>(context, listen: false);
          await commonApi.selfApi(context);
          snackBarMessengers(context,
              message: value.message,
              color: appColor(context).appTheme.primary);

          notifyListeners();
          SharedPreferences? pref = await SharedPreferences.getInstance();
          dynamic userData = pref.getString(session.user);
          if (userData != null) {
            final commonApi =
                Provider.of<CommonApiProvider>(context, listen: false);
            await commonApi.selfApi(context);
            final userApi =
                Provider.of<UserDataApiProvider>(context, listen: false);
            await userApi.homeStatisticApi();
            if (!isFreelancer) {
              await userApi.getServicemenByProviderId();
            }
            final locationCtrl =
                Provider.of<LocationProvider>(context, listen: false);

            locationCtrl.getUserCurrentLocation(context);
            await userApi.getBankDetails();
            await userApi.getDocumentDetails();
            await userApi.getAddressList(context);
            await userApi.getJobRequest();
            await userApi.getNotificationList();
            await userApi.getServicePackageList();
            await userApi.getPopularServiceList();
            await userApi.getAllServiceList();

            await userApi.getBookingHistory(context);
            FirebaseApi().onlineActiveStatusChange(false);
          }

          route.pushReplacementNamed(context, routeName.dashboard);
          pageIndex = 0;
          notifyListeners();
        } else {
          pageIndex = 2;
          notifyListeners();
          snackBarMessengers(context,
              message: language(context, value.message));
        }
      });
    } catch (e) {
      pageIndex = 2;
      notifyListeners();
      hideLoading(context);
      notifyListeners();
      log("EEEE signUp : $e");
    }
  }

  //sign up as freelance
  signUpAsFreelance(context) async {
    try {
      showLoading(context);
      notifyListeners();
      final newLoc = Provider.of<NewLocationProvider>(context, listen: false);
      List newAddressList = [];
      for (var a in newLoc.locationList) {
        newAddressList.add({
          "type": a['type'].toString().toLowerCase(),
          "address": a['address'],
          "latitude": a['latitude'],
          "longitude": a['longitude'],
          "city": a['city'],
          "postal_code": a['postal_code'],
          "area": a['area'],
          "country_id": country!.id,
          "state_id": state!.id,
          "is_primary": "1",
          "status": "1",
          "availability_radius": slider,
        });
      }
      List langList = [];

      for (var d in languageSelect) {
        if (!langList.contains(d.value)) {
          langList.add(d.value);
        }
      }
      notifyListeners();
      String token = await getFcmToken();

      final docMimeType =
          lookupMimeType(docFile!.path, headerBytes: [0xFF, 0xD8])!.split('/');
      final uploadList = <dio.MultipartFile>[];

      uploadList.add(await dio.MultipartFile.fromFile(docFile!.path.toString(),
          filename: docFile!.name.toString(),
          contentType: MediaType(docMimeType[0], docMimeType[1])));

      var body = {
        "type": isFreelancer ? "freelancer" : "company",
        "name": ownerName.text,
        "email": providerEmail.text,
        "phone": providerNumber.text,
        "code": providerDialCode,
        "experience_interval": chosenValue ?? "year",
        "experience_duration": experience.text,
        "password": password.text,
        "known_languages": langList,
        "password_confirmation": reEnterPassword.text,
        "document_id": documentModel,
        'identity_no': identityNumber.text,
        'document_images': uploadList,
        "addresses": newAddressList,
        "fcm_token": token,
        if (!isFreelancer)
          "company_address": {
            "latitude": latitude.text,
            "longitude": longitude.text,
            "area": area.text,
            "address": street.text,
            "country_id": country!.id,
            "state_id": state!.id,
            "city": city.text,
            "postal_code": zipCode.text,
            "is_primary": "1"
          }
      };

      log("BODU :$body");

      dio.FormData formData = dio.FormData.fromMap(body);
      await apiServices.postApi(api.register, formData).then((value) async {
        hideLoading(context);
        notifyListeners();
        if (value.isSuccess!) {
          final commonApi =
              Provider.of<CommonApiProvider>(context, listen: false);
          await commonApi.selfApi(context);
          snackBarMessengers(context,
              message: value.message,
              color: appColor(context).appTheme.primary);

          notifyListeners();
          SharedPreferences? pref = await SharedPreferences.getInstance();
          dynamic userData = pref.getString(session.user);
          if (userData != null) {
            final commonApi =
                Provider.of<CommonApiProvider>(context, listen: false);
            await commonApi.selfApi(context);
            final userApi =
                Provider.of<UserDataApiProvider>(context, listen: false);
            await userApi.homeStatisticApi();
            if (!isFreelancer) {
              await userApi.getServicemenByProviderId();
            }
            final locationCtrl =
                Provider.of<LocationProvider>(context, listen: false);

            locationCtrl.getUserCurrentLocation(context);
            await userApi.getBankDetails();
            await userApi.getDocumentDetails();
            await userApi.getAddressList(context);
            await userApi.getNotificationList();
            await userApi.getServicePackageList();
            await userApi.getJobRequest();
            await userApi.getPopularServiceList();
            await userApi.getAllServiceList();
            await userApi.getBookingHistory(context);
            userApi.statisticDetailChart();
            FirebaseApi().onlineActiveStatusChange(false);
          }

          route.pushReplacementNamed(context, routeName.dashboard);
          fPageIndex = 0;
          notifyListeners();
        } else {
          fPageIndex = 1;
          notifyListeners();
        }
      });
    } catch (e) {
      fPageIndex = 1;
      notifyListeners();
      hideLoading(context);
      notifyListeners();
      log("EEEE signUp : $e");
    }
  }

  popInvokeFree(didPop, context) async {
    scrollAnimated(1);
    fPageIndex--;
    log("context :$fPageIndex");
    if (fPageIndex == -1) {
      languageSelect = [];
      countryCompany = null;
      country = null;
      countryProvider = null;
      stateCompany = null;
      stateProvider = null;
      chosenValue = null;
      countryValue = -1;
      stateValue = -1;
      slider = 0.0;
      imageFile = null;
      docFile = null;
      documentModel = null;

      companyName.text = "";
      companyPhone.text = "";
      companyMail.text = "";
      experience.text = "";
      description.text = "";
      identityNumber.text = "";
      password.text = "";
      reEnterPassword.text = "";
      latitude.text = "";
      longitude.text = "";
      area.text = "";
      street.text = "";
      city.text = "";
      zipCode.text = "";
      countryCtrl.text = "";
      stateCtrl.text = "";
      ownerName.text = "";
      providerEmail.text = "";
      providerNumber.text = "";
      areaData = "";
      route.pop(context);
    }

    notifyListeners();
  }

  popInvoke(didPop, context) async {
    scrollAnimated(1);
    pageIndex--;
    if (pageIndex == -1) {
      languageSelect = [];
      countryCompany = null;
      country = null;
      countryProvider = null;
      stateCompany = null;
      stateProvider = null;
      chosenValue = null;
      countryValue = -1;
      stateValue = -1;
      slider = 0.0;
      imageFile = null;
      docFile = null;
      documentModel = null;

      companyName.text = "";
      companyPhone.text = "";
      companyMail.text = "";
      experience.text = "";
      description.text = "";
      identityNumber.text = "";
      password.text = "";
      reEnterPassword.text = "";
      latitude.text = "";
      longitude.text = "";
      area.text = "";
      street.text = "";
      city.text = "";
      zipCode.text = "";
      countryCtrl.text = "";
      stateCtrl.text = "";
      ownerName.text = "";
      providerEmail.text = "";
      providerNumber.text = "";
      route.pop(context);
    }
    notifyListeners();
  }
}
