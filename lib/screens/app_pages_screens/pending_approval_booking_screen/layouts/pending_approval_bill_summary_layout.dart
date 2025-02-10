import '../../../../config.dart';

class PendingApprovalBillSummary extends StatelessWidget {
  final BookingModel? bookingModel;

  const PendingApprovalBillSummary({super.key, this.bookingModel});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(appColor(context).appTheme.isDark
                    ? eImageAssets.bookingDetailBg
                    : eImageAssets.pendingApproval),
                fit: BoxFit.fill)),
        child: Column(children: [
          BillRowCommon(
              title: appFonts.perServiceCharge,
              price:
                  "${getSymbol(context)}${(currency(context).currencyVal * bookingModel!.perServicemanCharge!).ceilToDouble()}"),
          BillRowCommon(
                  title:
                  "${(bookingModel!.requiredServicemen != null ? bookingModel!.requiredServicemen! : 0) + (bookingModel!.totalExtraServicemen != null ? bookingModel!.totalExtraServicemen! : 0)} ${language(context, appFonts.serviceman)} (${getSymbol(context)}${(currency(context).currencyVal * bookingModel!.perServicemanCharge!).ceilToDouble()} × ${(bookingModel!.requiredServicemen != null ? bookingModel!.requiredServicemen! : 0) + (bookingModel!.totalExtraServicemen != null ? bookingModel!.totalExtraServicemen! : 0)})",
                  price:
                      "${getSymbol(context)}${(currency(context).currencyVal * bookingModel!.subtotal!).ceilToDouble()}",
                  style: appCss.dmDenseBold14
                      .textColor(appColor(context).appTheme.darkText))
              .paddingSymmetric(vertical: Insets.i20),
          if (bookingModel!.couponId != null)
            BillRowCommon(
                title:
                    "Coupon discount (${bookingModel!.coupon!.amount}${bookingModel!.coupon!.type == "percentage" ? "%" : "${getSymbol(context)}"} OFF)",
                price:
                    "-${getSymbol(context)}${currency(context).currencyVal * bookingModel!.couponTotalDiscount!}",
                style: appCss.dmDenseBold14
                    .textColor(appColor(context).appTheme.red)),
          if (bookingModel!.couponId != null) const VSpace(Sizes.s20),
          BillRowCommon(
              title: appFonts.tax,
              price:
                  "+${getSymbol(context)}${(currency(context).currencyVal * bookingModel!.tax!)}",
              color: appColor(context).appTheme.online),
          const VSpace(Sizes.s20),
          BillRowCommon(
              title: appFonts.platformFees,
              price:
                  "+${getSymbol(context)}${(currency(context).currencyVal * (bookingModel!.platformFees ?? 0.0)).ceilToDouble()}",
              color: appColor(context).appTheme.online),
          const VSpace(Sizes.s20),
          Divider(
                  color: appColor(context).appTheme.stroke,
                  thickness: 1,
                  height: 1,
                  indent: 6,
                  endIndent: 6)
              .paddingOnly(bottom: Insets.i27),
          BillRowCommon(
              title: appFonts.totalAmount,
              price:
                  "${getSymbol(context)}${(currency(context).currencyVal * bookingModel!.total!)}",
              styleTitle: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.darkText),
              style: appCss.dmDenseBold16
                  .textColor(appColor(context).appTheme.primary))
        ]).paddingSymmetric(vertical: Insets.i20));
  }
}
