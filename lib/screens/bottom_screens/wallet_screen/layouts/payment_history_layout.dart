import 'package:intl/intl.dart';

import '../../../../config.dart';

class PaymentHistoryLayout extends StatelessWidget {
  final PaymentHistoryModel? data;
  final GestureTapCallback? onTap;

  const PaymentHistoryLayout({super.key, this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return data!.booking != null
        ? Column(children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data!.detail!,
                            style: appCss.dmDenseMedium14.textColor(
                                appColor(context).appTheme.darkText)),
                        const VSpace(Sizes.s5),
                        Text("\$${data!.amount}",
                            style: appCss.dmDenseBold18
                                .textColor(appColor(context).appTheme.darkText))
                      ]),
                  if (data!.bookingId != null)
                    BookingIdLayout(id: data!.booking!.bookingNumber)
                ]),
            const VSpace(Sizes.s12),
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(appColor(context).appTheme.isDark
                            ? eImageAssets.bookingDetailBg
                            : eImageAssets.commissionBg),
                        fit: BoxFit.fill)),
                child: Column(children: [
                  WalletRowLayout(
                      id: "#${data!.booking!.parentId}",
                      title: appFonts.paymentId),
                  WalletRowLayout(
                      id: data!.booking!.paymentMethod,
                      title: appFonts.methodType),
                  WalletRowLayout(
                      id: data!.booking!.paymentStatus, title: appFonts.status)
                ]).padding(horizontal: Insets.i15, top: Insets.i15)),
            const VSpace(Sizes.s10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                Container(
                    height: Sizes.s36,
                    width: Sizes.s36,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(data!
                                .booking!.consumer!.media![0].originalUrl!)))),
                const HSpace(Sizes.s12),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(language(context, appFonts.customer),
                      style: appCss.dmDenseRegular12
                          .textColor(appColor(context).appTheme.lightText)),
                  Text(data!.booking!.consumer!.name!,
                      style: appCss.dmDenseMedium13
                          .textColor(appColor(context).appTheme.darkText))
                ])
              ]),
              SvgPicture.asset(eSvgAssets.anchorArrowRight,
                      height: Sizes.s12,
                      width: Sizes.s12,
                      colorFilter: ColorFilter.mode(
                          appColor(context).appTheme.primary, BlendMode.srcIn))
                  .inkWell(onTap: onTap)
            ]).paddingAll(Insets.i12).boxBorderExtension(context,
                isShadow: true, bColor: appColor(context).appTheme.stroke)
          ])
            .paddingAll(Insets.i15)
            .boxBorderExtension(context,
                isShadow: true, bColor: appColor(context).appTheme.stroke)
            .paddingOnly(bottom: Insets.i25)
        : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.75,
                  child: Text(data!.detail!,
                      overflow: TextOverflow.ellipsis,
                      style: appCss.dmDenseSemiBold14
                          .textColor(appColor(context).appTheme.darkText))),
              const VSpace(Sizes.s3),
              Text(
                  DateFormat("dd MMM,yyyy")
                      .format(DateTime.parse(data!.createdAt!)),
                  style: appCss.dmDenseRegular12
                      .textColor(appColor(context).appTheme.lightText))
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(
                  "${currency(context).priceSymbol}${(currency(context).currencyVal * data!.amount!).ceilToDouble()}",
                  style: appCss.dmDenseSemiBold14
                      .textColor(appColor(context).appTheme.darkText)),
              const VSpace(Sizes.s3),
              Text(capitalizeFirstLetter(data!.type!.toString()),
                  style: appCss.dmDenseMedium12.textColor(
                      data!.type! == "credit"
                          ? appColor(context).appTheme.online
                          : appColor(context).appTheme.red))
            ])
          ])
            .paddingAll(Insets.i15)
            .boxBorderExtension(context,
                isShadow: true, bColor: appColor(context).appTheme.stroke)
            .paddingOnly(bottom: Insets.i25);
  }
}
