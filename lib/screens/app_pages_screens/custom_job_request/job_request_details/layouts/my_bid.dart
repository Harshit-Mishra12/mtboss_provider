import '../../../../../config.dart';

class MyBid extends StatelessWidget {
  final JobRequestModel? service;
  const MyBid({super.key, this.service});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            language(context,
                appFonts.myBid),
            style: appCss
                .dmDenseMedium14
                .textColor(
                appColor(
                    context)
                    .appTheme
                    .darkText)),
        const VSpace(Sizes.s8),
        ...service!
            .bids!
            .where((element) =>
        element.providerId ==
            userModel!.id)
            .toList()
            .asMap()
            .entries
            .map((e) =>
            Row(
              children: [
                e.value.provider!.media != null && e.value.provider!.media!.isNotEmpty
                    ? CommonImageLayout(
                  image: e.value.provider!.media![0].originalUrl!,
                  assetImage: eImageAssets.noImageFound3,
                  height: Sizes.s52,
                  width: Sizes.s52,
                  radius: 8,)
                    : CommonCachedImage(
                    image: eImageAssets.noImageFound3,
                    height: Sizes.s52,
                    width: Sizes.s52,
                    radius: 8),
                const HSpace(Sizes.s10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(service!.title!,
                        style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.darkText)),
                    const VSpace(Sizes.s8),
                    Text("${getSymbol(context)}${currency(context).currencyVal * e.value.amount!}",
                        style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.darkText)),
                  ],
                )
              ],
            ).paddingAll(Sizes.s12).boxShapeExtension(color: appColor(context).appTheme.primary.withOpacity(.10))),
      ],
    );
  }
}
