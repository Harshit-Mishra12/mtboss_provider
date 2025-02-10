import '../../../config.dart';
import '../../bottom_screens/booking_screen/booking_shimmer/booking_detail_shimmer.dart';

class CancelledBookingScreen extends StatelessWidget {
  const CancelledBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CancelledBookingProvider>(builder: (context, value, child) {
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          value.onBack(context, false);
          if (didPop) return;
        },
        child: StatefulWrapper(
            onInit: () => Future.delayed(
                const Duration(milliseconds: 50), () => value.onReady(context)),
            child: value.bookingModel == null
                ? const BookingDetailShimmer()
                : Scaffold(
                    appBar: AppBarCommon(
                      title: appFonts.cancelledBookings,
                      onTap: () => value.onBack(context, true),
                    ),
                    body: RefreshIndicator(
                      onRefresh: () async {
                        value.onRefresh(context);
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                StatusDetailLayout(
                                    data: value.bookingModel,
                                    onTapStatus: () => showBookingStatus(
                                        context, value.bookingModel)),
                                Text(language(context, appFonts.billSummary),
                                        style: appCss.dmDenseMedium14.textColor(
                                            appColor(context)
                                                .appTheme
                                                .darkText))
                                    .paddingOnly(
                                        top: Insets.i25, bottom: Insets.i10),
                                CancelledBillSummary(
                                  bookingModel: value.bookingModel,
                                ),
                                const VSpace(Sizes.s20),
                              ]).padding(
                                  horizontal: Insets.i20,
                                  top: Insets.i20,
                                  bottom: Insets.i100)),
                          Material(
                              elevation: 20,
                              child: AssignStatusLayout(
                                  status: appFonts.reason,
                                  title: isFreelancer
                                      ? appFonts.youChangedTimeSlot
                                      : appFonts.servicemenIsNotAvailable))
                        ],
                      ),
                    ))),
      );
    });
  }
}
