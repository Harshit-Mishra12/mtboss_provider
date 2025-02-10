import 'dart:developer';
import 'package:fixit_provider/config.dart';


class AddExtraChargesProvider with ChangeNotifier {
  TextEditingController chargeTitleCtrl = TextEditingController();
  TextEditingController perServiceAmountCtrl = TextEditingController();
  FocusNode chargeTitleFocus = FocusNode();
  FocusNode perServiceAmountFocus = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  BookingModel? bookingModel;
  int val = 1;

  //on add service
  onAddService() {
    val++;
    notifyListeners();
  }


  //on remove service
  onRemoveService() {
    if(val > 1) {
      val--;
      notifyListeners();
    }
  }


  //add charges
  onAddCharge(context){
    if(formKey.currentState!.validate()) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context1) {
            return const UpdateBillSummaryBottom();
          });
    }
  }

  //on update bill
  onUpdateBill(context){
    addExtraServiceApi(context);

    notifyListeners();
  }

  //on page initialise data fetch
  onInit(context)async{
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    bookingModel = data;
    notifyListeners();
  }


  //add extra service api
  addExtraServiceApi(context,) async {

    try {
      showLoading(context);
      notifyListeners();

      var body = {
        "booking_id": bookingModel!.id,
        "title" : chargeTitleCtrl.text,
        "per_service_amount" : int.parse(perServiceAmountCtrl.text) * val,
        "no_service_done": val,
        "payment_method":bookingModel!.paymentMethod
      };

      log("BODY L$body");
      await apiServices
          .postApi(api.addExtraServiceCharge, body, isToken: true)
          .then((value) async {
        hideLoading(context);
        notifyListeners();
        log("SHHHH :${value.isSuccess}");
        if (value.isSuccess!) {
          final userApi =
          Provider.of<OngoingBookingProvider>(context, listen: false);
          await userApi.getBookingDetailById(context, bookingModel!.id);
          snackBarMessengers(context,
              message: value.message, color: appColor(context).appTheme.primary);
          route.pop(context);
      chargeTitleCtrl.text ="";
          perServiceAmountCtrl.text ="";
          val =1;
          route.pop(context);
          notifyListeners();

        } else {
          final userApi =
          Provider.of<OngoingBookingProvider>(context, listen: false);
          await userApi.getBookingDetailById(context, bookingModel!.id);
          route.pop(context);
          snackBarMessengers(context,
              message: value.message, color: appColor(context).appTheme.red);
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
      log("EEEE addExtraServiceApi : $e");
    }
  }

}
