import 'dart:developer';

import 'package:fixit_provider/config.dart';
import 'package:fixit_provider/screens/bottom_screens/profile_screen/layouts/logout_alert.dart';

class ProfileProvider with ChangeNotifier {
  List<ProfileModel> profileLists = [];
  SharedPreferences? preferences;
  ServicemanModel? servicemanModel;
  dynamic timeSlot;

  //on page init data fetch
  onReady(context) async {
    preferences = await SharedPreferences.getInstance();
    profileLists = isServiceman
        ? appArray.profileListAsServiceman
            .map((e) => ProfileModel.fromJson(e))
            .toList()
        : isFreelancer
            ? appArray.profileListAsFreelance
                .map((e) => ProfileModel.fromJson(e))
                .toList()
            : appArray.profileList
                .map((e) => ProfileModel.fromJson(e))
                .toList();
    notifyListeners();
    if (isServiceman) {
      getServicemenById(context);
    }
  }

//get serviceman id
  getServicemenById(context) async {
    try {
      await apiServices
          .getApi("${api.serviceman}/${userModel!.id}", [], isData: true)
          .then((value) {
        if (value.isSuccess!) {
          servicemanModel = ServicemanModel.fromJson(value.data);
        }
        notifyListeners();
      });
    } catch (e) {
      log("ERRROEEE11 getServicemenById : $e");

      notifyListeners();
    }
  }

  onTapSettingTap(context) {
    route.pushNamed(context, routeName.appSetting).then((val) {
      log("sss:");
      notifyListeners();
    });
  }

  //on delete account
  onDeleteAccount(context, sync) {
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);
    value.onDeleteAccount(sync, context);
    value.notifyListeners();
  }

  //logout alert confirmation
  onLogout(context) {
    showDialog(
      context: context,
      builder: (context) {
        return LogoutAlert(onTap: () async {
          final dash = Provider.of<DashboardProvider>(context, listen: false);
          dash.selectIndex = 0;
          dash.notifyListeners();
          preferences!.remove(session.user);
          preferences!.remove(session.accessToken);
          preferences!.remove(session.isLogin);
          preferences!.remove(session.isFreelancer);
          preferences!.remove(session.isServiceman);
          preferences!.remove(session.isLogin);
          userModel = null;
          userPrimaryAddress = null;
          provider = null;
          position = null;
          statisticModel = null;
          bankDetailModel = null;
          popularServiceList = [];
          servicePackageList = [];
          providerDocumentList = [];
          notificationList = [];
          notUpdateDocumentList = [];
          addressList = [];
          notifyListeners();
          route.pop(context);

          route.pushNamedAndRemoveUntil(context, routeName.intro);
        });
      },
    );
  }

  //profile list setting tap layout
  onTapOption(data, context, sync) {
    if (data.title == appFonts.companyDetails) {
      route.pushNamed(context, routeName.companyDetails);
    } else if (data.title == appFonts.bankDetails) {
      route.pushNamed(context, routeName.bankDetails);
    } else if (data.title == appFonts.idVerification) {
      route.pushNamed(context, routeName.idVerification);
    } else if (data.title == appFonts.timeSlots) {
      route.pushNamed(context, routeName.timeSlot);
    } else if (data.title == appFonts.myPackages) {
      route.pushNamed(context, routeName.packagesList);
    } else if (data.title == appFonts.commissionDetails) {
      route.pushNamed(context, routeName.commissionHistory);
    } else if (data.title == appFonts.myReview) {
      route.pushNamed(context, routeName.serviceReview,
          arg: {"isSetting": true});
    } else if (data.title == appFonts.subscriptionPlan) {
      route.pushNamed(context, routeName.planDetails);
    } else if (data.title == appFonts.deleteAccount) {
      onDeleteAccount(context, sync);
      notifyListeners();
    } else if (data.title == appFonts.logOut) {
      onLogout(context);
    } else if (data.title == appFonts.serviceLocation) {
      route.pushNamed(context, routeName.companyDetails);
    } else if (data.title == appFonts.serviceman) {
      route.pushNamed(context, routeName.servicemanList);
    } else if (data.title == appFonts.services) {
      route.pushNamed(context, routeName.serviceList);
    }
  }
}
