import 'dart:developer';

import '../../config.dart';

class BankDetailProvider with ChangeNotifier {
  String? branchValue;

  TextEditingController bankNameCtrl = TextEditingController();
  TextEditingController holderNameCtrl = TextEditingController();
  TextEditingController accountCtrl = TextEditingController();
  TextEditingController ifscCtrl = TextEditingController();
  TextEditingController swiftCtrl = TextEditingController();
  TextEditingController branchCtrl = TextEditingController();

  FocusNode bankNameFocus = FocusNode();
  FocusNode holdNameFocus = FocusNode();
  FocusNode accountFocus = FocusNode();
  FocusNode ifscFocus = FocusNode();
  FocusNode swiftFocus = FocusNode();
  FocusNode branchFocus = FocusNode();



//get Data
  getArg() {
    if(bankDetailModel != null) {
      bankNameCtrl.text = bankDetailModel!.bankName!;
      holderNameCtrl.text = bankDetailModel!.holderName!;
      accountCtrl.text = bankDetailModel!.accountNumber != null ? bankDetailModel!.accountNumber.toString() : "";
      ifscCtrl.text = bankDetailModel!.ifscCode!;
      swiftCtrl.text = bankDetailModel!.swiftCode!;
      branchCtrl.text = bankDetailModel!.branchName!;
    }
    notifyListeners();
  }

  //update bank detail api
  updateBankDetail(context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    showLoading(context);
    notifyListeners();

    var body = {
      "bank_name": bankNameCtrl.text,
      "holder_name": holderNameCtrl.text,
      "account_number": accountCtrl.text,
      "branch_name": branchCtrl.text,
      "ifsc_code": ifscCtrl.text,
      "swift_code": swiftCtrl.text,
    };

    try {
      await apiServices
          .putApi("${api.bankDetail}/${userModel!.id}", body, isToken: true)
          .then((value) async {
        hideLoading(context);

        notifyListeners();
        if (value.isSuccess!) {
          final userApi =
          Provider.of<UserDataApiProvider>(context, listen: false);
          userApi.getBankDetails();
          snackBarMessengers(context,
              message: value.message, color: appColor(context).appTheme.green);
        } else {
          log("value.message :${value.message}");
          snackBarMessengers(context,
              message: value.message, color: appColor(context).appTheme.red);
        }
      });
    } catch (e) {
      log("EEEE updateBankDetail:$e");
      hideLoading(context);
      notifyListeners();
    }
  }
}
