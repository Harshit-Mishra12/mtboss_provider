import 'package:intl/intl.dart';

import '../../../../config.dart';

class CommissionHistoryLayout extends StatelessWidget {
  final Histories? data;
  final GestureTapCallback? onTap;

  const CommissionHistoryLayout({super.key, this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(language(context, appFonts.bookingId),
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.darkText)),
            const VSpace(Sizes.s6),
            Text(
                DateFormat("dd MMM, yyyy")
                    .format(DateTime.parse(language(context, data!.createdAt))),
                style: appCss.dmDenseRegular12
                    .textColor(appColor(context).appTheme.lightText))
          ]),
          BookingIdLayout(id: data!.booking!.bookingNumber!)
        ]).paddingAll(Insets.i12).boxBorderExtension(context,
            bColor: appColor(context).appTheme.stroke,
            color: appColor(context).appTheme.fieldCardBg,
            radius: AppRadius.r10),
        const VSpace(Sizes.s15),
        if (isServiceman == false)
          CommissionRowLayout(
              data: data!.booking!.total!,
              title: appFonts.totalReceivedCommission,
              style: appCss.dmDenseblack14
                  .textColor(appColor(context).appTheme.darkText)),
        if (isServiceman == false)
          CommissionRowLayout(
              title: appFonts.adminCommission, data: data!.adminCommission!),
        CommissionRowLayout(
            title: isServiceman
                ? appFonts.yourCommission
                : appFonts.servicemenCommission,
            data: data!.serviceCommission!),
        CommissionRowLayout(
            title: appFonts.platformFees, data: data!.adminCommission),
        if (isServiceman == false)
          CommissionRowLayout(
              title: appFonts.yourCommission,
              color: appColor(context).appTheme.primary,
              data: data!.providerCommission!)
      ]).padding(horizontal: Insets.i15, top: Insets.i15),
      const DividerCommon().paddingOnly(bottom: Insets.i15),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(language(context, appFonts.viewMore),
            style: appCss.dmDenseMedium14
                .textColor(appColor(context).appTheme.primary)),
        SizedBox(
            height: Sizes.s18,
            width: Sizes.s18,
            child: SvgPicture.asset(eSvgAssets.anchorArrowRight,
                colorFilter: ColorFilter.mode(
                    appColor(context).appTheme.primary, BlendMode.srcIn)))
      ]).padding(horizontal: Insets.i15, bottom: Insets.i15)
    ])
        .boxBorderExtension(context, isShadow: true, radius: AppRadius.r12)
        .inkWell(onTap: onTap)
        .paddingOnly(bottom: Insets.i15);
  }
}
