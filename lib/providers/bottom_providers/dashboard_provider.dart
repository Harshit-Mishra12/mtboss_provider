import 'dart:developer';

import 'package:fixit_provider/config.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';


class DashboardProvider with ChangeNotifier {
  bool expanded = false;
  int selectIndex = 0,backCounter=0;
  List<BlogModel> blogList = [];
  TextEditingController searchCtrl = TextEditingController();
  FocusNode searchFocus = FocusNode();

  onReady() async{
    position = LatLng(double.parse(userModel!.primaryAddress!.latitude!), double.parse(userModel!.primaryAddress!.longitude!));
    notifyListeners();
    zoneUpdate();
  }

  //on back
  onBack(context)async{
    if (selectIndex != 0) {
      selectIndex = 0;
      notifyListeners();
      Fluttertoast.showToast(msg: language(context, appFonts.pressBackAgain));
    } else {
      if (backCounter == 0) {
        Fluttertoast.showToast(msg:  language(context, appFonts.pressBackAgain));
        backCounter++;
        notifyListeners();
      } else {
        backCounter =0;
        notifyListeners();
        SystemNavigator.pop();
      }
    }
  }


  //update status
  zoneUpdate() async {
    log("position :$position");

    if(position != null) {
      Position   position1 = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(accuracy: LocationAccuracy.high)
      );
      log("AAAA ${userModel!.primaryAddress!.latitude} || ${position1.latitude}");
      if(position1.latitude != position!.latitude) {
        try {
          dynamic data = {
            "location": {"lat": position!.latitude, "lng": position!.longitude}
          };

          await apiServices
              .putApi(api.zoneUpdateOnLatLongChange, data, isToken: true, isData: true)
              .then((value) {
            if (value.isSuccess!) {
              log("SUCCCC");
            } else {
              log("SSS :${value.data} // ${value.message}");
            }
          });
        } catch (e) {
          log("EEEE zoneUpdate :$e");

          notifyListeners();
        }
      }
    }
  }

  onRefresh(context)async{
    final allUserApi = Provider.of<UserDataApiProvider>(context,listen: false);
    allUserApi.commonCallApi(context);
    final all = Provider.of<CommonApiProvider>(context,listen: false);
    all.commonApi(context);
  }


  onTap(index,context) async{
    selectIndex = index;
    expanded =true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    expanded =false;
    notifyListeners();
    if(selectIndex !=1){
      final book = Provider.of<BookingProvider>(context,listen: false);

      book.clearTap(context,isBack: false);
      final data =
      Provider.of<UserDataApiProvider>(context, listen: false);
      data.getBookingHistory(context);


    }
  }


  onExpand(data){
    data.isExpand = !data.isExpand;
    notifyListeners();
  }

  onAdd(context){

    if(isFreelancer) {
      route.pushNamed(context, routeName.addNewService);
    } else {
      showDialog(
          context: context, builder: (context) =>
          AlertDialog(
              insetPadding: EdgeInsets.zero,

              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppRadius.r8))),
              backgroundColor: appColor(context).appTheme.whiteBg,
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: appArray.dashBoardList
                      .asMap()
                      .entries
                      .map((e) =>
                      Column(
                          children: [
                            Row(
                                children: [
                                  SizedBox(
                                      height: Sizes.s15,
                                      width: Sizes.s15,
                                      child: SvgPicture.asset(
                                          e.value["image"]!,colorFilter: ColorFilter.mode(appColor(context).appTheme.darkText, BlendMode.srcIn),)).paddingAll(Insets
                                      .i4).decorated(color: appColor(context)
                                      .appTheme.fieldCardBg,
                                      shape: BoxShape.circle),
                                  const HSpace(Sizes.s12),
                                  Text(language(context, e.value["title"]),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: appCss.dmDenseMedium14.textColor(
                                          appColor(context).appTheme.darkText))
                                ]
                            ),
                            if(e.key != appArray.dashBoardList.length - 1)
                              const DividerCommon().paddingSymmetric(
                                  vertical: Insets.i15)
                          ]
                      ).inkWell(onTap: () {
                        final allUserApi = Provider.of<UserDataApiProvider>(context,listen: false);
                        allUserApi.commonCallApi(context);
                        final all = Provider.of<CommonApiProvider>(context,listen: false);
                        all.commonApi(context);
                        if (e.key == 0) {
                          route.pop(context);
                          route.pushNamed(context, routeName.addNewService);
                        } else {
                          route.pop(context);
                          route.pushNamed(context, routeName.addServicemen).then((e)=>  notifyListeners());
                        }
                      })).toList()
              ).padding(top: Sizes.s10)));
    }
  }

  final List<Widget> pages = [
    const HomeScreen(),

    const BookingScreen(),
    const WalletScreen(),
    const ProfileScreen()
  ];
}