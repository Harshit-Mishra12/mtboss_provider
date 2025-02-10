import 'dart:developer';

import '../../../../config.dart';

class ServicemenDetailProfileLayout extends StatelessWidget {
  const ServicemenDetailProfileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<ServicemenDetailProvider>(context);
    return value.servicemanModel == null ?Container():  Column(children: [
      ServicemanDetailProfileLayout(
          image: value.imageFile, onEdit: () => value.editServicemanDetail(context),imageUrl: value.servicemanModel!.media != null &&
          value.servicemanModel!.media!.isNotEmpty ? value.servicemanModel!.media![0].originalUrl!:null,isIcons: value.isIcons,),
      const VSpace(Sizes.s6),
      IntrinsicHeight(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(value.servicemanModel!.name!,
            style: appCss.dmDenseMedium14
                .textColor(appColor(context).appTheme.darkText)),
        VerticalDivider(
                color: appColor(context).appTheme.stroke,
                width: 1,
                thickness: 1,
                indent: 5,
                endIndent: 5)
            .paddingSymmetric(horizontal: Insets.i6),
        SvgPicture.asset(eSvgAssets.star),
        const HSpace(Sizes.s3),
        Text(
            value.servicemanModel!.reviewRatings != null
                ? value.servicemanModel!.reviewRatings!
                : "0",
            style: appCss.dmDenseMedium13
                .textColor(appColor(context).appTheme.darkText))
      ])),
      Text(
          appFonts.experienceVal(context, value.servicemanModel!.experienceDuration ?? 0, value.servicemanModel!.experienceInterval ??"year"),
          style: appCss.dmDenseMedium12
              .textColor(appColor(context).appTheme.lightText)),
      const VSpace(Sizes.s10),
      if(value.servicemanModel!.primaryAddress != null)
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(eSvgAssets.locationOut,
            colorFilter: ColorFilter.mode(
                appColor(context).appTheme.darkText, BlendMode.srcIn)),
        const HSpace(Sizes.s5),
        Text("${value.servicemanModel!.primaryAddress!.country!.name} , ${value.servicemanModel!.primaryAddress!.state!.name}",
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.darkText))
      ]),
      if(value.servicemanModel!.primaryAddress != null)
      const VSpace(Sizes.s15),
      Image.asset(eImageAssets.bulletDotted),
      const VSpace(Sizes.s15),
      ServicesDeliveredLayout(
          services:value.servicemanModel!.served ?? "0",
          color: appColor(context).appTheme.primary.withOpacity(0.1))
    ]);
  }
}
