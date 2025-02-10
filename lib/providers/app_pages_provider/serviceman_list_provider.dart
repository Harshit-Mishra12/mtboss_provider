import 'dart:developer';

import 'package:fixit_provider/config.dart';

class ServicemanListProvider with ChangeNotifier {
  double widget1Opacity = 0.0;
  List statusList = [];
  int selectIndex = 0;
  String? yearValue;
  List<ServicemanModel> searchList = [];
  String? expValue;
  TextEditingController categoryCtrl = TextEditingController();
  TextEditingController searchCtrl = TextEditingController();

  FocusNode searchFocus = FocusNode();
  FocusNode categoryFocus = FocusNode();

  //year selection option
  onTapYear(val) {
    yearValue = val;
    notifyListeners();
  }

  onReady(context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      widget1Opacity = 1;
      notifyListeners();
    });
  }

  //serviceman list as per experience filter selection
  onExperience(val, context) {
    log("HHHH :$val");
    expValue = val;
    notifyListeners();
    if (expValue == appFonts.allServicemen) {
      searchList = [];
      expValue = null;
      notifyListeners();
      getServicemenByProviderId(context);
    } else {

      getServicemenByProviderId(context);
    }
    log("expValue :$expValue");
  }

  //category add in and remove from list if already added
  onCategoryChange(context, id) {
    if (!statusList.contains(id)) {
      statusList.add(id);
    } else {
      statusList.remove(id);
    }
    notifyListeners();
  }

  //filer option select
  onFilter(index) {
    selectIndex = index;
    notifyListeners();
  }

  //filter bottom sheet open
  onTapFilter(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context) {
        return const ServicemenBookingFilterLayout();
      },
    );
  }

  //get serviceman by provider id
  getServicemenByProviderId(context, {val}) async {
    try {
      showLoading(context);
      if (val == null) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
      log("expValue ss:$expValue");
      String exp = expValue.toString().contains("highestExperience") ||
              expValue.toString().contains("highestServed")
          ? "high"
          : "low";
      String apiUrl = "";
      if (searchCtrl.text.isEmpty) {
        if (expValue != null) {
          if (expValue.toString().contains("highestExperience") ||
              expValue.toString().contains("lowestExperience")) {
            apiUrl =
                "${api.serviceman}?provider_id=${userModel!.id}&experience=$exp&search=${searchCtrl.text}";
          } else {
            apiUrl =
                "${api.serviceman}?provider_id=${userModel!.id}&served=$exp&search=${searchCtrl.text}";
          }
        } else {
          apiUrl = "${api.serviceman}?provider_id=${userModel!.id}";
        }
      } else {
        apiUrl =
            "${api.serviceman}?provider_id=${userModel!.id}&search=${searchCtrl.text}";
      }
      log("APPPP :$apiUrl");
      await apiServices.getApi(
        apiUrl,
        [],
      ).then((value) {
        if (value.isSuccess!) {
          List data = value.data;

          if(searchCtrl.text.isNotEmpty) {
            searchList = [];
            hideLoading(context);
            for (var list in data) {
              if (!searchList.contains(ServicemanModel.fromJson(list))) {
                searchList.add(ServicemanModel.fromJson(list));
              }
              notifyListeners();
            }
          }else{
            servicemanList =[];
            hideLoading(context);
            for (var list in data) {
              if (!servicemanList.contains(ServicemanModel.fromJson(list))) {
                servicemanList.add(ServicemanModel.fromJson(list));
              }
              notifyListeners();
            }
          }
        }

        notifyListeners();
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
    }
  }

  onBack(context, isBack) {
    searchCtrl.text = "";
    expValue = null;
    notifyListeners();
    if (isBack) {
      route.pop(context);
    }
    getServicemenByProviderId(context);
  }
}
