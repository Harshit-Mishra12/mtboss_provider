import 'dart:developer';

import '../../../../config.dart';

class CompanyTopLayout extends StatelessWidget {
  const CompanyTopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    log("isFreelancer :$isFreelancer");
    return Column(children: [

      if (isFreelancer != true)
        Column(children: [
          Stack(alignment: Alignment.center, children: [
            Image.asset(eImageAssets.companyBg,
                    fit: BoxFit.fill,
                    height: Sizes.s66, width: MediaQuery.of(context).size.width)
                .paddingOnly(bottom: Insets.i50),
            userModel!.company !=null&& userModel!.company!.media != null &&
                    userModel!.company!.media!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: userModel!.company!.media![0].originalUrl!,
                    imageBuilder: (context, imageProvider) => Container(
                        alignment: Alignment.center,
                        height: Sizes.s90,
                        width: Sizes.s90,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: appColor(context).appTheme.whiteColor,
                                width: 4),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover, image: imageProvider))),
                    errorWidget: (context, url, error) => CommonCachedImage(
                        height: Sizes.s90,
                        width: Sizes.s90,
                        boxFit: BoxFit.cover,
                        isCircle: true,
                        image: eImageAssets.noImageFound3,
                        isBorder: true),
                    placeholder: (context, url) => CommonCachedImage(
                        height: Sizes.s90,
                        width: Sizes.s90,
                        boxFit: BoxFit.cover,
                        isCircle: true,
                        image: eImageAssets.noImageFound3,
                        isBorder: true))
                : CommonCachedImage(
                    height: Sizes.s90,
                    width: Sizes.s90,
                    boxFit: BoxFit.cover,
                    isCircle: true,
                    image: eImageAssets.noImageFound3,
                    isBorder: true)
          ]),
          if(userModel!.company !=null)
          Text(language(context, userModel!.company!.name!.toUpperCase()),
              style: appCss.dmDenseBold14
                  .textColor(appColor(context).appTheme.primary)),
          const VSpace(Sizes.s3),
          if(userModel!.company !=null)
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(eSvgAssets.mailBold,
                colorFilter: ColorFilter.mode(
                    appColor(context).appTheme.lightText, BlendMode.srcIn)),
            const HSpace(Sizes.s5),

            Text(language(context, userModel!.company!.email!),
                style: appCss.dmDenseRegular12
                    .textColor(appColor(context).appTheme.lightText))
          ]),
          const VSpace(Sizes.s15)
        ]),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(children: [
          isFreelancer != true
              ? Column(
                  children: appArray.companyDetailList
                      .asMap()
                      .entries
                      .map((e) => DescriptionLayout(
                          data: e.value,
                          list: appArray.companyDetailList,
                          index: e.key,
                          isDark: e.key == 1 ? false : true))
                      .toList())
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(
                      height: Sizes.s20,
                      width: Sizes.s20,
                      child: SvgPicture.asset(eSvgAssets.locationOut,
                          fit: BoxFit.contain,
                          colorFilter: ColorFilter.mode(
                              appColor(context).appTheme.darkText,
                              BlendMode.srcIn)),
                    ),
                    Container(
                            height: Sizes.s15,
                            width: 1,
                            color: appColor(context).appTheme.stroke)
                        .paddingSymmetric(horizontal: Insets.i9),
                    Text(language(context, appFonts.mainLocation),
                            style: appCss.dmDenseRegular12.textColor(
                                appColor(context).appTheme.lightText))
                        .expanded()
                  ]),
                  Text(
                          language(context,
                              "2118 Thornridge Cir. Syracuse, Connecticut - 35624, USA."),
                          style: appCss.dmDenseRegular12
                              .textColor(appColor(context).appTheme.darkText))
                      .paddingOnly(
                          left: rtl(context) ? 0 : Insets.i38,
                          right: rtl(context) ? Insets.i38 : 0),
                ]).paddingSymmetric(horizontal: Insets.i10)
        ]).paddingSymmetric(vertical: Insets.i15).boxBorderExtension(context),
        if (userModel!.description != null)
          Text(language(context, appFonts.description),
                  style: appCss.dmDenseRegular12
                      .textColor(appColor(context).appTheme.lightText))
              .paddingOnly(top: Insets.i20, bottom: Insets.i6),
        if (userModel!.description != null)
          Text(userModel!.description ?? "",
              style: appCss.dmDenseRegular14
                  .textColor(appColor(context).appTheme.darkText))
      ]).paddingAll(Insets.i15).boxBorderExtension(context,
          isShadow: true, bColor: appColor(context).appTheme.fieldCardBg),
    ]);
  }
}
