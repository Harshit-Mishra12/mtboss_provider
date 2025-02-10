import 'package:fixit_provider/screens/app_pages_screens/services_details_screen/service_detail_shimmer/services_details_shimmer.dart';

import '../../../config.dart';

class ServicesDetailsScreen extends StatefulWidget {
  const ServicesDetailsScreen({super.key});

  @override
  State<ServicesDetailsScreen> createState() => _ServicesDetailsScreenState();
}

class _ServicesDetailsScreenState extends State<ServicesDetailsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ServiceDetailsProvider, LocationProvider>(
        builder: (context1, value, val, child) {
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          value.onBack(context, false);
          if (didPop) return;
        },
        child: Container(
          color: appColor(context).appTheme.whiteBg,
          child: SafeArea(
            child: StatefulWrapper(
              onInit: () => Future.delayed(DurationsDelay.ms150)
                  .then((_) => value.onReady(context)),
              child: RefreshIndicator(
                onRefresh: () {
                  return value.onRefresh(context);
                },
                child: LoadingComponent(
                  child: Scaffold(
                      body: (value.widget1Opacity == 0.0)
                          ? const ServiceDetailShimmer()
                          : value.services != null
                              ? SingleChildScrollView(
                                  child: Column(children: [
                                  ServiceImageLayout(
                                      onBack: () => value.onBack(context, true),
                                      editTap: () => route.pushNamed(
                                              context, routeName.addNewService,
                                              arg: {
                                                "isEdit": true,
                                                "service": value.services,
                                                "serviceFaq": value.serviceFaq,
                                              }).then((e) =>
                                              value.getServiceId(context)),
                                      deleteTap: () =>
                                          value.onServiceDelete(context, this),
                                      title: value.services!.title!,
                                      image: value.selectedImage,
                                      rating:
                                          value.services!.ratingCount != null
                                              ? value.services!.ratingCount!
                                                  .toString()
                                              : "0"),
                                  if (value.services!.media != null &&
                                      value.services!.media!.length > 1)
                                    const VSpace(Sizes.s12),
                                  if (value.services!.media != null ||
                                      value.services!.media!.length > 1)
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: value.services!.media!
                                            .asMap()
                                            .entries
                                            .map((e) => ServicesImageLayout(
                                                data: e.value.originalUrl,
                                                index: e.key,
                                                selectIndex:
                                                    value.selectedIndex,
                                                onTap: () =>
                                                    value.onImageChange(e.key,
                                                        e.value.originalUrl!)))
                                            .toList()),
                                  Column(children: [
                                    Stack(
                                            alignment: Alignment.center,
                                            children: [
                                          Image.asset(eImageAssets.servicesBg,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    language(context,
                                                        appFonts.amount),
                                                    style: appCss
                                                        .dmDenseMedium12
                                                        .textColor(
                                                            appColor(context)
                                                                .appTheme
                                                                .primary)),
                                                Text(
                                                    "${getSymbol(context)}${currency(context).currencyVal * (value.services!.price!)}",
                                                    style: appCss.dmDenseBold18
                                                        .textColor(
                                                            appColor(context)
                                                                .appTheme
                                                                .primary))
                                              ]).paddingSymmetric(
                                              horizontal: Insets.i20)
                                        ])
                                        .paddingSymmetric(vertical: Insets.i15),
                                    ServiceDescription(
                                        services: value.services),
                                    if (value.serviceFaq.isNotEmpty)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const VSpace(Sizes.s10),
                                          Text(language(context, appFonts.faq),
                                              overflow: TextOverflow.clip,
                                              style: appCss.dmDenseBold16
                                                  .textColor(appColor(context)
                                                      .appTheme
                                                      .darkText)),
                                          const VSpace(Sizes.s10),
                                          ...value.serviceFaq
                                              .asMap()
                                              .entries
                                              .map((e) => Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: Sizes.s8),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: Sizes.s20),
                                                    decoration: ShapeDecoration(
                                                        shadows: [
                                                          BoxShadow(
                                                              blurRadius: 2,
                                                              spreadRadius: 2,
                                                              color: appColor(
                                                                      context)
                                                                  .appTheme
                                                                  .darkText
                                                                  .withOpacity(
                                                                      0.06))
                                                        ],
                                                        color: appColor(context)
                                                            .appTheme
                                                            .whiteBg,
                                                        shape: SmoothRectangleBorder(
                                                            borderRadius:
                                                                SmoothBorderRadius(
                                                                    cornerRadius:
                                                                        8,
                                                                    cornerSmoothing:
                                                                        1))),
                                                    child: ExpansionTile(
                                                        expansionAnimationStyle:
                                                            AnimationStyle(
                                                                curve: Curves
                                                                    .fastOutSlowIn),
                                                        key: Key(value.selected
                                                            .toString()),
                                                        initiallyExpanded: e.key ==
                                                            value.selected,
                                                        onExpansionChanged: (newState) =>
                                                            value.onExpansionChange(
                                                                newState,
                                                                e.key),
                                                        //atten
                                                        tilePadding:
                                                            EdgeInsets.zero,
                                                        collapsedIconColor:
                                                            appColor(context)
                                                                .appTheme
                                                                .darkText,
                                                        dense: true,
                                                        iconColor: appColor(context)
                                                            .appTheme
                                                            .darkText,
                                                        title: Text(e.value.question!,
                                                            style: appCss
                                                                .dmDenseMedium14
                                                                .textColor(appColor(context).appTheme.darkText)),
                                                        children: <Widget>[
                                                          Divider(
                                                              color: appColor(
                                                                      context)
                                                                  .appTheme
                                                                  .stroke,
                                                              height: .5,
                                                              thickness: 0),
                                                          ListTile(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          Sizes
                                                                              .s5),
                                                              title: Text(
                                                                  e.value
                                                                      .answer!,
                                                                  style: appCss
                                                                      .dmDenseLight14
                                                                      .textColor(appColor(
                                                                              context)
                                                                          .appTheme
                                                                          .darkText
                                                                          .withOpacity(
                                                                              .8))))
                                                        ]),
                                                  ))
                                        ],
                                      ).marginOnly(top: Sizes.s10),
                                  ]).paddingSymmetric(horizontal: Insets.i20),
                                  Column(children: [
                                    if (value.services!.reviews != null &&
                                        value.services!.reviews!.isNotEmpty)
                                      HeadingRowCommon(
                                          isViewAllShow:
                                              value.services!.reviews!.length >=
                                                  10,
                                          title: appFonts.review,
                                          onTap: () => route.pushNamed(context,
                                                  routeName.serviceReview,
                                                  arg: {
                                                    "service": value.services
                                                  })).paddingOnly(
                                          bottom: Insets.i12),
                                    ...value.services!.reviews!
                                        .asMap()
                                        .entries
                                        .map((e) => ServiceReviewLayout(
                                            data: e.value,
                                            index: e.key,
                                            list: value.services!.reviews!))
                                  ]).paddingAll(Insets.i20)
                                ]))
                              : const CommonEmpty()),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
