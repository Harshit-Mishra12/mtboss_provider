import '../../../config.dart';

class ServiceReviewScreen extends StatelessWidget {
  const ServiceReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceReviewProvider>(builder: (context1, value, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(
              const Duration(milliseconds: 20), () => value.onReady(context)),
          child: PopScope(
              canPop: true,
              onPopInvoked: (bool? popInvoke) => value.onBack(context, false),
              child: Scaffold(
                  appBar: AppBarCommon(
                      title: appFonts.review,
                      onTap: () => value.onBack(context, true)),
                  body: SingleChildScrollView(
                      child: Column(children: [
                    value.services == null
                        ? Container()
                        : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                RatingLayout(
                                    initialRating:
                                        value.services!.ratingCount != null
                                            ? double.parse(value
                                                .services!.ratingCount
                                                .toString())
                                            : 0),
                                Row(children: [
                                  Text(language(context, appFonts.averageRate),
                                      style: appCss.dmDenseMedium12.textColor(
                                          appColor(context).appTheme.primary)),
                                  const HSpace(Sizes.s4),
                                  Text("${value.services!.ratingCount ?? 0}/5",
                                      style: appCss.dmDenseSemiBold12.textColor(
                                          appColor(context).appTheme.primary))
                                ])
                              ])
                            .paddingSymmetric(
                                vertical: Insets.i12, horizontal: Insets.i15)
                            .decorated(
                                color: appColor(context)
                                    .appTheme
                                    .primary
                                    .withOpacity(0.1),
                                border: Border.all(
                                    color: appColor(context).appTheme.primary),
                                borderRadius:
                                    BorderRadius.circular(AppRadius.r20))
                            .paddingSymmetric(horizontal: Insets.i40),
                    if (value.services != null) const VSpace(Sizes.s15),
                    value.services == null
                        ? Container()
                        : Column(
                                children: value
                                    .services!.reviewRatings!.reversed
                                    .toList()
                                    .asMap()
                                    .entries
                                    .map((e) => ProgressBarLayout(
                                        data: e.value,
                                        index: e.key,
                                        list: value.services!.reviewRatings!))
                                    .toList())
                            .paddingSymmetric(
                                vertical: Insets.i15, horizontal: Insets.i20)
                            .boxBorderExtension(context, isShadow: true),
                    const VSpace(Sizes.s25),
                    Row(children: [
                      Expanded(
                          flex: 4,
                          child: Text(language(context, appFonts.review),
                              style: appCss.dmDenseMedium16.textColor(
                                  appColor(context).appTheme.darkText))),
                      Expanded(
                          flex: 3,
                          child: DarkDropDownLayout(
                              isOnlyText: true,
                              isField: true,
                              isIcon: false,
                              hintText: appFonts.all,
                              val: value.exValue,
                              reviewLowHighList: appArray.reviewLowHighList,
                              onChanged: (val) => value.onReview(val)))
                    ]),
                    const VSpace(Sizes.s15),
                    if(value.reviewList.isEmpty)
                      const CommonEmpty(),
                    if(value.reviewList.isNotEmpty)
                    ...value.reviewList.asMap().entries.map((e) =>
                        ServiceReviewLayout(
                            isSetting: value.isSetting,
                            onTap: () => value.onTap(context,e.value),
                            data: e.value,
                            index: e.key,
                            list: appArray.reviewList))
                  ]).padding(horizontal: Insets.i20, bottom: Insets.i20)))));
    });
  }
}
