import 'dart:convert';
import 'dart:developer';

import 'package:fixit_provider/config.dart';

import '../../firebase/firebase_api.dart';

class LoginAsProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> providerKey =
      GlobalKey<FormState>(debugLabel: 'providerKey');
  SharedPreferences? pref;
  bool isPassword = true;
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  // password see tap
  passwordSeenTap() {
    isPassword = !isPassword;
    notifyListeners();
  }

  demoCreds() {
    emailController.text = "provider@example.com";
    passwordController.text = "123456789";
    notifyListeners();
  }

  //login
  login(context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      pref = await SharedPreferences.getInstance();
      String token = await getFcmToken();

      showLoading(context);
      notifyListeners();

      var body = {
        "email": emailController.text,
        "password": passwordController.text,
        "fcm_token": token
      };

      try {
        await apiServices
            .postApi(api.login, jsonEncode(body))
            .then((value) async {
          notifyListeners();
          if (value.isSuccess!) {
            log("value.isSuccess:${value.isSuccess}");
            final commonApi =
                Provider.of<CommonApiProvider>(context, listen: false);
            await commonApi.selfApi(context);
            dynamic userData = pref!.getString(session.user);
            if (userModel!.role!.name != "user") {
              if (userData != null) {
                log("userDatahjuhjo:$userData");
                final commonApi =
                    Provider.of<CommonApiProvider>(context, listen: false);
                await commonApi.selfApi(context);
                final userApi =
                    Provider.of<UserDataApiProvider>(context, listen: false);
                await userApi.homeStatisticApi();
                if (!isFreelancer) {
                  await userApi.getServicemenByProviderId();
                }
                final locationCtrl =
                    Provider.of<LocationProvider>(context, listen: false);

                locationCtrl.getUserCurrentLocation(context);
                await userApi.getBankDetails();
                await userApi.getDocumentDetails();
                await userApi.getAddressList(context);
                await userApi.getNotificationList();
                await userApi.getPopularServiceList();
                await userApi.getJobRequest();
                await userApi.getServicePackageList();
                await userApi.getAllServiceList();
                await userApi.getBookingHistory(context);
                userApi.statisticDetailChart();
                FirebaseApi().onlineActiveStatusChange(false);
              }
              hideLoading(context);

              route.pushReplacementNamed(context, routeName.dashboard);
              emailController.text = "";
              passwordController.text = "";
              notifyListeners();
            } else {
              hideLoading(context);
              snackBarMessengers(context,
                  message: "This action is unauthorized for users.",
                  color: appColor(context).appTheme.red);
            }
          } else {
            hideLoading(context);
            snackBarMessengers(context,
                message: value.message, color: appColor(context).appTheme.red);
          }
        });
      } catch (e) {
        hideLoading(context);
        notifyListeners();
        log("EEEE login : $e");
      }
    }
  }
}
