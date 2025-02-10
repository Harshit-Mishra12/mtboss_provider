

import '../../../../../config.dart';


class PackageDescriptionLayout extends StatelessWidget {
  final ServicePackageModel? data;
  const PackageDescriptionLayout({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const DottedLines(),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
            child: DescriptionLayoutCommon(
              isExpanded: true,
                icon: eSvgAssets.calender, title:  "${language(context, appFonts.startDate)}:", subtitle: data!.startedAt)
        ),
        Container(
            height: Sizes.s78,
            width: 1,
            color: appColor(context).appTheme.stroke).paddingSymmetric(horizontal: Insets.i20),
        Expanded(
            child: DescriptionLayoutCommon(
                icon: eSvgAssets.calender,
                title: "${language(context, appFonts.endDate)}:",
                subtitle: data!.endedAt)
        )
      ]).paddingSymmetric(horizontal: Insets.i20),

      const DottedLines(),
      const VSpace(Sizes.s17),
     /* DescriptionLayoutCommon(
        isExpanded: true,
          icon: eSvgAssets.tagUser,
          title: appFonts.noOfRequired,
          subtitle: "${data!.reqServicemen} ${appFonts.serviceman}")
          .paddingSymmetric(horizontal: Insets.i25),*/
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const VSpace(Sizes.s15),
        Text(language(context, appFonts.description),
            style: appCss.dmDenseMedium14
                .textColor(appColor(context).appTheme.darkText)),
        const VSpace(Sizes.s6),
         ReadMoreLayout(

           color: appColor(context).appTheme.lightText,
            text:
            data!.description),
      ]).paddingSymmetric(horizontal: Insets.i20)
    ]);
  }
}
