import 'dart:developer';

import '../../config.dart';

class PendingBookingProvider with ChangeNotifier {
  BookingModel? bookingModel;
  String? id;
  TextEditingController reasonCtrl = TextEditingController();
  TextEditingController amountCtrl = TextEditingController();
  FocusNode reasonFocus = FocusNode();
  FocusNode amountFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> amountFormKey = GlobalKey<FormState>();

  bool isServicemen = false, isAmount = false, isNotify = false;

  onReady(context) {
    notifyListeners();
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    id = data.toString();
    getBookingDetailById(context, data);
    notifyListeners();
  }

  onRefresh(context) async {
    showLoading(context);
    notifyListeners();
    await getBookingDetailById(context, bookingModel!.id);
    hideLoading(context);
    notifyListeners();
  }

  onBack(context, isBack) {
    bookingModel = null;
    notifyListeners();
    if (isBack) {
      route.pop(context);
    }
  }

  //booking detail by id
  getBookingDetailById(context, id) async {
    try {
      await apiServices
          .getApi("${api.booking}/$id", [], isToken: true, isData: true)
          .then((value) {
        if (value.isSuccess!) {
          notifyListeners();
          debugPrint("BOOKING DATA : ${value.data}");
          bookingModel = BookingModel.fromJson(value.data);
          notifyListeners();
        }
      });

      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  onRejectBooking(context) {
    showDialog(
        context: context,
        builder: (context1) => AppAlertDialogCommon(
            isField: true,
            validator: (value) => validation.commonValidation(context, value),
            focusNode: reasonFocus,
            controller: reasonCtrl,
            title: appFonts.reasonOfRejectBooking,
            singleText: appFonts.send,
            globalKey: formKey,
            singleTap: () {
              if (formKey.currentState!.validate()) {
                updateStatus(context, bookingModel!.id, isCancel: true);
              }
              notifyListeners();
            })).then((value) {
      reasonCtrl.text = "";
      notifyListeners();
    });
  }

  //update status
  updateStatus(context, id, {isCancel = false, isBack = false}) async {
    try {
      showLoading(context);
      notifyListeners();
      dynamic data;
      if (isCancel) {
        data = {"reason": reasonCtrl.text, "booking_status": appFonts.cancel};
      } else {
        data = {"booking_status": appFonts.accepted};
      }

      log("DATA :$data");
      await apiServices
          .putApi("${api.booking}/$id", data, isToken: true, isData: true)
          .then((value) {
        hideLoading(context);
        notifyListeners();
        if (value.isSuccess!) {
          bookingModel = BookingModel.fromJson(value.data);
          final userApi =
              Provider.of<UserDataApiProvider>(context, listen: false);
          userApi.getBookingHistory(context);
          userApi.notifyListeners();
          if (isCancel) {
            reasonCtrl.text = "";
            notifyListeners();
            if (isBack) {
              route.pop(context);
            } else {
              route.pop(context);
            }
            route.pushNamed(context, routeName.cancelledBooking,
                arg: bookingModel!.id);
          } else {
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
                      BookingModel booking = bookingModel!;
                      notifyListeners();
                      if (isBack == false) {
                        route.pop(context);
                        route.pop(context);
                      } else {
                        route.pop(context);
                      }
                      route.pushNamed(context, routeName.acceptedBooking,
                          arg: booking.id);
                    }));
          }
        } else {
          snackBarMessengers(context, message: value.message);
        }
      });
    } catch (e) {
      hideLoading(context);
      snackBarMessengers(context, message: e.toString());
      notifyListeners();
    }
  }

  //accept booking
  onAcceptBooking(context) {
    updateStatus(context, bookingModel!.id);
  }
}
