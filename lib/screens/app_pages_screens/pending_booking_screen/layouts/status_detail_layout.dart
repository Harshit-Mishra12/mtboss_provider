import 'package:intl/intl.dart';

import '../../../../config.dart';

class StatusDetailLayout extends StatelessWidget {
  final BookingModel? data;
  final GestureTapCallback? onPhone, onTapStatus;

  const StatusDetailLayout(
      {super.key, this.data, this.onTapStatus, this.onPhone});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: data != null
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  data!.service!.media != null &&
                          data!.service!.media!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: data!.service!.media![0].originalUrl!,
                          imageBuilder: (context, imageProvider) => Container(
                              height: Sizes.s140,
                              decoration: ShapeDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                  shape: const SmoothRectangleBorder(
                                      borderRadius: SmoothBorderRadius.all(
                                          SmoothRadius(
                                              cornerRadius: AppRadius.r10,
                                              cornerSmoothing: 1))))),
                          placeholder: (context, url) => CommonCachedImage(
                              height: Sizes.s140,
                              image: eImageAssets.noImageFound1,
                              radius: AppRadius.r10),
                          errorWidget: (context, url, error) =>
                              CommonCachedImage(
                                  height: Sizes.s140,
                                  image: eImageAssets.noImageFound1,
                                  radius: AppRadius.r10),
                        )
                      : CommonCachedImage(
                          height: Sizes.s140,
                          image: eImageAssets.noImageFound1,
                          radius: AppRadius.r10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Text(data!.bookingNumber!,
                              style: appCss.dmDenseMedium16.textColor(
                                  appColor(context).appTheme.primary)),
                          if (data!.servicePackageId != null)
                            ButtonCommon(
                                    title: appFonts.package,
                                    width: Sizes.s68,
                                    height: Sizes.s22,
                                    color: appColor(context).appTheme.whiteBg,
                                    radius: AppRadius.r12,
                                    borderColor:
                                        appColor(context).appTheme.online,
                                    style: appCss.dmDenseMedium11.textColor(
                                        appColor(context).appTheme.online))
                                .paddingSymmetric(horizontal: Insets.i8)
                        ]),
                        Row(children: [
                          Text(language(context, appFonts.viewStatus),
                              style: appCss.dmDenseMedium12.textColor(
                                  appColor(context).appTheme.primary)),
                          const HSpace(Sizes.s5),
                          SvgPicture.asset(eSvgAssets.anchorArrowRight,
                              colorFilter: ColorFilter.mode(
                                  appColor(context).appTheme.primary,
                                  BlendMode.srcIn))
                        ])
                            .paddingSymmetric(
                                horizontal: Insets.i12, vertical: Insets.i8)
                            .boxShapeExtension(
                                radius: AppRadius.r4,
                                color: appColor(context)
                                    .appTheme
                                    .primary
                                    .withOpacity(0.1))
                            .inkWell(onTap: onTapStatus)
                      ]).paddingSymmetric(vertical: Insets.i15),
                  Text(data!.service!.title!,
                      style: appCss.dmDenseMedium16
                          .textColor(appColor(context).appTheme.darkText)),
                  const VSpace(Sizes.s15),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          DescriptionLayoutCommon(
                              icon: eSvgAssets.calender,
                              title: DateFormat("dd MMM, yyyy")
                                  .format(DateTime.parse(data!.dateTime!)),
                              subtitle: appFonts.date,
                              padding: 0),
                          Container(
                                  height: Sizes.s78,
                                  width: 1,
                                  color: appColor(context).appTheme.stroke)
                              .paddingSymmetric(horizontal: Insets.i20),
                          DescriptionLayoutCommon(
                              icon: eSvgAssets.clock,
                              title: DateFormat("hh:mm aa")
                                  .format(DateTime.parse(data!.dateTime!)),
                              subtitle: appFonts.time)
                        ]).paddingSymmetric(horizontal: Insets.i10),
                        const DottedLines(),
                        const VSpace(Sizes.s17),
                        IntrinsicHeight(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              SvgPicture.asset(eSvgAssets.locationOut,
                                  fit: BoxFit.scaleDown,
                                  colorFilter: ColorFilter.mode(
                                      appColor(context).appTheme.darkText,
                                      BlendMode.srcIn)),
                              VerticalDivider(
                                      thickness: 1,
                                      indent: 2,
                                      endIndent: 20,
                                      width: 1,
                                      color: appColor(context).appTheme.stroke)
                                  .paddingSymmetric(horizontal: Insets.i9),
                              Expanded(
                                  child: Text(
                                      data!.consumer != null
                                          ? "${data!.address!.area != null ? "${data!.address!.area}, " : ""}${data!.address!.address}, ${data!.address!.country!.name}, ${data!.address!.state!.name}, ${data!.address!.postalCode}"
                                          : "",
                                      overflow: TextOverflow.fade,
                                      style: appCss.dmDenseRegular12.textColor(
                                          appColor(context).appTheme.darkText)))
                            ])).padding(
                            horizontal: Insets.i10, bottom: Insets.i15),
                        if (data!.bookingStatus != null)
                          if (data!.bookingStatus!.slug != "cancel")
                            ViewLocationCommon(address: data!.address!)
                      ]).boxBorderExtension(context,
                      bColor: appColor(context).appTheme.stroke),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (data!.description != null)
                          Text(language(context, appFonts.description),
                              style: appCss.dmDenseMedium12.textColor(
                                  appColor(context).appTheme.lightText)),
                        if (data!.description != null) const VSpace(Sizes.s6),
                        if (data!.description != null)
                          ReadMoreLayout(text: data!.description!)
                      ]).paddingSymmetric(vertical: Insets.i15),
                  data!.bookingStatus != null &&
                          (data!.bookingStatus!.slug == "completed" ||
                              data!.bookingStatus!.slug == "cancelled" ||
                              data!.bookingStatus!.slug == "cancel")
                      ? CustomerLayout(
                          title: appFonts.customerDetails, data: data!.consumer)
                      : CustomerServiceLayout(
                          id: data!.consumerId,
                          role: "user",
                          bookingId: data!.id.toString(),
                          token: data!.consumer!.fcmToken,
                          phone: data!.consumer!.phone?.toString().replaceRange(0, data!.consumer!.phone.toString().length, "*"),
                          code: data!.consumer!.code,
                          title: appFonts.customerDetails,
                          image: data!.consumer!.media != null &&
                                  data!.consumer!.media!.isNotEmpty
                              ? data!.consumer!.media![0].originalUrl!
                              : null,
                          name: data!.consumer!.name,
                          status: data!.bookingStatus != null
                              ? data!.bookingStatus!.slug
                              : "",
                          phoneTap: onPhone),
                  if (isFreelancer != true) const VSpace(Sizes.s15),
                  if (isFreelancer != true)
                    if (!isServiceman)
                      data!.servicemen!.isEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  const DottedLines(),
                                  const VSpace(Sizes.s10),
                                  RichText(
                                      text: TextSpan(
                                          style: appCss.dmDenseMedium12.textColor(data!
                                                          .bookingStatus!
                                                          .slug ==
                                                      "assigned" ||
                                                  data!.bookingStatus!.slug ==
                                                      appFonts.ongoing ||
                                                  data!.bookingStatus!.slug ==
                                                      "cancelled" ||
                                                  (data!.bookingStatus!.slug ==
                                                          "accepted" &&
                                                      data!.providerId
                                                              .toString() !=
                                                          userModel!.id
                                                              .toString())
                                              ? appColor(context).appTheme.red
                                              : appColor(context)
                                                  .appTheme
                                                  .darkText),
                                          text:
                                              language(context, appFonts.note),
                                          children: [
                                        TextSpan(
                                            style: appCss.dmDenseRegular12.textColor(data!.bookingStatus!.slug == "assigned" ||
                                                    data!.bookingStatus!.slug ==
                                                        appFonts.ongoing ||
                                                    data!.bookingStatus!.slug ==
                                                        appFonts.cancel ||
                                                    (data!.bookingStatus!.slug == appFonts.accepted &&
                                                        data!.providerId !=
                                                            userModel!.id
                                                                .toString())
                                                ? appColor(context).appTheme.red
                                                : appColor(context)
                                                    .appTheme
                                                    .darkText),
                                            text: language(
                                                context,
                                                data!.bookingStatus!.slug == appFonts.assigned ||
                                                        data!.bookingStatus!.slug == appFonts.ongoing ||
                                                        data!.bookingStatus!.slug == appFonts.cancel ||
                                                        (data!.bookingStatus!.slug == appFonts.accepted && data!.providerId != userModel!.id.toString())
                                                    ? appFonts.youAssignedService
                                                    : appFonts.servicemenIsNotSelected))
                                      ]))
                                ])
                          : data!.servicemen!
                                  .where((element) =>
                                      element.id.toString() ==
                                      userModel!.id.toString())
                                  .isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      const DottedLines(),
                                      const VSpace(Sizes.s10),
                                      RichText(
                                          text: TextSpan(
                                              style: appCss.dmDenseMedium12
                                                  .textColor(appColor(context)
                                                      .appTheme
                                                      .red),
                                              text: language(
                                                  context, appFonts.note),
                                              children: [
                                            TextSpan(
                                                style: appCss.dmDenseRegular12
                                                    .textColor(appColor(context)
                                                        .appTheme
                                                        .red),
                                                text: language(
                                                    context,
                                                    appFonts
                                                        .youAssignedService))
                                          ]))
                                    ])
                              : Column(
                                  children: data!.servicemen!
                                      .asMap()
                                      .entries
                                      .map((s) => CustomerServiceLayout(
                                              id: s.value.id,
                                              bookingId: data!.id.toString(),
                                              title: appFonts.servicemanDetail,
                                              phone: s.value.phone.toString(),
                                              code: s.value.code,
                                              token: s.value.fcmToken,
                                              name: s.value.name,
                                              role: "serviceman",
                                              rate: s.value.reviewRatings != null
                                                  ? double.parse(
                                                      s.value.reviewRatings!)
                                                  : 0.0,
                                              moreTap: () => route.pushNamed(
                                                  context, routeName.servicemanDetail,
                                                  arg: {"isShow": false, "detail": s.value.id}),
                                              image: s.value.media != null &&
                                                      s.value.media!.isNotEmpty
                                                  ? s.value.media![0]
                                                      .originalUrl
                                                  : null,
                                              status: data!.bookingStatus != null
                                                  ? data!.bookingStatus!.slug
                                                  : "")
                                          .paddingOnly(bottom: s.key != data!.servicemen!.length - 1 ? Insets.i15 : 0))
                                      .toList())
                ]).paddingAll(Insets.i15).boxBorderExtension(context,
                    bColor: appColor(context).appTheme.stroke,
                    color: appColor(context).appTheme.whiteBg,
                    isShadow: true)
              ])
            : Container());
  }
}
