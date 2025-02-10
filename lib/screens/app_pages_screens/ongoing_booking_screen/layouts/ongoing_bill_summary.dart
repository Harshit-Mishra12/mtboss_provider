import '../../../../config.dart';

class OngoingBillSummary extends StatelessWidget {
  final BookingModel? bookingModel;

  const OngoingBillSummary({super.key, this.bookingModel});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(appColor(context).appTheme.isDark
                    ? eImageAssets.completedBillBg
                    : eImageAssets.ongoingBg),
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
          if (bookingModel!.extraCharges != null &&
              bookingModel!.extraCharges!.isNotEmpty)
            ...bookingModel!.extraCharges!.asMap().entries.map((e) => BillRowCommon(
                    title:
                        "Extra service charge(${e.value.perServiceAmount} × ${e.value.noServiceDone})",
                    price:
                        "${getSymbol(context)}${(e.value.noServiceDone ??1) * (currency(context).currencyVal * e.value.perServiceAmount!).ceilToDouble()}",
                    style: appCss.dmDenseBold14
                        .textColor(appColor(context).appTheme.darkText)).paddingOnly(bottom: Insets.i20)
                ),
          BillRowCommon(
              title: appFonts.tax,
              price:
                  "+${getSymbol(context)}${(currency(context).currencyVal * bookingModel!.tax!)}",
              color: appColor(context).appTheme.online),
          BillRowCommon(
                  title: appFonts.platformFees,
                  price:
                      "+${getSymbol(context)}${(currency(context).currencyVal * (bookingModel!.platformFees ?? 0.0)).ceilToDouble()}",
                  color: appColor(context).appTheme.online)
              .paddingSymmetric(vertical: Insets.i20),
          Divider(
                  color: appColor(context).appTheme.stroke,
                  thickness: 1,
                  height: 1,
                  indent: 6,
                  endIndent: 6)
              .paddingOnly(bottom: Insets.i23),
          BillRowCommon(
              title: appFonts.totalAmount,
              price:
                  "${getSymbol(context)}${bookingModel!.extraCharges != null && bookingModel!.extraCharges!.isNotEmpty ? (currency(context).currencyVal * (totalServicesCharges(bookingModel!) + bookingModel!.total!) ) : (currency(context).currencyVal * bookingModel!.total!)}",
              styleTitle: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.darkText),
              style: appCss.dmDenseBold16
                  .textColor(appColor(context).appTheme.primary))
        ]).paddingSymmetric(vertical: Insets.i20));
  }
}
