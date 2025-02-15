import 'dart:developer';

import 'package:fixit_provider/config.dart';

class ServiceDetailsProvider with ChangeNotifier {
  int selectedIndex = 0, selected = -1;
  String? selectedImage;
  String? id;
  Services? services;
  List<ServiceFaqModel> serviceFaq = [];

  List<ZoneModel> zoneList = [];

  List locationList = [];
  double widget1Opacity = 0.0;

  //image index select and set in key
  onImageChange(index, value) {
    selectedIndex = index;
    selectedImage = value;

    notifyListeners();
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

  // on page init data fetch
  onReady(context) async {
    dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
    log("data :$data");
    notifyListeners();
    if (data != null) {
      id = data["detail"].toString();
      await getServiceId(context);
      await getServiceFaqId(context, id);
    } else {
      hideLoading(context);
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      widget1Opacity = 1;
      notifyListeners();
    });
    notifyListeners();
  }

  onRefresh(context) async {
    showLoading(context);
    notifyListeners();
    await getServiceId(context);
    await getServiceFaqId(context, id);
    hideLoading(context);
    notifyListeners();
  }

  onBack(context, isBack) {
    services = null;
    serviceFaq = [];
    selectedIndex = 0;
    id = "";
    widget1Opacity = 0.0;
    notifyListeners();

    if (isBack) {
      route.pop(context);
    }
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

  //get service by id
  getServiceId(context) async {
    log("DDDD :$id");
    try {
      log("dshfdjg :${"${api.providerServices}?service_id=$id"}");
      await apiServices
          .getApi("${api.providerServices}?service_id=$id", [], isToken: true)
          .then((value) {
        if (value.isSuccess!) {
          services = Services.fromJson(value.data);
          log("services:::$services");
        }
        if (services!.media != null && services!.media!.isNotEmpty) {
          selectedImage = services!.media![0].originalUrl!;
          log("services!.media::${services!.media![0].originalUrl}");
        }
        notifyListeners();
      });
    } catch (e) {
      log("ERRROEEE getServiceId : $e");
      hideLoading(context);
      notifyListeners();
    }
  }

/*[log] BODY :{type: fixed, title: ar title, thumbnail: Instance of 'MultipartFile', provider_id: 3, price: 80, discount: 0, tax_id: 1, duration: 1, duration_unit
: ساعة, description: njj hello ar, required_servicemen: 2, is_featured: 1, per_serviceman_commission: 2,
 destination_location: {lat: 21.1983277, lng: 72.7961031, area: Adajan, address: Adajan, 324, state_id: 12,
 country_id: 356, postal_code: 395009, city: Surat}, faqs: [], isMultipleServiceman: 0, status: 0, category_id[0]: 8, category_id[1]: 7}
*/
  // delete service confirmation
  onServiceDelete(context, sync) {
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);
    value.onDeleteDialog(sync, context, eImageAssets.service,
        translations!.deleteService, translations!.areYouSureDeleteService, () {
      route.pop(context);
      deleteService(context);

      notifyListeners();
    });
    value.notifyListeners();
  }

  //delete Service
  deleteService(context, {isBack = false}) async {
    showLoading(context);

    try {
      await apiServices
          .deleteApi("${api.service}/$id", {}, isToken: true)
          .then((value) {
        hideLoading(context);

        notifyListeners();
        if (value.isSuccess!) {
          final common =
              Provider.of<UserDataApiProvider>(context, listen: false);
          common.getPopularServiceList();

          final delete =
              Provider.of<DeleteDialogProvider>(context, listen: false);

          delete.onResetPass(
              context,
              language(context, translations!.hurrayServiceDelete),
              language(context, translations!.okay), () {
            route.pop(context);
            route.pop(context);
          });
          notifyListeners();
        } else {
          snackBarMessengers(context,
              color: appColor(context).appTheme.red, message: value.message);
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
      log("EEEE deleteService : $e");
    }
  }

  // add address in service availability
  addAddressInService(context) {
    route
        .pushNamed(context, routeName.locationList, arg: services!.id)
        .then((e) async {
      getServiceId(context);
      final userApi = Provider.of<UserDataApiProvider>(context, listen: false);
      userApi.getAddressList(context);
    });
  }

  // delete location confirmation
  onTapDetailLocationDelete(id, context, sync, index) {
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.location,
        translations!.delete, translations!.areYiuSureDeleteLocation, () {
      route.pop(context);
      services!.serviceAvailabilities!.removeAt(index);
      deleteAvailabilityService(context, id);
      notifyListeners();
    });
    value.notifyListeners();

    notifyListeners();
  }

  //delete availability service
  deleteAvailabilityService(context, serviceAvailabilityId) async {
    showLoading(context);

    try {
      await apiServices
          .deleteApi("${api.deleteServiceAddress}/$serviceAvailabilityId", {},
              isToken: true)
          .then((value) {
        hideLoading(context);

        notifyListeners();
        if (value.isSuccess!) {
          getServiceId(context);
          notifyListeners();
        } else {
          snackBarMessengers(context,
              color: appColor(context).appTheme.red, message: value.message);
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
      log("EEEE deleteServiceman : $e");
    }
  }
}
