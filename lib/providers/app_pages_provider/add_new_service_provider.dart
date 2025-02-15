import 'dart:developer';
import 'package:fixit_provider/screens/app_pages_screens/add_new_service_screen/layouts/add_faq.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:fixit_provider/config.dart';
import 'package:fixit_provider/screens/app_pages_screens/add_new_service_screen/layouts/category_bottom_sheet.dart';
import 'package:fixit_provider/services/environment.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'package:mime/mime.dart' as mime;

class AddNewServiceProvider with ChangeNotifier {
  CategoryModel? categoryValue;
  CategoryModel? subCategoryValue;
  Services? services;
  List faqList = [];
  List<ServiceFaqModel> serviceFaq = [];
  List<CategoryModel> newCategoryList = [];

  List<CategoryModel> categories = [], newCatList = [];
  String? durationValue, serviceOption, perServiceman;
  int selectIndex = 0, selected = -1;
  int? taxIndex;
  bool isSwitch = true, isEdit = false;
  final multiSelectKey = GlobalKey<FormFieldState>();
  TextEditingController filterSearchCtrl = TextEditingController();
  final FocusNode filterSearchFocus = FocusNode();
  final dioo = Dio();
  String argData = 'NULL';
  List<CategoryModel> subCategory = [];
  String commission = "";
  dynamic areaData;
  String? street, area, latitude, longitude, city, zipCode;
  List<CountryStateModel> countryList = [];
  List<ZoneModel> zonesList = [];
  List<StateModel> statesList = [];
  int countryValue = -1, stateValue = -1;
  CountryModel? countryCompany, countryProvider, stateCompany, stateProvider;
  CountryStateModel? country;
  ZoneModel? zone;
  StateModel? state;

  TextEditingController serviceName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController availableService = TextEditingController();
  TextEditingController minRequired = TextEditingController();
  TextEditingController perServicemanCommission = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController tax = TextEditingController();

  FocusNode serviceNameFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();
  FocusNode durationFocus = FocusNode();
  FocusNode availableServiceFocus = FocusNode();
  FocusNode minRequiredFocus = FocusNode();
  FocusNode perServicemanCommissionFocus = FocusNode();
  FocusNode amountFocus = FocusNode();
  FocusNode discountFocus = FocusNode();
  FocusNode taxFocus = FocusNode();

  XFile? imageFile, thumbFile;
  GlobalKey<FormState> addServiceFormKey = GlobalKey<FormState>();
  String? thumbImage;
  List image = [];

  // on page initialise data fetch
  onReady(context) async {
    // TODO: implement initState
    log("dfn");
    final allUserApi = Provider.of<UserDataApiProvider>(context, listen: false);
    allUserApi.commonCallApi(context);
    final all = Provider.of<CommonApiProvider>(context, listen: false);
    all.commonApi(context);
    dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
    newCatList = allCategoryList;
    descriptionFocus.addListener(() {
      notifyListeners();
    });

    if (data != "") {
      isEdit = data["isEdit"] ?? false;
      services = data['service'];
      if (data['serviceFaq'] != null) {
        serviceFaq = serviceFaq;
      } else {
        await getServiceFaqId(context, services!.id);
      }

      serviceName.text = services!.title!;
      log("services!.categories :${services!.categories}");
      if (services!.categories != null) {
        services!.categories!.asMap().entries.forEach((element) {
          /* ValueItem<int> valueItem =
              ValueItem(label: element.value.title!, value: element.value.id);
*/
          if (!categories.contains(element.value)) {
            categories.add(element.value);
          }
          notifyListeners();
        });
      }

      categories.asMap().entries.forEach((e) {
        int index =
            allCategoryList.indexWhere((element) => element.id == e.value.id);
        if (index >= 0) {
          newCategoryList.add(allCategoryList[index]);
        }
      });
      for (var d in serviceFaq) {
        var a = {
          'question': d.question,
          'answer': d.answer,
        };
        faqList.add(a);
      }
      notifyListeners();
      if (newCategoryList.isNotEmpty) {
        var largestGeekValue = newCategoryList.reduce((current, next) =>
            double.parse(current.commission!.toString()) >
                    double.parse(next.commission!.toString())
                ? current
                : next);

        commission = largestGeekValue.commission!.toString();
      } else {
        commission = "0.0";
      }

      log("services!.serviceAvailabilities  :${services!.serviceAvailabilities}");

      selectIndex =
          services!.discount != null && services!.discount != 0 ? 1 : 0;
      description.text = services!.description ?? "";

      discount.text = (services!.discount!).toStringAsFixed(0).toString();
      duration.text = services!.duration!;
      log("services!.durationUnit! :${services!.durationUnit!}");
      if (services!.durationUnit == translations?.hour) {
        durationValue = capitalizeFirstLetter(
            services!.durationUnit == translations?.hour
                ? "hours"
                : services!.durationUnit!);
      } else {
        durationValue = capitalizeFirstLetter(services!.durationUnit == "minute"
            ? "minutes"
            : services!.durationUnit!);
      }
      minRequired.text = services!.requiredServicemen != null
          ? services!.requiredServicemen.toString()
          : "1";
      amount.text = services!.price!.toString();

      int taxVal = taxList.indexWhere(
          (element) => element.id.toString() == services!.taxId.toString());
      if (taxVal >= 0) {
        taxIndex = int.parse(services!.taxId!.toString());
      }
      isSwitch = services!.status == 1 ? true : false;

      if (services!.media != null && services!.media!.isNotEmpty) {
        for (var d in services!.media!) {
          log("d.collectionName :${d.collectionName}");
          if (d.collectionName == "thumbnail") {
            thumbImage = d.originalUrl!;
          }
        }
      }
      notifyListeners();
    } else {
      taxIndex = null;
      faqList = [];
    }
    addressList = [];
  }

  Future<void> getServiceDetails(BuildContext context, int serviceId) async {
    final lang = Provider.of<LanguageProvider>(context, listen: false);
    String selectedLocale =
        lang.selectedLocaleService; // Get the selected language

    log("Fetching service details for locale: $selectedLocale");

    final response = await apiServices.getApi(
        '${api.providerServices}?service_id=$serviceId?lang=$selectedLocale',
        [],
        isData: true,
        isToken: false);

    if (response.isSuccess!) {
      services = Services.fromJson(response.data);
      log("Service Data: ${services!.title} (${selectedLocale})");

      // Update only localized fields
      serviceName.text = services!.title ?? "";
      description.text = services!.description ?? "";

      notifyListeners();
    } else {
      log("Failed to fetch service details: ${response.message}");
    }
  }

  //country selection function
  onChangeCountryCompany(context, val, CountryStateModel c) {
    countryValue = val;

    country = c;

    int index = countryList.indexWhere((element) => element.id == c.id);
    log("countryList :$index");
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
/*
  Future<void> getLocation(BuildContext context) async {
    final loc = Provider.of<LocationProvider>(context, listen: false);

    // Request location permission
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      log("Location permission denied");
      return;
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Reverse geocode to get address
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude, position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      areaData = "${place.street}, ${place.locality}, ${place.country}";

      // Update location fields
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
      city = place.locality ?? "";
      zipCode = place.postalCode ?? "";
    }

    notifyListeners();
  }
*/

  getLocation(context) async {
    route.pushNamed(context, routeName.location, arg: {"isService": true}).then(
        (e) {
      log("EEEE :$e");
    });
    // showLoading(context);
    notifyListeners();
    /* final loc = Provider.of<LocationProvider>(context, listen: false);

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

  getServiceFaqId(context, serviceId) async {
    try {
      await apiServices
          .getApi("${api.serviceFaq}?service_id=$serviceId", [],
              isData: true, isMessage: false)
          .then((value) {
        if (value.isSuccess!) {
          for (var d in value.data) {
            if (!serviceFaq.contains(ServiceFaqModel.fromJson(d))) {
              serviceFaq.add(ServiceFaqModel.fromJson(d));
            }
          }
          log("serviceFaq :${serviceFaq.length}");
          notifyListeners();
        } else {
          notifyListeners();
        }
      });
    } catch (e) {
      log("ERRROEEE getServiceFaqId : $e");
      notifyListeners();
    }
  }

  //add faq
  addFaq(context) {
    route.push(context, AddFaq(faqList: faqList)).then((e) {
      if (e != null) {
        faqList = e;
      }
      notifyListeners();
    });
  }

  onExpansionChange(newState, index) {
    log("dghfdkg:$newState");
    if (newState) {
      const Duration(seconds: 20000);
      selected = index;
      notifyListeners();
    } else {
      selected = -1;
      notifyListeners();
    }
  }

  //on select service type option
  onSelectServiceTypeOption(val) {
    serviceOption = val;
    notifyListeners();
  }

  //category list
  getCategory({search}) async {
    // notifyListeners();
    try {
      String apiUrl = "${api.category}?providerId=${userModel!.id}";
      if (search != null) {
        apiUrl = "${api.category}?providerId=${userModel!.id}&search=$search";
      } else {
        apiUrl = "${api.category}?providerId=${userModel!.id}";
      }
      await apiServices.getApi(apiUrl, []).then((value) {
        newCatList = [];
        if (value.isSuccess!) {
          List category = value.data;
          for (var data in category.reversed.toList()) {
            if (!newCatList.contains(CategoryModel.fromJson(data))) {
              newCatList.add(CategoryModel.fromJson(data));
            }
            notifyListeners();
          }
        }
      });
    } catch (e) {
      notifyListeners();
    }
  }

  onBottomSheet(context) {
    newCatList = allCategoryList;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return const CategoryBottomSheet();
      },
    );
  }

  //on back data clear
  onBack(isBack) {
    isEdit = false;
    image = [];
    faqList = [];
    serviceFaq = [];
    services = null;
    thumbImage = null;
    categories = [];
    filterSearchCtrl.text = "";
    appArray.serviceImageList = [];
    categories = [];
    newCatList = [];
    newCategoryList = [];
    serviceName.text = "";
    thumbFile = null;
    imageFile = null;
    categoryValue = null;
    subCategoryValue = null;
    description.text = "";
    duration.text = "";
    availableService.text = "";
    minRequired.text = "";
    discount.text = "";
    selectIndex = 0;
    amount.text = "";
    taxIndex = null;

    isSwitch = false;

    taxIndex = null;
    durationValue = null;
    imageFile = null;
    thumbFile = null;
    image = [];

    appArray.serviceImageList = [];

    description.text = "";
    categories = [];
    notifyListeners();
  }

  //on back button data clear
  onBackButton(context) {
    route.pop(context);
    isEdit = false;
    image = [];
    thumbImage = "";
    serviceName.text = "";
    categoryValue = null;
    subCategoryValue = null;
    description.text = "";
    duration.text = "";
    availableService.text = "";
    minRequired.text = "";
    amount.text = "";
    taxIndex = null;

    isSwitch = false;

    notifyListeners();
  }

  //updateInformation
  void updateInformation(information) {
    argData = information;
    notifyListeners();
  }

  //on available service tap
  onAvailableServiceTap(context) async {
    var result = await route.push(context, const LocationListScreen());
    availableService.text = result;
    notifyListeners();
  }

  // GET IMAGE FROM GALLERY
  Future getImage(context, source, isThumbnail) async {
    final ImagePicker picker = ImagePicker();
    if (isThumbnail) {
      route.pop(context);
      thumbFile = (await picker.pickImage(source: source, imageQuality: 70))!;
    } else {
      route.pop(context);
      imageFile = (await picker.pickImage(source: source, imageQuality: 70))!;
      appArray.serviceImageList.add(imageFile!);
      notifyListeners();
    }
    notifyListeners();
  }

  //on image pick
  onImagePick(context, isThumbnail) {
    showLayout(context, onTap: (index) {
      if (index == 0) {
        if (isThumbnail) {
          getImage(context, ImageSource.gallery, isThumbnail);
        } else {
          getImage(context, ImageSource.gallery, isThumbnail);
        }
        notifyListeners();
      } else {
        if (isThumbnail) {
          getImage(context, ImageSource.camera, isThumbnail);
        } else {
          getImage(context, ImageSource.camera, isThumbnail);
        }
        notifyListeners();
      }
    });
  }

  // on remove service image
  onRemoveServiceImage(isThumbnail, {index}) {
    if (isThumbnail) {
      thumbFile = null;
      thumbImage = null;
      notifyListeners();
    } else {
      appArray.serviceImageList.removeAt(index);
      notifyListeners();
    }
  }

  onRemoveNetworkServiceImage(isThumbnail, {index}) {
    if (isThumbnail) {
      thumbFile = null;
      thumbImage = null;
      notifyListeners();
    } else {
      services!.media!.removeAt(index);
      notifyListeners();
    }
  }

  //service available switch
  onTapSwitch(val) {
    isSwitch = val;
    notifyListeners();
  }

  // tax selection
  onChangeTax(index) {
    log("indtaxIndexex :$index");
    taxIndex = index;
    notifyListeners();
  }

  //price change
  onChangePrice(index) {
    selectIndex = index;
    notifyListeners();
  }

  //category selection
  onChangeCategory(CategoryModel val, id) {
    newCategoryList = [];
    //categories = val;
    if (!categories.contains(val)) {
      log("val.parentId:: ${val.parentId}");
      if (val.parentId != null) {
        int index = newCatList.indexWhere(
            (element) => element.id.toString() == val.parentId.toString());
        if (index >= 0) {
          if (!categories.contains(newCatList[index])) {
            categories.add(newCatList[index]);
          }
          notifyListeners();
        }
      }
      categories.add(val);
      notifyListeners();
    } else {
      categories.remove(val);
      notifyListeners();
    }

    notifyListeners();
    categories.asMap().entries.forEach((e) {
      int index =
          allCategoryList.indexWhere((element) => element.id == e.value.id);
      if (index >= 0) {
        newCategoryList.add(allCategoryList[index]);
      }
    });
    // notifyListeners();
    if (newCategoryList.isNotEmpty) {
      var largestGeekValue = newCategoryList.reduce((current, next) =>
          double.parse(current.commission!.toString()) >
                  double.parse(next.commission!.toString())
              ? current
              : next);

      commission = largestGeekValue.commission!.toString();
    } else {
      commission = "0.0";
    }
    notifyListeners();
  }

  //select duration unit
  onChangeDuration(val) {
    durationValue = val;
    notifyListeners();
  }

  //add data validation
  addData(context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (addServiceFormKey.currentState!.validate()) {
      log("thumbFile:::$thumbFile");
      if (appArray.serviceImageList.isNotEmpty) {
        log("thumbFile:::$thumbFile");
        if (thumbFile != null) {
          if (categories.isNotEmpty) {
            if (durationValue != null) {
              if (taxIndex != null) {
                log("isSubscription:$isSubscription");
                if (isSubscription) {
                  if (allServiceList.length <
                      int.parse(
                          activeSubscription!.allowedMaxServices ?? "0")) {
                    addServiceApi(context);
                  } else {
                    snackBarMessengers(context,
                        message: language(
                            context,
                            appFonts.addUpToService(
                                context,
                                activeSubscription!.allowedMaxServices!
                                    .toString())));
                  }
                } else {
                  if (allServiceList.isEmpty) {
                    addServiceApi(context);
                  } else {
                    if (allServiceList.length <
                        int.parse(appSettingModel!
                                .defaultCreationLimits!.allowedMaxServices ??
                            "0")) {
                      addServiceApi(context);
                    } else {
                      snackBarMessengers(context,
                          message: language(
                              context,
                              appFonts.addUpToService(
                                  context,
                                  appSettingModel!
                                      .defaultCreationLimits!.allowedMaxServices
                                      .toString())));
                    }
                  }
                }
              } else {
                snackBarMessengers(context,
                    message: language(context, translations!.pleaseSelectTax));
              }
            } else {
              snackBarMessengers(context,
                  message: language(
                      context, translations!.pleaseSelectDurationUnit));
            }
          } else {
            snackBarMessengers(context,
                message: language(context, translations!.pleaseSelectCategory));
          }
        } else {
          snackBarMessengers(context,
              message: language(context, translations!.pleaseUploadThumbPhoto));
        }
      } else {
        snackBarMessengers(context,
            message:
                language(context, translations!.pleaseUploadServiceImages));
      }
    }
  }

  //edit data validation
  editData(context) {
    log("message :${userModel!.media![0].originalUrl}");
    FocusScope.of(context).requestFocus(FocusNode());
    editServiceApi(context);
    if (addServiceFormKey.currentState!.validate()) {
      if (services!.media != null &&
          services!.media!.isNotEmpty &&
          services!.categories != []) {
        editServiceApi(context);
      } else {
        snackBarMessengers(context,
            message: language(context, translations!.pleaseUploadProfilePhoto));
      }
    }
  }

  List<ZoneModel> zoneSelect = [];
//add service
  addServiceApi(context) async {
    showLoading(context);
    notifyListeners();

    try {
      dynamic mimeTypeData;
      if (thumbFile != null) {
        mimeTypeData =
            lookupMimeType(thumbFile!.path, headerBytes: [0xFF, 0xD8])!
                .split('/');
      }
      log("thumbFile:4$thumbFile");
      log("thumbFile:4${thumbFile!.path} //z${thumbFile!.name}");

      final locationVal =
          Provider.of<NewLocationProvider>(context, listen: false);
      log("aessdadasd:::${locationVal.latitudeCtrl.text}//${locationVal.longitudeCtrl.text}///}");

      var body = {
        'type': serviceOption,
        "title": serviceName.text,
        if (thumbFile != null)
          'thumbnail': await dio.MultipartFile.fromFile(
              thumbFile!.path.toString(),
              filename: thumbFile!.name.toString(),
              contentType: MediaType(mimeTypeData[0], mimeTypeData[1])),
        "provider_id": userModel!.id,
        "price": amount.text,
        "discount": discount.text.isNotEmpty ? discount.text : 0,
        "tax_id": taxIndex,
        "duration": duration.text,
        "duration_unit": durationValue!.toLowerCase(),
        "description": description.text,
        "required_servicemen": minRequired.text,
        "is_featured": "1",
        "per_serviceman_commission": perServicemanCommission.text,
        "destination_location": {
          "lat": addressList.last.latitude,
          "lng": addressList.last.longitude,
          "area": addressList.last.area,
          "address": addressList.last.address,
          "state_id": addressList.last.stateId,
          "country_id": addressList.last.countryId,
          "postal_code": addressList.last.postalCode,
          "city": addressList.last.city
        },
        "faqs": faqList,
        "isMultipleServiceman": minRequired.length > 1 ? "1" : 0,
        "status": isSwitch == true ? "1" : 0,
        for (var i = 0; i < categories.length; i++)
          "category_id[$i]": categories[i].id,
      };
      dio.FormData formData = dio.FormData.fromMap(body);
      final lang = Provider.of<LanguageProvider>(context, listen: false);

      log("lang:::${lang.currentLanguage}");
      for (var file in appArray.serviceImageList) {
        log("FILE :$file");
        formData.files.addAll([
          MapEntry(
              "image[]",
              await dio.MultipartFile.fromFile(
                file.path.toString(),
                filename: file.name.toString(),
              )),
        ]);
      }
      log("BODY :$body");

      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString(session.accessToken);

      await dioo
          .post(api.service,
              data: formData,
              options: Options(
                  headers: headersToken(
                token,
                localLang: lang.selectedLocaleService,
                isLang: true,
              )))
          .then((value) async {
        hideLoading(context);
        notifyListeners();

        log("Response Data: ${value.statusCode}");
        log("Response Type: ${value.data.runtimeType}");

        // Check if value.data contains 'success' instead of assuming it's a bool
        if (value.data is Map<String, dynamic> ||
            value.data["success"] == true) {
          final userApi =
              Provider.of<UserDataApiProvider>(context, listen: false);
          await userApi.getAllServiceList();
          await userApi.homeStatisticApi();
          await userApi.getCategory();
          onBack(false);
          snackBarMessengers(context,
              message: value.data["message"] ?? "Success",
              color: appColor(context).appTheme.primary);
          route.pop(context);
          route.pop(context);
          notifyListeners();
        } else {
          Fluttertoast.showToast(
              msg: value.data["message"] ?? "Something went wrong");
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
      Fluttertoast.showToast(msg: e.toString());
      log("EEEE addServiceman : $e");
    }
  }

  // addServiceApi(context) async {
  //   showLoading(context);
  //   notifyListeners();

  //   try {
  //     dynamic mimeTypeData;

  //     if (thumbFile != null) {
  //       mimeTypeData =
  //           lookupMimeType(thumbFile!.path, headerBytes: [0xFF, 0xD8])!
  //               .split('/');
  //     }
  //     log("thumbFile:4$thumbFile");
  //     log("thumbFile:4${thumbFile!.path} //z${thumbFile!.name}");
  //     // log("thumbFile:state${state!.id} //${country!.id}//${latitude}//${longitude}//${area}//$zipCode");
  //     // log("thumbFile:4${thumbFile!.path} //z${thumbFile!.name}");
  //     final locationVal =
  //     Provider.of<NewLocationProvider>(context, listen: false);
  //     log("locationVal:::${locationVal.latitudeCtrl.text}//${locationVal.longitudeCtrl.text}///}");
  //     var body = {
  //       'type': serviceOption,
  //       "title": serviceName.text,
  //       if (thumbFile != null)
  //         'thumbnail': await dio.MultipartFile.fromFile(
  //             thumbFile!.path.toString(),
  //             filename: thumbFile!.name.toString(),
  //             contentType: MediaType(mimeTypeData[0], mimeTypeData[1])),
  //       "provider_id": userModel!.id,
  //       "price": amount.text,
  //       "discount": discount.text.isNotEmpty ? discount.text : 0,
  //       "tax_id": taxIndex,
  //       "duration": duration.text,
  //       "duration_unit": durationValue!.toLowerCase(),
  //       "description": description.text,
  //       "required_servicemen": minRequired.text,
  //       "is_featured": "1",
  //       "per_serviceman_commission": perServicemanCommission.text,
  //       "destination_location": {
  //         "lat": addressList.last.latitude,
  //         "lng": addressList.last.longitude,
  //         "area":addressList.last.area,
  //         "address": addressList.last.address,
  //         "state_id": addressList.last.stateId,
  //         "country_id": addressList.last.countryId,
  //         "postal_code":addressList.last.postalCode,
  //         "city": addressList.last.city
  //       },
  //       "faqs": faqList,
  //       "isMultipleServiceman": minRequired.length > 1 ? "1" : 0,
  //       "status": isSwitch == true ? "1" : 0,
  //       for (var i = 0; i < categories.length; i++)
  //         "category_id[$i]": categories[i].id,
  //     };
  //     dio.FormData formData = dio.FormData.fromMap(body);
  //     final lang = Provider.of<LanguageProvider>(context, listen: false);

  //     log("lang:::${lang.currentLanguage}");
  //     for (var file in appArray.serviceImageList) {
  //       log("FILE :$file");
  //       formData.files.addAll([
  //         MapEntry(
  //             "image[]",
  //             await dio.MultipartFile.fromFile(
  //               file.path.toString(),
  //               filename: file.name.toString(),
  //             )),
  //       ]);
  //     }
  //     log("BODU :$body");
  //     // log("BODU :${locationVal.address!}");
  //     // log("BODU :${formData.files}");
  //     SharedPreferences pref = await SharedPreferences.getInstance();

  //     String? token = pref.getString(session.accessToken);

  //     //  var header= headersToken(
  //     //   token,localLang:lang.selectedLocaleService ,
  //     //   isLang: true,
  //     // );

  //     // log("lang.selectedLocaleService::${header}");
  //     // // log("lang.selectedLocaleService::$header");

  //     await dioo
  //         .post(api.service,
  //             data: formData,
  //             options: Options(
  //                 headers: headersToken(
  //       token,localLang:lang.selectedLocaleService ,
  //       isLang: true,
  //     )))
  //     //  await apiServices
  //     //     .postApi(api.service, formData, isToken: true,isData: true)
  //         .then((value) async {
  //       hideLoading(context);
  //       notifyListeners();

  //       if (value.data!) {
  //         final userApi =
  //             Provider.of<UserDataApiProvider>(context, listen: false);
  //         await userApi.getAllServiceList();
  //         await userApi.homeStatisticApi();
  //         await userApi.getCategory();
  //         onBack(false);
  //         snackBarMessengers(context,
  //             message: value.statusMessage,
  //             color: appColor(context).appTheme.primary);

  //         notifyListeners();

  //         route.pop(context);
  //       } else {
  //         final userApi =
  //             Provider.of<UserDataApiProvider>(context, listen: false);
  //         await userApi.getAllServiceList();
  //         Fluttertoast.showToast(msg: value.statusMessage!);
  //       }
  //     });
  //   } catch (e) {
  //     hideLoading(context);
  //     notifyListeners();
  //     Fluttertoast.showToast(msg: e.toString());
  //     log("EEEE addServiceman : $e");
  //   }
  // }

//edit service
  editServiceApi(context) async {
    try {
      log("thumbFile: ${thumbFile!.path}");
      dynamic mimeTypeData;
      if (thumbFile != null) {
        mimeTypeData = mime.lookupMimeType(thumbFile!.path,
            headerBytes: [0xFF, 0xD8])!.split('/');
      }

      showLoading(context);
      notifyListeners();
      var body = {
        'type': serviceOption,
        "title": serviceName.text,
        if (thumbFile != null)
          'thumbnail': await dio.MultipartFile.fromFile(
              thumbFile!.path.toString(),
              filename: thumbFile!.name.toString(),
              contentType: MediaType(mimeTypeData[0], mimeTypeData[1])),
        "user_id": userModel!.id,
        "price": amount.text,
        "discount": discount.text.isNotEmpty ? int.parse(discount.text) : 0,
        "tax_id": taxIndex,
        "duration": duration.text,
        "duration_unit": durationValue!.toLowerCase(),
        "description": description.text,
        "required_servicemen": minRequired.text,
        "per_serviceman_commission": perServicemanCommission.text,
        "faqs": faqList,
        "is_featured": services!.isFeatured,
        "isMultipleServiceman": minRequired.length > 1 ? "1" : 0,
        "status": isSwitch == true ? "1" : 0,
        for (var i = 0; i < categories.length; i++)
          "category_id[$i]": categories[i].id,
        "_method": "PUT"
      };
      dio.FormData formData = dio.FormData.fromMap(body);
      log("body:::$body");
      for (var file in appArray.serviceImageList) {
        formData.files.addAll([
          MapEntry(
              "image[]",
              await MultipartFile.fromFile(file.path,
                  filename: file.path.split('/').last)),
        ]);
      }

      log("BODY :$body");
      await apiServices
          .postApi("${api.service}/${services!.id}", formData, isToken: true)
          .then((value) async {
        log("CAL :${value.isSuccess} //${value.message}");
        hideLoading(context);
        notifyListeners();

        if (value.isSuccess!) {
          final userApi =
              Provider.of<UserDataApiProvider>(context, listen: false);
          await userApi.getAllServiceList();
          getServiceFaqId(context, services!.id);
          userApi.getCategory();
          onBack(false);
          snackBarMessengers(context,
              message: value.message,
              color: appColor(context).appTheme.primary);
          notifyListeners();
          route.pop(context);
          imageFile = null;

          appArray.servicemanDocImageList = [];

          description.text = "";
        } else {
          snackBarMessengers(context,
              message: value.message, color: appColor(context).appTheme.red);
          final userApi =
              Provider.of<UserDataApiProvider>(context, listen: false);
          await userApi.getAllServiceList();
          //route.pop(context);
          //route.pop(context);
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
      snackBarMessengers(context,
          message: e.toString(), color: appColor(context).appTheme.red);
      log("EEEE addServiceman : $e");
    }
  }
}
