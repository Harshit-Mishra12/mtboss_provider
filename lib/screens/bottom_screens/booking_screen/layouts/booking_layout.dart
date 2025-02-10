import 'dart:developer';

import 'package:intl/intl.dart';

import '../../../../config.dart';

class BookingLayout extends StatelessWidget {
  final BookingModel? data;
  final GestureTapCallback? onTap;

  const BookingLayout({super.key, this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<BookingProvider>(context, listen: true);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [

                      if (data!.servicePackageId != null)
                        BookingStatusLayout(title: appFonts.package)
                    ]),
                    Text(language(context, data!.service!.title),
                            style: appCss.dmDenseMedium16
                                .textColor(appColor(context).appTheme.darkText))
                        .paddingOnly(top: Insets.i8, bottom: Insets.i3),
                    Row(children: [
                      Text(
                          language(context,
                              "${getSymbol(context)}${(currency(context).currencyVal * data!.total!).toStringAsFixed(2)}"),
                          style: appCss.dmDenseBold18
                              .textColor(appColor(context).appTheme.primary)),
                      const HSpace(Sizes.s8),
                      if (data!.coupon != null)
                        Text(language(context, "(${data!.coupon!.amount})"),
                            style: appCss.dmDenseMedium14
                                .textColor(appColor(context).appTheme.red))
                    ])
                  ]),
            ),
            data!.service!.media != null && data!.service!.media!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: data!.service!.media![0].originalUrl!,
                    imageBuilder: (context, imageProvider) => Container(
                        height: Sizes.s84,
                        width: Sizes.s84,
                        decoration: ShapeDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                            shape: const SmoothRectangleBorder(
                                borderRadius: SmoothBorderRadius.all(
                                    SmoothRadius(
                                        cornerRadius: AppRadius.r10,
                                        cornerSmoothing: 1))))),
                    placeholder: (context, url) => CommonCachedImage(
                        image: eImageAssets.noImageFound1,
                        height: Sizes.s84,
                        width: Sizes.s84,
                        radius: AppRadius.r10),
                    errorWidget: (context, url, error) => CommonCachedImage(
                        image: eImageAssets.noImageFound1,
                        height: Sizes.s84,
                        width: Sizes.s84,
                        radius: AppRadius.r10))
                : CommonCachedImage(
                    image: eImageAssets.noImageFound1,
                    height: Sizes.s84,
                    width: Sizes.s84,
                    radius: AppRadius.r10)
          ]),
          Image.asset(eImageAssets.bulletDotted)
              .paddingSymmetric(vertical: Insets.i12),
          if (data!.bookingStatus != null)
            StatusRow(
              title: appFonts.bookingStatus,
              statusText: data!.bookingStatus!.name!,
              statusId: data!.bookingStatusId,
            ),
          if (data!.parentBookingNumber != null)
            StatusRow(
              title: appFonts.subBookingId,
              title2: data!.parentBookingNumber != null
                  ? "#${data!.parentBookingNumber}"
                  : "",
            ),
          if (data!.bookingStatus != null &&
              data!.bookingStatus!.slug != appFonts.cancelled)
            StatusRow(
                title: appFonts.requiredServiceman,
                title2:
                    "${((data!.requiredServicemen ?? 1) + (data!.totalExtraServicemen != null ? (data!.totalExtraServicemen ?? 1) : 0))} ${language(context, appFonts.serviceman)}",
                style: appCss.dmDenseMedium12
                    .textColor(appColor(context).appTheme.darkText)),
          if(data!.dateTime != null)
          StatusRow(
              title: appFonts.dateTime,
              title2: DateFormat("dd-MM-yyyy, hh:mm aa")
                  .format(DateTime.parse(data!.dateTime!)),
              style: appCss.dmDenseMedium12
                  .textColor(appColor(context).appTheme.darkText)),
          StatusRow(
              title: appFonts.location,
              title2: data!.address != null
                  ? "${data!.address!.country!.name}-${data!.address!.state!.name}"
                  : data!.consumer!.primaryAddress != null
                      ? "${data!.consumer!.primaryAddress!.country!.name}-${data!.consumer!.primaryAddress!.state!.name}"
                      : "",
              style: appCss.dmDenseMedium12
                  .textColor(appColor(context).appTheme.darkText)),
          if (data!.bookingStatus != null)
            StatusRow(
                title: appFonts.payment,
                title2: data!.paymentStatus != null
                    ? data!.paymentMethod == "cash"
                        ? data!.paymentStatus!.toLowerCase() == "completed"
                            ? data!.paymentStatus!
                            : language(context, appFonts.notPaid).toUpperCase()
                        : data!.paymentStatus!
                    : data!.bookingStatus!.slug == appFonts.accepted
                        ? data!.paymentStatus == "COMPLETED"
                            ? language(context, appFonts.paid)
                            : language(context, appFonts.notPaid)
                        : data!.paymentMethod == "cash"
                            ? language(context, appFonts.notPaid)
                            : language(context, appFonts.paid),
                style: appCss.dmDenseMedium12
                    .textColor(appColor(context).appTheme.online)),
          StatusRow(
              title: appFonts.paymentMethod,
              title2: data!.paymentMethod == "cash"
                  ? language(context, appFonts.cash)
                  : capitalizeFirstLetter(data!.paymentMethod!),
              style: appCss.dmDenseMedium12
                  .textColor(appColor(context).appTheme.online)),
          if (data!.isExpand!)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(eImageAssets.bulletDotted)
                    .paddingSymmetric(vertical: Insets.i12),
                if (data!.consumer != null)
                  ServiceProviderLayout(
                          expand: value.isExpand,
                          title: appFonts.customer,
                          image: data!.consumer!.media != null &&
                                  data!.consumer!.media!.isNotEmpty
                              ? data!.consumer!.media![0].originalUrl!
                              : null,
                          name: data!.consumer!.name,
                          index: 0,
                          list: const [])
                      .padding(horizontal: Insets.i12)
                      .boxShapeExtension(
                          color: appColor(context).appTheme.fieldCardBg,
                          radius: AppRadius.r15),
                if (data!.servicemen!.isNotEmpty)
                  Image.asset(eImageAssets.bulletDotted)
                      .paddingSymmetric(vertical: Insets.i12),
                if (isFreelancer == false)
                  if (data!.servicemen!.isNotEmpty)
                    Stack(alignment: Alignment.bottomCenter, children: [
                      Column(children: [
                        if (isFreelancer == false)
                          if (data!.servicemen!.isNotEmpty)
                            Column(
                                children:
                                    data!.servicemen!.asMap().entries.map((s) {
                              return ServiceProviderLayout(
                                  title: capitalizeFirstLetter(
                                      language(context, appFonts.serviceman)),
                                  image: s.value.media != null
                                      ? s.value.media![0].originalUrl!
                                      : null,
                                  name: s.value.name,
                                  rate: s.value.reviewRatings,
                                  index: s.key,
                                  list: data!.servicemen!);
                            }).toList())
                      ])
                          .paddingSymmetric(
                              horizontal: Insets.i15, vertical: Insets.i5)
                          .boxShapeExtension(
                              color: appColor(context).appTheme.fieldCardBg,
                              radius: AppRadius.r12)
                          .paddingOnly(
                              bottom: data!.servicemen!.length > 1
                                  ? Insets.i15
                                  : 0),
                      /*    if (data!.servicemen != null)
              if (data!.servicemen!.length > 1)
                CommonArrow(
                    arrow: data!.isExpand == true
                        ? eSvgAssets.upDoubleArrow
                        : eSvgAssets.downDoubleArrow,
                    isThirteen: true,
                    onTap: () => value.onExpand(data),
                    color: appColor(context).appTheme.whiteBg)*/
                    ]),
                if (data!.servicemen!.isEmpty)
                  Text(language(context, appFonts.noteServicemenNotSelectYet),
                          style: appCss.dmDenseRegular12
                              .textColor(appColor(context).appTheme.lightText))
                      .paddingOnly(top: Insets.i8),
                if (data!.servicemen!.isEmpty &&
                    data!.bookingStatus!.slug == appFonts.assigned)
                  RichText(
                      text: TextSpan(
                          style: appCss.dmDenseMedium12
                              .textColor(appColor(context).appTheme.red),
                          text: language(context, appFonts.note),
                          children: [
                        TextSpan(
                            style: appCss.dmDenseRegular12
                                .textColor(appColor(context).appTheme.red),
                            text:
                                language(context, appFonts.youAssignedService))
                      ])).paddingOnly(top: Insets.i8),
                if (data!.servicemen!.isEmpty &&
                    data!.bookingStatus!.slug == appFonts.ongoing)
                  if (isFreelancer != true)
                    RichText(
                        text: TextSpan(
                            style: appCss.dmDenseMedium12
                                .textColor(appColor(context).appTheme.red),
                            text: language(context, appFonts.note),
                            children: [
                          TextSpan(
                              style: appCss.dmDenseRegular12
                                  .textColor(appColor(context).appTheme.red),
                              text: language(
                                  context, appFonts.youAssignedService))
                        ])).paddingOnly(top: Insets.i8),
                if (data!.bookingStatus != null)
                  if (data!.bookingStatus!.slug == appFonts.pending &&
                      data!.servicemen!.isEmpty)
                    Row(children: [
                      Expanded(
                          child: ButtonCommon(
                              title: appFonts.reject,
                              onTap: () =>
                                  value.onRejectBooking(context, data!.id),
                              style: appCss.dmDenseSemiBold16.textColor(
                                  appColor(context).appTheme.primary),
                              color: appColor(context).appTheme.trans,
                              borderColor: appColor(context).appTheme.primary)),
                      const HSpace(Sizes.s15),
                      Expanded(
                          child: ButtonCommon(
                              title: appFonts.accept,
                              onTap: () =>
                                  value.onAcceptBooking(context, data!.id)))
                    ]).paddingOnly(top: Insets.i15, bottom: Sizes.s20),
                if (data!.bookingStatus != null)
                  if ((data!.bookingStatus!.slug == appFonts.accept ||
                          data!.bookingStatus!.slug == appFonts.accepted) &&
                      data!.servicemen!.isEmpty)
                    ButtonCommon(
                            title: appFonts.assigned,
                            onTap: () => value.onAssignTap(context, data!),
                            style: appCss.dmDenseSemiBold16
                                .textColor(appColor(context).appTheme.primary),
                            color: appColor(context).appTheme.trans,
                            borderColor: appColor(context).appTheme.primary)
                        .paddingOnly(top: Insets.i15)
              ],
            ),
        ])
            .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i20)
            .boxBorderExtension(context,
                isShadow: true, bColor: appColor(context).appTheme.stroke)
            .paddingOnly(bottom: Insets.i15)
            .inkWell(onTap: onTap),
        Transform.translate(
          offset: const Offset(0, -Insets.i14), // Moves the container upwards
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Insets.i10),
              color: appColor(context).appTheme.primary,
            ),
            padding: const EdgeInsets.symmetric(
                vertical: Sizes.s4, horizontal: Sizes.s10),
            child: Text(
              "#${data!.bookingNumber!}",
              style: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.whiteColor),
            ),
          ),
        ).paddingOnly(

            left: Sizes.s20),

        Positioned(
            bottom: Insets.i2,
            left: Insets.i150,
            child: CommonArrow(
                arrow: data!.isExpand == true
                    ? eSvgAssets.upDoubleArrow
                    : eSvgAssets.downDoubleArrow,
                isThirteen: true,
                onTap: () => value.onExpand(data),
                color: appColor(context).appTheme.fieldCardBg).center()),
      ],
    ).paddingOnly(top: Sizes.s8, bottom: Sizes.s8);
  }
}
