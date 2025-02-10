import 'dart:developer';
import 'dart:ui' as ui;
import 'package:dio/dio.dart' as dio;
import 'package:fixit_provider/model/country_state_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../config.dart';
import '../../screens/auth_screens/sign_up_company_screen/layouts/zone_list_sheet.dart';

class CompanyDetailProvider with ChangeNotifier {
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController zipcodeCtrl = TextEditingController();
  List<ZoneModel> zoneSelect = [], zonesList = [];
  FocusNode cityFocus = FocusNode();
  FocusNode zipCodeFocus = FocusNode();

  TextEditingController companyName = TextEditingController();
  TextEditingController companyPhone = TextEditingController();
  TextEditingController companyMail = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipCode = TextEditingController();

  TextEditingController countryCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();

  final FocusNode companyNameFocus = FocusNode();
  final FocusNode phoneNameFocus = FocusNode();
  final FocusNode companyMailFocus = FocusNode();
  final FocusNode descriptionFocus = FocusNode();
  FocusNode latFocus = FocusNode();
  FocusNode longFocus = FocusNode();
  FocusNode areaFocus = FocusNode();
  FocusNode streetFocus = FocusNode();

  FocusNode zipcodeFocus = FocusNode();
  FocusNode stateFocus = FocusNode();
  FocusNode countryFocus = FocusNode();

  XFile? imageFile;

  String dialCode = "+91";
  int countryValue = -1, stateValue = -1;
  List<CountryStateModel> countryList = [];
  List<StateModel> statesList = [];
  CountryStateModel? country;
  CountryStateModel? countryCompany,
      countryProvider,
      stateCompany,
      stateProvider;
  ZoneModel? zone;
  StateModel? state;

  String? areaValue, logo;
  double slider = 0;
  dynamic areaData;

  ui.Image? customImage;

  bool isSelectedZone = false;

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

  //zone selection
  onZoneSelect(options) {
    if (!zoneSelect.contains(options)) {
      zoneSelect.add(options);
    } else {
      zoneSelect.remove(options);
    }
    notifyListeners();
  }

  // GET IMAGE FROM GALLERY
  Future getImage(context, source, {isLogo = true}) async {
    final ImagePicker picker = ImagePicker();
    XFile image = (await picker.pickImage(source: source, imageQuality: 70))!;
    route.pop(context);
    imageFile = image;
    notifyListeners();
  }

  //country selection function
  onChangeCountryCompany(context,val,CountryStateModel c) {
    countryValue = val;

    country = c;
    int index = countryList
        .indexWhere((element) => element.id == c.id);


    if (index >= 0) {
      statesList = countryList[index].state!;
      notifyListeners();
      /*   stateValue = locationCtrl.stateList[0].id!;
      state = locationCtrl.stateList[stateValue!]*/
    }

    notifyListeners();
  }

  // state selection function
  onChangeStateCompany(val,StateModel c) {
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

  //availability radius
  slidingValue(newValue, upperValue) {
    slider = newValue;
    notifyListeners();
  }

  //address active status change
  onTapSwitch(context, val, index) {
    addressList[index].status = val == true ? 1 : 0;

    notifyListeners();
    statusUpdateAddress(
        context, addressList[index].id, addressList[index].status);
  }

  getArg(context) {
    countryList = countryStateList;

    notifyListeners();
    countryValue = countryStateList[0].id!;
    statesList = countryStateList[0].state!;
    country = null;
    countryValue = -1;
    stateValue = -1;

    state = null;
    companyName.text = userModel!.company!.name ?? "";
    companyMail.text = userModel!.company!.email ?? "";
    companyPhone.text = userModel!.company!.phone != null ?userModel!.company!.phone.toString():"";
    dialCode = userModel!.company!.code ?? "";
    description.text = userModel!.company!.description ?? "";
    logo = userModel!.company!.media![0].originalUrl;
    areaData = "${userModel!.company!.primaryAddress!.area}, ${userModel!.company!.primaryAddress!.address}";
    area.text = userModel!.company!.primaryAddress!.area ?? "";
    street.text = userModel!.company!.primaryAddress!.address ?? "";
    city.text = userModel!.company!.primaryAddress!.city ?? "";
    zipCode.text = userModel!.company!.primaryAddress!.postalCode ?? "";

    latitude.text = userModel!.company!.primaryAddress!.latitude ?? "";
    longitude.text = userModel!.company!.primaryAddress!.longitude ?? "";
    int ind = countryList.indexWhere((element) =>
        element.id.toString() == userModel!.company!.primaryAddress!.countryId);
    if (ind >= 0) {
      country = countryList[ind];
      statesList = countryList[ind].state!;
      notifyListeners();

    }

    print("country :$country");

    int stateInd = statesList.indexWhere((element) =>
    element.id.toString() == userModel!.company!.primaryAddress!.stateId);
    log("stateIndstateInd ;$stateInd");
    if (stateInd >= 0) {
      state = statesList[stateInd];
      notifyListeners();

    }
  print("state :$state");
    notifyListeners();
  }

  //address selection
  onAreaTap(val) {
    areaValue = val;
    notifyListeners();
  }

  //country selection
  onChangeCountry(val) {
    country = val;
    notifyListeners();
  }

  zoneAddHideShow() {
    isSelectedZone = !isSelectedZone;
    notifyListeners();
  }

  onBottomSheet(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return const ZoneBottomSheet(isAddLocation: true);
      },
    );
  }

  //delete location confirmation
  onDeleteLocation(context, index, sync, id) {
    final locationCtrl =
        Provider.of<NewLocationProvider>(context, listen: false);

    locationCtrl.notifyListeners();
    notifyListeners();

    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.servicemen,
        appFonts.deleteLocation, appFonts.deleteLocationSuccessfully, () {
      notifyListeners();
    });
    value.notifyListeners();
  }


  //phone dial code selection
  changeDialCode(CountryCodeCustom country) {
    dialCode = country.dialCode!;
    notifyListeners();
  }

  //status update Address
  statusUpdateAddress(context, id, val) async {
    showLoading(context);

    try {
      await apiServices
          .postApi("${api.changeAddressStatus}/$id", {"status": val},
              isToken: true)
          .then((value) {
        hideLoading(context);

        notifyListeners();
        if (value.isSuccess!) {
          final common =
              Provider.of<UserDataApiProvider>(context, listen: false);
          common.getAddressList(context);
        } else {
          snackBarMessengers(context,
              color: appColor(context).appTheme.red, message: value.message);
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
      log("EEEE statusUpdateAddress : $e");
    }
  }

  deleteZone(context,id)async{

    try {
      showLoading(context);
      List ids = [];
      userModel!.zones!.removeWhere((element) => element.id == id);
      notifyListeners();
      for (var d in userModel!.zones!) {
        ids.add(d.id);
      }

      await apiServices
          .postApi(api.zoneUpdate, {"zoneIds": ids}, isToken: true)
          .then((value) {
        log("ZOOOO :${value.data}");
        hideLoading(context);

        notifyListeners();
        if (value.isSuccess!) {
          final common = Provider.of<CommonApiProvider>(context, listen: false);
          common.selfApi(context);
          isSelectedZone = false;
          notifyListeners();
        } else {
          snackBarMessengers(context,
              color: appColor(context).appTheme.red, message: value.message);
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
      log("EEEE statusUpdateAddress : $e");
    }
  }

  //zone update Address
  zoneUpdateAddress(context) async {
    showLoading(context);

    try {
      List ids = [];
      for (var d in zoneSelect) {
        ids.add(d.id);
      }
      log("IDS:${userModel!.role!.name}");
      notifyListeners();
      await apiServices
          .postApi(api.zoneUpdate, {"zoneIds": ids}, isToken: true)
          .then((value)async {
        log("ZOOOO :${value.data}");
        hideLoading(context);

        notifyListeners();
        if (value.isSuccess!) {
          final common = Provider.of<CommonApiProvider>(context, listen: false);
        await  common.selfApi(context);
          isSelectedZone = false;
          zoneSelect =[];
          notifyListeners();
        } else {
          snackBarMessengers(context,
              color: appColor(context).appTheme.red, message: value.message);
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
      log("EEEE statusUpdateAddress : $e");
    }
  }

  onEditLocation(context, val, index) {
    route.pushNamed(context, routeName.location,
        arg: {"index": index, "isEdit": true, "data": val, "radius": slider});
    notifyListeners();
  }

  onReady() {
    countryList = [];
    zonesList = zoneList;
    notifyListeners();
    if (userModel!.zones!.isNotEmpty) {
      for (var d in userModel!.zones!) {
        zoneSelect.add(d);
      }
    }

    /* notifyListeners();
    appArray.countryList.asMap().entries.forEach((element) {
      if(!countryList.contains(CountryModel.fromJson(element.value))) {
        countryList.add(CountryModel.fromJson(element.value));
      }
    });*/
    notifyListeners();
  }

  //update profile
  updateProfile(context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    try {
      showLoading(context);
      notifyListeners();
      dynamic mimeTypeData;
      if (imageFile != null) {
        mimeTypeData =
            lookupMimeType(imageFile!.path, headerBytes: [0xFF, 0xD8])!
                .split('/');
      }

      var body = {
        if (imageFile != null)
          'company_logo': await dio.MultipartFile.fromFile(
              imageFile!.path.toString(),
              filename: imageFile!.name.toString(),
              contentType: MediaType(mimeTypeData[0], mimeTypeData[1])),
        "name": companyName.text,
        "email": companyMail.text,
        "code": dialCode,
        "phone": companyPhone.text,
        "description": description.text,
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

      dio.FormData formData = dio.FormData.fromMap(body);

      log("BBBBB :$body");
      await apiServices
          .postApi(api.updateCompanyProfile, formData, isToken: true)
          .then((value) async {

        if (value.isSuccess!) {
          final commonApi =
              Provider.of<CommonApiProvider>(context, listen: false);
          await commonApi.selfApi(context);
          commonApi.notifyListeners();
          notifyListeners();
          companyName.text = userModel!.company!.name ?? "";
          companyMail.text = userModel!.company!.email ?? "";
          companyPhone.text = userModel!.company!.phone != null?userModel!.company!.phone.toString():"";
          dialCode = userModel!.company!.code ?? "";
          description.text = userModel!.company!.description ?? "";
          logo = userModel!.company!.media![0].originalUrl;
          areaData = "${userModel!.company!.primaryAddress!.area}, ${userModel!.company!.primaryAddress!.address}";
          area.text = userModel!.company!.primaryAddress!.area ?? "";
          street.text = userModel!.company!.primaryAddress!.address ?? "";
          city.text = userModel!.company!.primaryAddress!.city ?? "";
          zipCode.text = userModel!.company!.primaryAddress!.postalCode ?? "";

          latitude.text = userModel!.company!.primaryAddress!.latitude ?? "";
          longitude.text = userModel!.company!.primaryAddress!.longitude ?? "";
          int ind = countryList.indexWhere((element) =>
          element.id.toString() == userModel!.company!.primaryAddress!.countryId);
          if (ind >= 0) {
            country = countryList[ind];
            statesList = countryList[ind].state!;
            notifyListeners();

          }
          hideLoading(context);

          notifyListeners();
          print("country :$country");

          int stateInd = statesList.indexWhere((element) =>
          element.id.toString() == userModel!.company!.primaryAddress!.stateId);
          log("stateIndstateInd ;$stateInd");
          if (stateInd >= 0) {
            state = statesList[stateInd];
            notifyListeners();

          }
          notifyListeners();
          showDialog(
              context: context,
              builder: (context) => AlertDialogCommon(
                  title: appFonts.updateSuccessfully,
                  height: Sizes.s140,
                  image: eGifAssets.successGif,
                  subtext: language(context, appFonts.hurrayUpdateProfile),
                  bText1: language(context, appFonts.okay),
                  b1OnTap: () => route.pop(context)));
        } else {
          hideLoading(context);
          log("value.message :${value.message}");
          notifyListeners();
          snackBarMessengers(context,
              message: value.message, color: appColor(context).appTheme.red);
        }
      });
    } catch (e) {
      log("EEEE updateProfile:$e");
      hideLoading(context);
      notifyListeners();
    }
  }
}
