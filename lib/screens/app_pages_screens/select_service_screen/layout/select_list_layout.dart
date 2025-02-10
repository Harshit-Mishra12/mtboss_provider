import '../../../../config.dart';

class SelectListLayout extends StatelessWidget {
  final Services? data;
  final List<Services>? selectedCategory;
  final GestureTapCallback? onTap;

  const SelectListLayout(
      {super.key, this.data, this.selectedCategory, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
    data!.media != null && data!.media!.isNotEmpty?    CachedNetworkImage(
          imageUrl: data!.media![0].originalUrl!,
          imageBuilder: (context, imageProvider) => Container(
              height: Sizes.s40,
              width: Sizes.s40,
              decoration: ShapeDecoration(
                  image:
                      DecorationImage(fit: BoxFit.cover, image: imageProvider),
                  shape: const SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius.all(SmoothRadius(
                          cornerRadius: AppRadius.r8, cornerSmoothing: 1))))),
          placeholder: (context, url) => CommonCachedImage(
              height: Sizes.s40,
              width: Sizes.s40,
              image: eImageAssets.noImageFound3,
              radius: AppRadius.r8),
          errorWidget: (context, url, error) =>  CommonCachedImage(
              height: Sizes.s40,
              width: Sizes.s40,
              image: eImageAssets.noImageFound3,
              radius: AppRadius.r8),
        ): CommonCachedImage(
            height: Sizes.s40,
            width: Sizes.s40,
            image: eImageAssets.noImageFound3,
            radius: AppRadius.r8),
        const HSpace(Sizes.s12),
        Text(language(context, data!.title),
            style: appCss.dmDenseMedium15
                .textColor(appColor(context).appTheme.darkText))
      ]),
      CheckBoxCommon(
          isCheck: selectedCategory!.where((element) => element.id == data!.id).isNotEmpty, onTap: onTap)
    ])
        .paddingSymmetric(vertical: Insets.i12, horizontal: Insets.i15)
        .boxBorderExtension(context,
            radius: AppRadius.r10, bColor: appColor(context).appTheme.stroke)
        .paddingOnly(bottom: Insets.i15);
  }
}
