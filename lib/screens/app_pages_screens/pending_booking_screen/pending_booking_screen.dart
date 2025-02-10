import '../../../config.dart';
import '../../bottom_screens/booking_screen/booking_shimmer/booking_detail_shimmer.dart';

class PendingBookingScreen extends StatelessWidget {
  const PendingBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PendingBookingProvider>(builder: (context, value, child) {
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          value.onBack(context, false);
          if(didPop) return;
        },
        child: StatefulWrapper(
            onInit: () => Future.delayed(
                const Duration(milliseconds: 100), () => value.onReady(context)),
            child: LoadingComponent(
                child:value.bookingModel == null
                    ?   const BookingDetailShimmer()
                    :  Scaffold(
                    appBar: AppBarCommon(title: appFonts.pendingBooking,onTap: ()=> value.onBack(context, true)),
                    body: RefreshIndicator(
                        onRefresh: () async {
                          value.onRefresh(context);
                        },
                            child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  SingleChildScrollView(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                        StatusDetailLayout(
                                            data: value.bookingModel,
                                            onTapStatus: () => showBookingStatus(
                                                context, value.bookingModel)),
                                        if (value.isAmount)
                                          ServicemenPayableLayout(
                                              amount: value.amountCtrl.text),
                                        Text(
                                                language(context,
                                                    appFonts.billSummary),
                                                style: appCss.dmDenseMedium14
                                                    .textColor(appColor(context)
                                                        .appTheme
                                                        .darkText))
                                            .paddingOnly(
                                                top: Insets.i25,
                                                bottom: Insets.i10),
                                        CancelledBillSummary(
                                            bookingModel: value.bookingModel),
                                        const VSpace(Sizes.s20),
                                        if (value.bookingModel!.service!
                                                    .reviews !=
                                                null &&
                                            value.bookingModel!.service!.reviews!
                                                .isNotEmpty)
                                          ReviewListWithTitle(
                                              reviews: value.bookingModel!
                                                  .service!.reviews!)
                                      ]).paddingAll(Insets.i20))
                                      .paddingOnly(bottom: Insets.i100),
                                  Material(
                                      elevation: 20,
                                      child: BottomSheetButtonCommon(
                                              textOne: appFonts.reject,
                                              textTwo: appFonts.accept,
                                              clearTap: () =>
                                                  value.onRejectBooking(context),
                                              applyTap: () =>
                                                  value.onAcceptBooking(context))
                                          .paddingAll(Insets.i20)
                                          .decorated(
                                              color: appColor(context)
                                                  .appTheme
                                                  .whiteBg))
                                ]))))),
      );
    });
  }
}
