import 'dart:developer';

import 'package:fixit_provider/config.dart';

class PackageDetailProvider with ChangeNotifier {
  ServicePackageModel? packageModel;
  double widget1Opacity =0.0;

  onReady(context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    packageModel = data;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500), () {
      widget1Opacity = 1;
      notifyListeners();
    });
  }

  onRefresh(context)async{
    showLoading(context);
    notifyListeners();
    await getServicePackageById(context, packageModel!.id);
    hideLoading(context);
    notifyListeners();
  }

  getServicePackageById(context, serviceId) async {
    try {
      await apiServices
          .getApi("${api.servicePackages}/$serviceId", []).then((value) {
        if (value.isSuccess!) {
          notifyListeners();

          packageModel = ServicePackageModel.fromJson(value.data[0]);
          notifyListeners();
        }

      });
    } catch (e) {

      log("ERRROEEE getServicePackageById : $e");
      notifyListeners();
    }
  }

  onBack(context,isBack) async {
    if(isBack){
      route.pop(context);
    }
    packageModel = null;
    widget1Opacity =0.0;
    notifyListeners();
  }


  //package delete confirmation
  onPackageDelete(context, sync) {
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);
    final package = Provider.of<PackageListProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.packageDelete,
        appFonts.deletePackages, appFonts.areYouSureDeletePackage, () {
      route.pop(context);
      package.deletePackage(context, packageModel!.id);
    });
    value.notifyListeners();
  }
}
