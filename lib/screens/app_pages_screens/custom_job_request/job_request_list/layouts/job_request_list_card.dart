import 'dart:developer';

import 'package:intl/intl.dart';
import '../../../../../config.dart';

class JobRequestListCard extends StatelessWidget {
  final JobRequestModel? data;

  const JobRequestListCard({super.key, this.data, });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(children: [
                data!.media!.isNotEmpty
                    ? CommonImageLayout(
                            height: Sizes.s52,
                            width: Sizes.s52,
                            radius: 8,
                            image: data!.media![0].originalUrl!,
                            assetImage: eImageAssets.noImageFound3)
                        .boxShapeExtension()
                    : CommonCachedImage(
                            image: eImageAssets.noImageFound3,
                            //assetImage: eImageAssets.noImageFound3,
                            height: Sizes.s52,
                            width: Sizes.s52)
                        .boxShapeExtension(),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(capitalizeFirstLetter(data!.title),
                        style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.darkText)),
                    const VSpace(Sizes.s8),
                    Text(
                          (data!.status != "accepted" )
                            ? "${getSymbol(context)}${currency(context).currencyVal * data!.initialPrice!}"
                            : "${getSymbol(context)}${currency(context).currencyVal * data!.finalPrice!}",
                        overflow: TextOverflow.ellipsis,
                        style: appCss.dmDenseSemiBold12
                            .textColor(appColor(context).appTheme.darkText)),
                  ]).paddingOnly(left: Insets.i10),
                )
              ]),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.s12, vertical: Sizes.s4),
                    decoration: ShapeDecoration(
                        color: colorCondition(data!.status, context),
                        shape: SmoothRectangleBorder(
                            borderRadius: SmoothBorderRadius(
                                cornerRadius: 11, cornerSmoothing: 2))),
                    child: Text(capitalizeFirstLetter(data!.status),
                        style: appCss.dmDenseMedium10
                            .textColor(appColor(context).appTheme.whiteColor))),
                const VSpace(Sizes.s8),
                Text(
                    DateFormat("MMM d, yyyy")
                        .format(DateTime.parse(data!.bookingDate!)),
                    style:
                    appCss.dmDenseMedium12.textColor(appColor(context).appTheme.lightText))
              ],
            )
          ]),

    ])
        .paddingAll(12)
        .boxBorderExtension(context, isShadow: true)
        .marginOnly(bottom: Sizes.s20).inkWell(onTap: ()=> route.pushNamed(context,routeName.jobRequestDetail,arg: {"services":data}));
  }
}
