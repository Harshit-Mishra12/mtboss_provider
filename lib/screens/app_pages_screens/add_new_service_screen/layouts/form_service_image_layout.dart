
import '../../../../config.dart';

class FormServiceImageLayout extends StatelessWidget {
  const FormServiceImageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<AddNewServiceProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerWithTextLayout(
            title: language(context,
                "${language(context, appFonts.serviceImages)} (${((value.services != null && value.services!.media != null && value.services!.media!.isNotEmpty ? value.services!.media!.length : 0) + appArray.serviceImageList.length)}/5)")),
        const VSpace(Sizes.s12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                if (value.services != null &&
                    value.services!.media != null &&
                    value.services!.media!.isNotEmpty)
                  ...value.services!.media!.asMap().entries.map((e) => e
                              .value.collectionName ==
                          "thumbnail"
                      ? Container()
                      : AddServiceImageLayout(
                      networkImage: e.value.originalUrl!,
                      onDelete: () =>
                          value.onRemoveNetworkServiceImage(false, index: e.key))
                          .paddingOnly(right: Insets.i15)),
                if (appArray.serviceImageList.isNotEmpty)
                  ...appArray.serviceImageList.asMap().entries.map((e) =>
                      AddServiceImageLayout(
                          image: e.value,
                          onDelete: () =>
                              value.onRemoveServiceImage(false, index: e.key))),
                if (appArray.serviceImageList.length <= 4)
                  AddNewBoxLayout(
                      onAdd: () => value.onImagePick(context, false))
              ])),
          const VSpace(Sizes.s8),
          Text(language(context, appFonts.theMaximumImage),
              style: appCss.dmDenseRegular12
                  .textColor(appColor(context).appTheme.lightText))
        ]).paddingSymmetric(horizontal: Insets.i20),
        ContainerWithTextLayout(
                title: language(context, appFonts.thumbnailImage))
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        if (value.thumbImage != null && value.thumbImage != "")
          AddServiceImageLayout(networkImage: value.thumbImage,

              onDelete: () => value.onRemoveNetworkServiceImage(true))
        /*  Container(
                  height: Sizes.s70,
                  width: Sizes.s70,
                  decoration: ShapeDecoration(
                      image: DecorationImage(
                          image: NetworkImage(value.thumbImage!),
                          fit: BoxFit.cover),
                      shape: RoundedRectangleBorder(
                          borderRadius: SmoothBorderRadius(
                              cornerRadius: AppRadius.r8, cornerSmoothing: 1))))*/
              .paddingSymmetric(horizontal: Insets.i20),
        if (value.thumbImage == null || value.thumbImage == "")
          value.thumbFile != null
              ? AddServiceImageLayout(
                      image: value.thumbFile!,
                      onDelete: () => value.onRemoveServiceImage(true))
                  .paddingSymmetric(horizontal: Insets.i20)
              : AddNewBoxLayout(onAdd: () => value.onImagePick(context, true))
                  .paddingSymmetric(horizontal: Insets.i20),
        const VSpace(Sizes.s8),
        Text(language(context, appFonts.theMaximumImage),
                style: appCss.dmDenseRegular12
                    .textColor(appColor(context).appTheme.lightText))
            .paddingSymmetric(horizontal: Insets.i20),
        ContainerWithTextLayout(title: language(context, appFonts.serviceName))
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        TextFieldCommon(
                focusNode: value.serviceNameFocus,
                controller: value.serviceName,
                hintText: appFonts.enterName,
                prefixIcon: eSvgAssets.serviceName)
            .paddingSymmetric(horizontal: Insets.i20),
      ],
    );
  }
}
