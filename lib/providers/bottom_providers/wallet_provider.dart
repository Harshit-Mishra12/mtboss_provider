import 'dart:developer';

import 'package:fixit_provider/config.dart';

class WalletProvider with ChangeNotifier {
  List<PaymentMethods> paymentList = [];
  String? wallet;
  double balance = 0.0;
  double servicemanBalance = 0.0;
  TextEditingController withDrawAmountCtrl = TextEditingController();
  TextEditingController messageCtrl = TextEditingController();
  ProviderWalletModel? providerWalletModel;
  ServicemanWalletModel? servicemanWalletModel;
  GlobalKey<FormState> withdrawKey = GlobalKey<FormState>();
  TextEditingController amountCtrl = TextEditingController();
  FocusNode amountFocus = FocusNode();
  FocusNode descFocus = FocusNode();

  //payment method select
  onTapGateway(val) {
    wallet = val;
    notifyListeners();
  }

  // on page init data fetch
  onReady(context) async {
    notifyListeners();
    log("paymentMethods :$paymentMethods");
    if (paymentMethods.isNotEmpty) {
      paymentList = paymentMethods;
    } else {
      final common = Provider.of<CommonApiProvider>(context, listen: false);
      await common.getPaymentMethodList();
    }
    paymentList.removeWhere((element) => element.slug == "cash");

    wallet = paymentList[0].slug;
    log("PAYE :$paymentList");
    notifyListeners();
  }

  //on add money wallet bottom sheet open
  onTapAdd(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context2) {
        return const AddMoneyLayout();
      },
    ).then((value) async {
      log("SSSS");
      amountCtrl.text = "";
      wallet = paymentList[0].slug;
      notifyListeners();
      final commonApi = Provider.of<CommonApiProvider>(context, listen: false);
      await commonApi.selfApi(context);
    });
  }

  //get wallet list
  getWalletList(context) async {
    final userApi = Provider.of<UserDataApiProvider>(context, listen: false);
    userApi.getWalletList(context);
    userApi.getServicemanWalletList(context);
  }

  //wallet withdraw request
  withdrawRequest(context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (withdrawKey.currentState!.validate()) {
      showLoading(context);
      notifyListeners();
      try {
        var body = {
          "amount": withDrawAmountCtrl.text,
          "message": messageCtrl.text,
          "payment_type": "bank"
        };

        notifyListeners();
        log("checkoutBody: $body");
        await apiServices
            .postApi(api.walletWithdrawRequest, body,
                isData: true, isToken: true)
            .then((value) async {
          hideLoading(context);
          notifyListeners();
          route.pop(context);
          if (value.isSuccess!) {
            log("MESs :${value.data}");
            await getWalletList(context);
            notifyListeners();
          } else {
            log("MES :${value.message}");
            snackBarMessengers(context,
                message: value.message, color: appColor(context).appTheme.red);
          }
        });
      } catch (e) {
        hideLoading(context);
        snackBarMessengers(context,
            message: e.toString(), color: appColor(context).appTheme.red);
        notifyListeners();
      }
    }
  }

  cancelTap(context) {
    amountCtrl.text = "";
    wallet = paymentList[0].slug;
    route.pop(context);
  }

  //add to wallet
  addToWallet(context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (int.parse(amountCtrl.text) >
        int.parse(appSettingModel!.providerCommissions!.minWithdrawAmount!)) {
      try {
        showLoading(context);
        notifyListeners();
        var body = {
          "amount": amountCtrl.text,
          "payment_method": wallet,
          "type": "wallet",
          "currency_code": currency(context).currency!.code,
        };

        notifyListeners();
        await apiServices
            .postApi(api.addMoneyToWallet, body, isData: true, isToken: true)
            .then((value) async {
          log("hszgfdhjsfg :${value.data} // ${value.message} // ${value.isSuccess}");
          hideLoading(context);
          notifyListeners();
          if (value.isSuccess!) {
            route
                .pushNamed(context, routeName.checkoutWebView, arg: value.data)
                .then((e) async {
              if (e != null) {
                if (e['isVerify'] == true) {
                  await getWalletList(context);
                  await getVerifyPayment(value.data['item_id'], context);
                  route.pop(context);
                } else {
                  route.pop(context);
                }
              } else {
                route.pop(context);
              }
            });
            notifyListeners();
          } else {
            hideLoading(context);
            notifyListeners();
            snackBarMessengers(context, message: value.message);
          }
        });
      } catch (e) {
        hideLoading(context);
        notifyListeners();
      }
    } else {
      snackBarMessengers(context,
          message:
              "More than ${getSymbol(context)}${appSettingModel!.providerCommissions!.minWithdrawAmount} amount can be withdraw");
    }
  }

  //verify payment
  getVerifyPayment(data, context) async {
    try {
      await apiServices
          .getApi("${api.verifyPayment}?item_id=$data&type=wallet", {},
              isToken: true, isData: true)
          .then((value) {
        log("SSS :${value.data} // ${value.isSuccess} // ${value.message}");
        if (value.isSuccess!) {
          if (value.data["payment_status"].toString().toLowerCase() ==
              "pending") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text(language(context, appFonts.yourPaymentIsDeclined)),
              backgroundColor: appColor(context).appTheme.red,
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text(language(context, appFonts.successfullyComplete)),
              backgroundColor: appColor(context).appTheme.primary,
            ));
          }
        }
      });
    } catch (e) {
      notifyListeners();
    }
  }
}
