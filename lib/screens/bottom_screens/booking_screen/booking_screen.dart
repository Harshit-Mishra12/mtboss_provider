import 'dart:developer';

import 'package:fixit_provider/screens/bottom_screens/booking_screen/booking_shimmer/booking_shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../config.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer4<HomeProvider, BookingProvider, UserDataApiProvider,
            DashboardProvider>(
        builder: (context1, home, value, userApi, dash, child) {
      log("isFreelancer::$isFreelancer");
      return StatefulWrapper(
          onInit: () => Future.delayed(
              const Duration(milliseconds: 50), () => value.onReady(context)),
          child: LoadingComponent(
            child: value.widget1Opacity == 0.0
                ? const BookingShimmer()
                : Scaffold(
                    appBar: AppBar(
                        leadingWidth: 0,
                        centerTitle: false,
                        title: Text(language(context, appFonts.bookings),
                            style: appCss.dmDenseBold18.textColor(
                                appColor(context).appTheme.darkText)),
                        actions: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              CommonArrow(
                                      arrow: eSvgAssets.filter,
                                      onTap: () => value.onTapFilter(context))
                                  .paddingAll(Insets.i4),
                              if (value.totalCountFilter() != "0")
                                Container(
                                        child: Text(value.totalCountFilter(),
                                                style: appCss.dmDenseMedium8
                                                    .textColor(appColor(context)
                                                        .appTheme
                                                        .whiteColor))
                                            .paddingAll(Insets.i5))
                                    .decorated(
                                        color: appColor(context).appTheme.red,
                                        shape: BoxShape.circle)
                                    .paddingOnly(
                                        top: Insets.i2, left: Insets.i2),
                            ],
                          ),
                          CommonArrow(
                                  arrow: eSvgAssets.chat,
                                  onTap: () => route.pushNamed(
                                      context, routeName.chatHistory))
                              .paddingSymmetric(horizontal: Insets.i10),
                          CommonArrow(
                              arrow: eSvgAssets.notification,
                              onTap: () => route.pushNamed(
                                  context, routeName.notification)),
                          const HSpace(Sizes.s20)
                        ]),
                    body: RefreshIndicator(
                        onRefresh: () async {
                          userApi.getBookingHistory(context);
                        },
                        child: value.isSearchData
                            ? EmptyLayout(
                                title: appFonts.noMatching,
                                subtitle: appFonts.attemptYourSearch,
                                buttonText: appFonts.refresh,
                                isButton: true,
                                isBooking: true,
                                bTap: () {
                                  Fluttertoast.showToast(
                                      msg:
                                          "${language(context, appFonts.refresh)}...");
                                  userApi.getBookingHistory(context);
                                },
                                widget: Stack(children: [
                                  Image.asset(eImageAssets.noSearch,
                                          height: Sizes.s346)
                                      .paddingOnly(top: Insets.i40),
                                ]))
                            : SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                    SearchTextFieldCommon(
                                        focusNode: value.searchFocus,
                                        hinText: language(context,
                                            appFonts.searchWithBookingId),
                                        controller: value.searchCtrl,
                                        onChanged: (v) {
                                          if (v.isEmpty) {
                                            userApi.getBookingHistory(context,
                                                search: value.searchCtrl.text);
                                            userApi.notifyListeners();
                                          } else if (v.length > 2) {
                                            userApi.getBookingHistory(context,
                                                search: value.searchCtrl.text);
                                          }
                                        },
                                        onFieldSubmitted: (v) =>
                                            userApi.getBookingHistory(context,
                                                search: v)),
                                    Text(language(context, appFonts.allBooking),
                                            style: appCss.dmDenseMedium18
                                                .textColor(appColor(context)
                                                    .appTheme
                                                    .darkText))
                                        .paddingOnly(
                                            top: Insets.i25,
                                            bottom: Insets.i15),
                                    if (isFreelancer != true &&
                                        isServiceman != true)
                                      Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                            SizedBox(
                                                width: Sizes.s200,
                                                child: Text(
                                                    language(
                                                        context,
                                                        appFonts
                                                            .onlyViewBookings),
                                                    style: appCss
                                                        .dmDenseMedium12
                                                        .textColor(value
                                                                .isAssignMe
                                                            ? appColor(context)
                                                                .appTheme
                                                                .primary
                                                            : appColor(context)
                                                                .appTheme
                                                                .darkText))),
                                            FlutterSwitchCommon(
                                                value: value.isAssignMe,
                                                onToggle: (val) => value
                                                    .onTapSwitch(val, context))
                                          ])
                                          .paddingAll(Insets.i15)
                                          .boxShapeExtension(
                                              color: value.isAssignMe
                                                  ? appColor(context)
                                                      .appTheme
                                                      .primary
                                                      .withOpacity(0.15)
                                                  : appColor(context)
                                                      .appTheme
                                                      .fieldCardBg,
                                              radius: AppRadius.r10)
                                          .paddingOnly(bottom: Insets.i20),
                                    if (isFreelancer != true)
                                      value.bookingList.isNotEmpty
                                          ? Column(children: [
                                              ...value.bookingList
                                                  .asMap()
                                                  .entries
                                                  .map((e) => BookingLayout(
                                                      data: e.value,
                                                      onTap: () =>
                                                          value.onTapBookings(
                                                              e.value,
                                                              context)))
                                            ])
                                          : EmptyLayout(
                                              isButton: false,
                                              title: appFonts.ohhNoListEmpty,
                                              subtitle:
                                                  appFonts.yourBookingList,
                                              widget: Stack(children: [
                                                Image.asset(
                                                    isFreelancer
                                                        ? eImageAssets
                                                            .noListFree
                                                        : eImageAssets
                                                            .noBooking,
                                                    height: Sizes.s306)
                                              ])),
                                    if (isFreelancer == true)
                                      value.bookingList.isNotEmpty
                                          ? Column(
                                              children: [
                                                ...value.bookingList
                                                    .asMap()
                                                    .entries
                                                    .map((e) {
                                                  // log("freelancerBookingList::${e.value.bookingStatus!.name}");
                                                  return BookingLayout(
                                                      data: e.value,
                                                      onTap: () =>
                                                          home.onTapBookings(
                                                              e.value,
                                                              context));
                                                })
                                              ],
                                            )
                                          : EmptyLayout(
                                              isButton: false,
                                              title: appFonts.ohhNoListEmpty,
                                              subtitle:
                                                  appFonts.yourBookingList,
                                              widget: Stack(children: [
                                                Image.asset(
                                                    isFreelancer
                                                        ? eImageAssets
                                                            .noListFree
                                                        : eImageAssets
                                                            .noBooking,
                                                    height: Sizes.s306)
                                              ])),
                                  ]).padding(
                                    horizontal: Insets.i20,
                                    top: Insets.i15,
                                    bottom: Insets.i100))
                        /*  : EmptyLayout(
                              isButton: false,
                              title: appFonts.ohhNoListEmpty,
                              subtitle: appFonts.yourBookingList,
                              widget: Stack(children: [
                                Image.asset(
                                    isFreelancer
                                        ? eImageAssets.noListFree
                                        : eImageAssets.noBooking,
                                    height: Sizes.s306)
                              ])),*/
                        )),
          ));
    });
  }
}
