import 'dart:developer';

import 'package:fixit_provider/config.dart';

class ServicemenDetailProvider with ChangeNotifier {
  XFile? imageFile;
  int? id;
  bool isIcons = true;
  ServicemanModel? servicemanModel;
  double widget1Opacity =0.0;

  //page init data fetch
  onReady(context)async {
    dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
    log("data :$data");
    notifyListeners();
    if (data != null) {
      isIcons = data['isShow'] ?? true;
      id = data["detail"];
    await  getServicemenById(context);
      Future.delayed(const Duration(milliseconds: 500), () {
        widget1Opacity = 1;
        notifyListeners();
      });
    }else{
      widget1Opacity = 1;
      notifyListeners();
    }

    notifyListeners();
  }

  onBack(context,isBack) async {
    if(isBack){
      route.pop(context);
    }
    servicemanModel = null;
    widget1Opacity =0.0;
    notifyListeners();
  }

  // GET IMAGE FROM GALLERY
  Future getImage(context, source) async {
    final ImagePicker picker = ImagePicker();
    route.pop(context);
    imageFile = (await picker.pickImage(source: source,imageQuality: 70))!;
    notifyListeners();
  }

  //edit servicemane detail
  editServicemanDetail(context) {

    route.pushNamed(context, routeName.addServicemen,arg: servicemanModel).then((e)=>getServicemenById(context));
  }

  onRefresh(context)async{
    showLoading(context);
    notifyListeners();
    await getServicemenById(context,);
    hideLoading(context);
    notifyListeners();
  }

  //get serviceman id
  getServicemenById(context) async {
    try {
      await apiServices.getApi("${api.serviceman}/$id", [],isData: true).then((value) {

        if (value.isSuccess!) {
          log("data : ${value.data}");
          servicemanModel = ServicemanModel.fromJson(value.data);
        }
        notifyListeners();
      });
    } catch (e) {
      log("ERRROEEE getServicemenById : $e");
      notifyListeners();
    }
  }

  onServicemenDelete(context, sync) {
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.servicemen,
        appFonts.deleteServicemen, appFonts.areYouSureDeleteServicemen, () {
      route.pop(context);
    deleteServiceman(context);
    });
    value.notifyListeners();
  }

  //delete Serviceman
  deleteServiceman(context, {isBack = false}) async {
    showLoading(context);

    try {
      await apiServices
          .deleteApi("${api.serviceman}/$id", {}, isToken: true)
          .then((value) {
        hideLoading(context);

        notifyListeners();
        if (value.isSuccess!) {
          final common = Provider.of<UserDataApiProvider>(context, listen: false);
          common.getServicemenByProviderId();

          final delete =
          Provider.of<DeleteDialogProvider>(context, listen: false);
          delete.onResetPass(
              context,
              language(context, appFonts.hurrayServicemenDelete),
              language(context, appFonts.okay), () {
            route.pop(context);
            route.pop(context);
          }, title: appFonts.deleteSuccessfully);
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
