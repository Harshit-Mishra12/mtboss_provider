import 'package:fixit_provider/config.dart';
import 'package:fixit_provider/screens/app_pages_screens/completed_booking_screen/layouts/completed_booking_payment_summary_layout.dart';
import 'package:fixit_provider/screens/app_pages_screens/completed_booking_screen/layouts/service_proof_list.dart';

import '../../bottom_screens/booking_screen/booking_shimmer/booking_detail_shimmer.dart';

class CompletedBookingScreen extends StatelessWidget {
  const CompletedBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CompletedBookingProvider, AddServiceProofProvider>(
        builder: (context, value, s, child) {
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          value.onBack(context, false);
          if (didPop) return;
        },
        child: StatefulWrapper(
            onInit: () => Future.delayed(
                const Duration(milliseconds: 50), () => value.onReady(context)),
            child: LoadingComponent(
              child: value.bookingModel == null
                  ? const BookingDetailShimmer()
                  : Scaffold(
                      appBar: AppBarCommon(
                        title: appFonts.completedBookings,
                        onTap: () => value.onBack(context, true),
                      ),
                      body: RefreshIndicator(
                        onRefresh: () async {
                          value.onRefresh(context);
                        },
                        child:
                            Stack(alignment: Alignment.bottomCenter, children: [
                          SingleChildScrollView(
                              child: Column(children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StatusDetailLayout(
                                      data: value.bookingModel,
                                      onTapStatus: () => showBookingStatus(
                                          context, value.bookingModel)),
                                  Text(language(context, appFonts.billSummary),
                                          style: appCss.dmDenseMedium14
                                              .textColor(appColor(context)
                                                  .appTheme
                                                  .darkText))
                                      .paddingOnly(
                                          top: Insets.i25, bottom: Insets.i10),
                                  OngoingBillSummary(
                                      bookingModel: value.bookingModel),
                                  const VSpace(Sizes.s20),
                                  Text(
                                      language(
                                          context, appFonts.paymentSummary),
                                      style: appCss.dmDenseMedium14.textColor(
                                          appColor(context).appTheme.darkText)),
                                  const VSpace(Sizes.s10),
                                  CompletedBookingPaymentSummaryLayout(
                                      bookingModel: value.bookingModel),
                                  const VSpace(Sizes.s20),
                                  if (value
                                      .bookingModel!.serviceProofs!.isNotEmpty)
                                    Text(
                                            language(
                                                context, appFonts.serviceProof),
                                            overflow: TextOverflow.ellipsis,
                                            style: appCss.dmDenseBold18
                                                .textColor(appColor(context)
                                                    .appTheme
                                                    .darkText))
                                        .paddingOnly(bottom: Insets.i10),
                                  if (value.bookingModel!.serviceProofs !=
                                          null &&
                                      value.bookingModel!.serviceProofs!
                                          .isNotEmpty)
                                    ServiceProofList(
                                        bookingModel: value.bookingModel,
                                        onTap: (val) => value
                                            .addProofTap(context, data: val)),
                                  if (value.bookingModel!.serviceProofs !=
                                          null &&
                                      value.bookingModel!.serviceProofs!
                                          .isNotEmpty)
                                    const VSpace(Sizes.s20),
                                  if (value.bookingModel!.service!.reviews !=
                                          null &&
                                      value.bookingModel!.service!.reviews!
                                          .isNotEmpty)
                                    ReviewListWithTitle(
                                        reviews: value
                                            .bookingModel!.service!.reviews!)
                                ]).paddingAll(Insets.i20)
                          ]).paddingOnly(bottom: Insets.i100)),
                          if (value.bookingModel!.servicemen!
                              .where((element) => element.id == userModel!.id)
                              .isNotEmpty)
                            Material(
                                elevation: 20,
                                child: value.bookingModel!.serviceProofs!.isNotEmpty
                                    ? ButtonCommon(
                                            onTap: () =>
                                                value.addProofTap(context),
                                            title: appFonts.addServiceProof,
                                            style: appCss.dmDenseRegular16.textColor(appColor(context)
                                                .appTheme
                                                .primary),
                                            color: appColor(context)
                                                .appTheme
                                                .trans,
                                            borderColor: appColor(context)
                                                .appTheme
                                                .primary)
                                        .paddingAll(Insets.i20)
                                        .decorated(
                                            color: appColor(context)
                                                .appTheme
                                                .whiteBg)
                                    : ButtonCommon(onTap: () => value.addProofTap(context), title: appFonts.addServiceProof)
                                        .paddingAll(Insets.i20)
                                        .decorated(color: appColor(context).appTheme.whiteBg))
                        ]),
                      )),
            )),
      );
    });
  }
}
