import 'dart:developer';

import '../../../../config.dart';

class AcceptedBookingBodyLayout extends StatelessWidget {
  const AcceptedBookingBodyLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AcceptedBookingProvider, AssignBookingProvider>(
        builder: (context1, value, assignValue, child) {
      return Stack(alignment: Alignment.bottomCenter, children: [
        SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          StatusDetailLayout(
              data: value.bookingModel,
              onTapStatus: () =>
                  showBookingStatus(context, value.bookingModel)),
          if (isFreelancer != true && value.amount != "0")
            ServicemenPayableLayout(amount: value.amount),
          Text(language(context, appFonts.billSummary),
                  style: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.darkText))
              .paddingOnly(top: Insets.i25, bottom: Insets.i10),
          AcceptBillSummary(bookingModel: value.bookingModel),
          const VSpace(Sizes.s20),
          if (value.bookingModel!.service!.reviews!.isNotEmpty)
            ReviewListWithTitle(reviews: value.bookingModel!.service!.reviews!)
        ]).padding(
                    horizontal: Insets.i20,
                    top: Insets.i20,
                    bottom: Insets.i100)),
        if (value.bookingModel!.bookingStatus!.slug == appFonts.pending ||
            value.bookingModel!.bookingStatus!.slug == appFonts.accepted)
          value.bookingModel!.servicemen != null &&
                  value.bookingModel!.servicemen!.isNotEmpty
              ? Container()
              : Material(
                  elevation: 20,
                  child: isFreelancer
                      ? BottomSheetButtonCommon(
                              textOne: appFonts.cancelService,
                              textTwo: appFonts.startService,
                              clearTap: () => assignValue.onCancel(context),
                              applyTap: () =>
                                  assignValue.onStartServicePass(context))
                          .paddingAll(Insets.i20)
                      : ButtonCommon(
                              title: appFonts.assignNow,
                              onTap: () => value.onAssignTap(context))
                          .paddingAll(Insets.i20))
      ]);
    });
  }
}
