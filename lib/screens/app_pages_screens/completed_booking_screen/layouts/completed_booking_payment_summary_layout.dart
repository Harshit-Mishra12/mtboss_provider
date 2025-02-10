
import '../../../../config.dart';

class CompletedBookingPaymentSummaryLayout extends StatelessWidget {
  final BookingModel? bookingModel;
  const CompletedBookingPaymentSummaryLayout({super.key, this.bookingModel});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage( appColor(context).appTheme.isDark ? eImageAssets.completedBg : eImageAssets.paymentSummary),
                fit: BoxFit.fill)),
        child: Column(children: [
          BillRowCommon(
              title: appFonts.paymentId, price: "#544"),
          BillRowCommon(
              title: appFonts.methodType,
              price:  capitalizeFirstLetter(bookingModel!.paymentMethod!))
              .paddingSymmetric(vertical: Insets.i20),
          BillRowCommon(
              title: appFonts.status,
              price: bookingModel!.paymentMethod! == "on_hand" && bookingModel!.bookingStatus!.slug == "completed" ? "Completed" : "Pending",
              style: appCss.dmDenseMedium14.textColor(
                  appColor(context).appTheme.online)),
        ]).paddingSymmetric(
            vertical: Insets.i20));
  }
}
