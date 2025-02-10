import '../../../../config.dart';

class ServiceDescription extends StatelessWidget {
  final Services? services;

  const ServiceDescription({super.key, this.services});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ServiceDetailsProvider, LocationProvider>(
        builder: (context1, value, val, child) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        DescriptionLayoutCommon(
            icon: eSvgAssets.category,
            title: appFonts.category,
            subtitle: getCategoryName(services!.categories!))
            .paddingSymmetric(horizontal: Insets.i25,vertical: Sizes.s17),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: appColor(context).appTheme.stroke),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              child: DescriptionLayoutCommon(
                  icon: eSvgAssets.clock,
                  title: appFonts.duration,
                  subtitle:
                      "${services!.duration ?? 1} ${services!.durationUnit ?? "hour"}")),
          Container(
                  height: Sizes.s78,
                  width: 1,
                  color: appColor(context).appTheme.stroke)
              .paddingSymmetric(horizontal: Insets.i20),
          Expanded(
              child: DescriptionLayoutCommon(
              icon: eSvgAssets.tagUser,
          title: appFonts.serviceman,
          subtitle: "${services!.requiredServicemen ?? 1} servicemen"))
        ]).paddingSymmetric(horizontal: Insets.i25),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: appColor(context).appTheme.stroke),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              child: DescriptionLayoutCommon(
                  icon: eSvgAssets.commission,
                  title: appFonts.commission,
                  subtitle: "30%")),
          Container(
                  height: Sizes.s78,
                  width: 1,
                  color: appColor(context).appTheme.stroke)
              .paddingSymmetric(horizontal: Insets.i20),
          Expanded(
              child: DescriptionLayoutCommon(
                  icon: eSvgAssets.receiptDiscount,
                  title: appFonts.tax,
                  subtitle: "${getTaxName(services!.taxId)}%"))
        ]).paddingSymmetric(horizontal: Insets.i25),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: appColor(context).appTheme.stroke),

        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(language(context, appFonts.description),
              style: appCss.dmDenseMedium12
                  .textColor(appColor(context).appTheme.lightText)),
          const VSpace(Sizes.s6),
          ReadMoreLayout(text: services!.description),

          if (services!.metaDescription != null) const VSpace(Sizes.s15),
          if (services!.metaDescription != null)
            Text("\u2022 ${services!.metaDescription ?? ""}.",
                style: appCss.dmDenseMedium13
                    .textColor(appColor(context).appTheme.lightText))
        ])
            .paddingSymmetric(horizontal: Insets.i20)
            .paddingSymmetric(vertical: Insets.i20)
      ]).boxBorderExtension(context, isShadow: true);
    });
  }
}
