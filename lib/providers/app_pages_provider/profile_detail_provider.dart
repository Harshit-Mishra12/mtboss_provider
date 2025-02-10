import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../config.dart';
import '../../widgets/country_picker_custom/layouts/country_list_layout.dart';

class ProfileDetailProvider with ChangeNotifier {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController locationCtrl = TextEditingController();
  TextEditingController description = TextEditingController();

  String dialCode = '+91';
  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode location = FocusNode();
  final FocusNode descriptionFocus = FocusNode();

  XFile? imageFile;
  List<ValueItem<int>> languageSelect = [];

  SharedPreferences? preferences;
  PrimaryAddress? address;

  //page init data fetch
  getArgument(context) async {
    preferences = await SharedPreferences.getInstance();
    txtName.text = userModel!.name ?? "";
    txtEmail.text = userModel!.email ?? "";
    txtPhone.text = userModel!.phone != null ? userModel!.phone.toString() : "";
    if (userModel!.primaryAddress != null) {
      address = userModel!.primaryAddress!;
    }

    dialCode =
        "${userModel!.code != null && userModel!.code!.contains("+") ? "" : "+"}${userModel!.code}" ??
            "+91";
    description.text = userModel!.description ?? "";
    log("userModel!.knownLanguages! :${userModel!.knownLanguages}");
    userModel!.knownLanguages!.asMap().entries.forEach((element) {
      ValueItem<int> valueItem =
          ValueItem(label: element.value.key!, value: element.value.id);

      if (!languageSelect.contains(valueItem)) {
        languageSelect.add(valueItem);
      }
      notifyListeners();
    });
    if (userModel!.code != null) {
      int index = countriesEnglish.indexWhere(
          (element) => element['dial_code'] == "+${userModel!.code!}");
      // log("index :$index");
      if (index >= 0) {
        dialCode = countriesEnglish[index]['dial_code'];
      }
      log("dialCode :$dialCode");
    } else {
      dialCode = "+91";
    }
    if (address != null) {
      locationCtrl.text =
          "${address!.address} - ${address!.country!.name} - ${address!.state!.name}";
    }
    notifyListeners();
    log("languageSelect :$languageSelect");
  }

  onBack(context, isBack) {
    imageFile = null;
    txtName.text = "";
    txtEmail.text = "";
    txtPhone.text = "";
    notifyListeners();
    if (isBack == true) {
      route.pop(context);
    }
  }

  //update profile as per role
  onUpdate(context) {
    if (isServiceman) {
      editServiceman(context);
    } else {
      updateProfile(context);
    }
  }

  //edit serviceman
  editServiceman(context) async {
    showLoading(context);
    notifyListeners();
    List langList = [];

    for (var d in languageSelect) {
      if (!langList.contains(d.value)) {
        langList.add(d.value);
      }
    }
    dynamic mimeTypeData;
    if (imageFile != null) {
      mimeTypeData = lookupMimeType(imageFile!.path, headerBytes: [0xFF, 0xD8])!
          .split('/');
    }

    var body = {
      if (imageFile != null)
        "image": await dio.MultipartFile.fromFile(imageFile!.path.toString(),
            filename: imageFile!.name.toString(),
            contentType: MediaType(mimeTypeData[0], mimeTypeData[1])),
      "provider_id": userModel!.id,
      "name": txtName.text,
      "email": txtEmail.text,
      "phone": txtPhone.text,
      "code": dialCode,
      "known_languages": langList,
      "address": address!.address,
      "_method": "PUT"
    };

    log("EDIT :$body");

    dio.FormData formData = dio.FormData.fromMap(body);
    try {
      await apiServices
          .postApi("${api.serviceman}/${userModel!.id}", formData,
              isToken: true)
          .then((value) async {
        hideLoading(context);
        notifyListeners();
        log("SHHHH ");
        if (value.isSuccess!) {
          final commonApi =
              Provider.of<CommonApiProvider>(context, listen: false);
          await commonApi.selfApi(context);
          snackBarMessengers(context,
              message: value.message, color: appColor(context).appTheme.green);

          notifyListeners();

          route.pop(context);
        } else {
          final commonApi =
              Provider.of<CommonApiProvider>(context, listen: false);
          await commonApi.selfApi(context);
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
      log("CATCH editServiceman: $e");
    }
  }

  //language selection
  onLanguageSelect(options) {
    languageSelect = options;

    notifyListeners();
  }

  changeDialCode(CountryCodeCustom country) {
    dialCode = country.dialCode!;
    notifyListeners();
  }

// GET IMAGE FROM GALLERY
  Future getImage(context, source) async {
    final ImagePicker picker = ImagePicker();
    imageFile = (await picker.pickImage(source: source, imageQuality: 70));
    notifyListeners();
    if (imageFile != null) {
      // updateProfile(context);
      route.pop(context);
    }
  }

  showLayout(context) async {
    showDialog(
      context: context,
      builder: (context1) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.r12))),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(language(context, appFonts.selectOne),
                    style: appCss.dmDenseBold18
                        .textColor(appColor(context).appTheme.darkText)),
                const Icon(CupertinoIcons.multiply)
                    .inkWell(onTap: () => route.pop(context))
              ]),
              const VSpace(Sizes.s20),
              ...appArray.selectList
                  .asMap()
                  .entries
                  .map((e) => SelectOptionLayout(
                      data: e.value,
                      index: e.key,
                      list: appArray.selectList,
                      onTap: () {
                        if (e.key == 0) {
                          getImage(context, ImageSource.gallery);
                        } else {
                          getImage(context, ImageSource.camera);
                        }
                      }))
            ]));
      },
    );
  }

  //update profile
  updateProfile(context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    showLoading(context);
    notifyListeners();
    dynamic mimeTypeData;
    if (imageFile != null) {
      mimeTypeData = lookupMimeType(imageFile!.path, headerBytes: [0xFF, 0xD8])!
          .split('/');
    }

    var body = {
      "name": txtName.text,
      "email": txtEmail.text,
      "code": dialCode,
      "phone": txtPhone.text,
      "_method": "PUT",
      if (imageFile != null)
        'profile_image': imageFile != null
            ? await dio.MultipartFile.fromFile(imageFile!.path.toString(),
                filename: imageFile!.name.toString(),
                contentType: MediaType(mimeTypeData[0], mimeTypeData[1]))
            : null,
    };

    dio.FormData formData = dio.FormData.fromMap(body);

    log("BBBBB :$body");
    try {
      await apiServices
          .postApi(api.updateProfile, formData, isToken: true)
          .then((value) async {
        hideLoading(context);

        notifyListeners();
        if (value.isSuccess!) {
          final commonApi =
              Provider.of<CommonApiProvider>(context, listen: false);
          await commonApi.selfApi(context);
          commonApi.notifyListeners();
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
