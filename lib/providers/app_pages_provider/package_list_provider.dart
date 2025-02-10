import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:fixit_provider/config.dart';

class PackageListProvider with ChangeNotifier {

  //package active status
  onToggle(index, val, context, id) {
    servicePackageList[index].status = val == true ? 1 :0;
    updateActiveStatusServicePackage(context, id, val, index);
    notifyListeners();
  }

  //package delete confirmation
  onPackageDelete(context, sync, id) {
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.packageDelete,
        appFonts.deletePackages, appFonts.areYouSureDeletePackage, () {
      route.pop(context);
      deletePackage(context, id);
    });
    value.notifyListeners();
  }

  //delete package
  deletePackage(context, id) async {
    showLoading(context);
    notifyListeners();
    try {
      await apiServices
          .deleteApi("${api.servicePackage}/$id", {}, isToken: true)
          .then((value) {
        hideLoading(context);

        notifyListeners();
        if (value.isSuccess!) {
          final common =
              Provider.of<UserDataApiProvider>(context, listen: false);
          common.getServicePackageList();

          final delete =
              Provider.of<DeleteDialogProvider>(context, listen: false);
          delete.onResetPass(
              context,
              language(context, appFonts.hurrayPackageDelete),
              language(context, appFonts.okay), () {
            route.pop(context);
            notifyListeners();
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
      log("EEEE deleteServiceman : $e");
    }
  }

  //update active status of service package
  updateActiveStatusServicePackage(context, id, val, index) async {
    showLoading(context);

    servicePackageList[index].status = val == true ? 1 :0;
    notifyListeners();
    editServicePackageApi(context, servicePackageList[index], val);
  }

//edit service package api
  editServicePackageApi(
      context, ServicePackageModel? servicePackageModel, val) async {
    showLoading(context);
    notifyListeners();

    try {
      var body = {
        "title": servicePackageModel!.title,
        "hexa_code": servicePackageModel.hexaCode!.contains("#") ? servicePackageModel!.hexaCode :"#${servicePackageModel.hexaCode}",
        "provider_id": userModel!.id,
        "price": servicePackageModel.price,
        "discount": servicePackageModel.discount,
        "description": servicePackageModel.description,
        "disclaimer":servicePackageModel.disclaimer,
        "is_featured": "1",
        "status": val == true ? "1" : 0,
        "_method": "PUT"
        , for (var i = 0; i < servicePackageModel.services!.length; i++)
          "service_id[$i]": servicePackageModel.services![i].id,

      };
      dio.FormData formData = dio.FormData.fromMap(body);

      await apiServices
          .postApi("${api.servicePackage}/${servicePackageModel.id}", formData,
          isToken: true)
          .then((value) async {
        hideLoading(context);
        notifyListeners();
        if (value.isSuccess!) {
          final userApi =
          Provider.of<UserDataApiProvider>(context, listen: false);
          await userApi.getServicePackageList();
          snackBarMessengers(context,
              message: value.message, color: appColor(context).appTheme.green);

          notifyListeners();

        } else {
          hideLoading(context);
          notifyListeners();
          final userApi =
          Provider.of<UserDataApiProvider>(context, listen: false);
          await userApi.getServicePackageList();
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
      log("EEEE updatestatus : $e");
    }
  }
}
