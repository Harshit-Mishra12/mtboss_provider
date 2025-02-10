import 'dart:developer';

import 'package:fixit_provider/config.dart';

class AssignBookingProvider with ChangeNotifier {
  BookingModel? bookingModel;
  bool isServicemen = false;
  String? amount, id;

  TextEditingController reasonCtrl = TextEditingController();
  FocusNode reasonFocus = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //on page init data fetch
  onReady(context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    isServicemen = userModel!.role!.name == "provider" ? false : true;

    id = data.toString();
    notifyListeners();
    getBookingDetailById(context);
  }

  onBack(context, isBack) {
    bookingModel = null;
    notifyListeners();
    if (isBack) {
      route.pop(context);
    }
  }

  onRefresh(context) async {
    showLoading(context);
    notifyListeners();
    await getBookingDetailById(context);
    hideLoading(context);
    notifyListeners();
  }

  //service start confirmation
  onStartServicePass(context) {
    showDialog(
        context: context,
        builder: (context1) {
          return AlertDialogCommon(
              title: appFonts.startService,
              image: eGifAssets.rocket,
              subtext: appFonts.areYouSureStartService,
              height: Sizes.s145,
              isTwoButton: true,
              firstBText: appFonts.cancel,
              secondBText: appFonts.yes,
              firstBTap: () => route.pop(context),
              secondBTap: () {
                route.pop(context);
                updateStatus(context, isAssign: false);
              });
        });
  }

  //booking detail by id
  getBookingDetailById(context) async {
    try {
      await apiServices
          .getApi("${api.booking}/$id", [], isToken: true, isData: true)
          .then((value) {
        if (value.isSuccess!) {
          notifyListeners();
          debugPrint("BOOKING DATA : ${value.data}");
          bookingModel = BookingModel.fromJson(value.data);
          notifyListeners();
        } else {
          notifyListeners();
        }
      });
    } catch (e) {
      log("EEEE :booo :$e");
      notifyListeners();
    }
  }

  //update status
  updateStatus(context, {isCancel = false, isAssign = true}) async {
    try {
      showLoading(context);
      notifyListeners();
      dynamic data;
      if (isCancel) {
        data = {"reason": reasonCtrl.text, "booking_status": appFonts.cancel};
      } else {
        data = {"booking_status": appFonts.ontheway};
      }
      log("DATA :$data");
      await apiServices
          .putApi("${api.booking}/${bookingModel!.id}", data,
              isToken: true, isData: true)
          .then((value) {
        log("DATA ss:${value.data} //${value.isSuccess} // ${value.message}");
        hideLoading(context);
        notifyListeners();
        if (value.isSuccess!) {
          bookingModel = BookingModel.fromJson(value.data);
          final userApi =
              Provider.of<UserDataApiProvider>(context, listen: false);
          userApi.getBookingHistory(context);
          userApi.notifyListeners();
          if (isCancel) {
            route.pop(context);
            route.pop(context);
            route.pushNamed(context, routeName.cancelledBooking,
                arg: bookingModel!.id);
          } else {
            log("isAssign :$isAssign");
            if (isAssign) {
              showDialog(
                  context: context,
                  builder: (context1) => AppAlertDialogCommon(
                      height: Sizes.s100,
                      title: appFonts.assignBooking,
                      firstBText: appFonts.doItLater,
                      secondBText: appFonts.yes,
                      image: eGifAssets.dateGif,
                      subtext: appFonts.doYouWant,
                      firstBTap: () => route.pop(context),
                      secondBTap: () {
                        route.pop(context);
                        route.pop(context);
                        route.pop(context);
                        route.pushNamed(context, routeName.ongoingBooking,
                            arg: bookingModel!.id);
                      }));
            } else {
              route.pop(context);
              route.pushNamed(context, routeName.ongoingBooking,
                  arg: bookingModel!.id);
            }
          }
        }
      });
    } catch (e) {
      log("EEEE update : $e");
      hideLoading(context);
      notifyListeners();
    }
  }

//cancel confirmation dialog
  onCancel(context) {
    showDialog(
        context: context,
        builder: (context1) {
          return AlertDialogCommon(
              isTwoButton: true,
              title: appFonts.cancelService,
              image: eGifAssets.error,
              subtext: appFonts.areYouSureCancelService,
              height: Sizes.s145,
              firstBTap: () => route.pop(context),
              secondBTap: () {
                route.pop(context);
                showDialog(
                    context: context,
                    builder: (context1) => AppAlertDialogCommon(
                          globalKey: formKey,
                          isField: true,
                          focusNode: reasonFocus,
                          validator: (val) =>
                              validation.commonValidation(context, val),
                          controller: reasonCtrl,
                          title: appFonts.reasonOfCancelBooking,
                          singleText: appFonts.send,
                          singleTap: () {
                            if (formKey.currentState!.validate()) {
                              updateStatus(context, isCancel: true);
                            }
                          },
                        ));
              },
              secondBText: appFonts.yes,
              firstBText: appFonts.cancel);
        });
  }
}
