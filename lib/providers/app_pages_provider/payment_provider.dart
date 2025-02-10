import 'dart:developer';
import 'package:fixit_provider/common/languages/ar.dart';

import '../../config.dart';

class PaymentProvider with ChangeNotifier {
  int? selectIndex;ScrollController scrollController = ScrollController();
  List<PaymentMethods> paymentList = [];
  SharedPreferences? preferences;
  dynamic method;
  double wallet = 0.0;
  bool isBottom = true,isTrial=false;


//select payment method option
  onSelectPaymentMethod(index, title) {
    selectIndex = index;
    method = title;
    notifyListeners();
  }

  onReady(context){
    dynamic arg = ModalRoute.of(context)!.settings.arguments ??false;
    isTrial = arg;
    paymentList = paymentMethods.where((element) => element.slug != "cash").toList();
    scrollController.addListener(listen);
    notifyListeners();
  }

  void listen() {
    if (scrollController.position.pixels >= 100) {
      hide();
      log("scrollController.position.pixels${scrollController.position.pixels}");
      notifyListeners();
    } else {
      show();
      log("scrollController.position.pixels${scrollController.position.pixels}");
      notifyListeners();
    }

    notifyListeners();
  }

  void show() {
    if (!isBottom) {
      isBottom = true;
      notifyListeners();
    }
  }

  void hide() {
    if (isBottom) {
      isBottom = false;
      notifyListeners();
    }
  }

  //subscription plan
  subscriptionPlan(context) async {

    try {
      showLoading(context);
      notifyListeners();
      var body = {
        "plan_id": userSubscribe!.id,
        "payment_method": method,
        "type": "subscription",
        "included_free_trial":isTrial,
        "currency_code":currency(context).currency!.code,
      };
      log("BODY :$body");

      await apiServices
          .postApi(api.subscriptionPlanCreate, body,
              isToken: true, isData: true)
          .then((value) {
        hideLoading(context);

        notifyListeners();

        if (value.isSuccess!) {
          route
              .pushNamed(context, routeName.checkoutWebView, arg: value.data)
              .then((e) async {
            if (e != null) {
              if (e['isVerify'] == true) {
                getVerifyPayment(value.data['item_id'],context);
                route.pop(context);
                route.pop(context);
                final commonApi =
                    Provider.of<CommonApiProvider>(context, listen: false);
                await commonApi.selfApi(context);

              }
            }
          });
        } else {
          route.pop(context);
          route.pop(context);
          snackBarMessengers(context,
              color: appColor(context).appTheme.red, message: value.message);
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
      log("EEEE subscriptionPlan : $e");
    }
  }

  //verify payment
  getVerifyPayment(data, context) async {
    try {

      await apiServices
          .getApi("${api.verifyPayment}?item_id=$data&type=subscription",
          {},
              isToken: true, isData: true)
          .then((value) {
        if (value.isSuccess!) {
          if (value.data["payment_status"].toString().toLowerCase() ==
              "pending") {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(milliseconds: 500),
              content: Text(language(context, appFonts.yourPaymentIsDeclined)),
              backgroundColor: appColor(context).appTheme.red,
            ));
          } else {
            showDialog(
                context: context,
                builder: (context) => AlertDialogCommon(
                    title: appFonts.updateSuccessfully,
                    height: Sizes.s140,
                    image: eGifAssets.successGif,
                    subtext: language(context, appFonts.successfullyComplete),
                    bText1: language(context, appFonts.okay),
                    b1OnTap: () => route.pop(context)));
           /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(language(context, appFonts.successfullyComplete)),
              backgroundColor: appColor(context).appTheme.green,
            ));*/
          }
        }
      });
    } catch (e) {
      notifyListeners();
    }
  }
}
