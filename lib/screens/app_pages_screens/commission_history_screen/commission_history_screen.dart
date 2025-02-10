import '../../../config.dart';

class CommissionHistory extends StatelessWidget {
  const CommissionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CommissionHistoryProvider, UserDataApiProvider>(
        builder: (context1, value, userApi, child) {
      return LoadingComponent(
        child: Scaffold(
            appBar: ActionAppBar(title: appFonts.commissionHistory, actions: [
              if (!isServiceman && !isFreelancer)
                CommonArrow(
                        arrow: eSvgAssets.about,
                        onTap: () =>
                            route.pushNamed(context, routeName.commissionInfo))
                    .paddingOnly(right: Insets.i20)
            ]),
            body: commissionList == null
                ? const CommonEmpty()
                : SingleChildScrollView(
                    child: Column(children: [
                    Container(
                        height: Sizes.s64,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage(eImageAssets.balanceContainer),
                                fit: BoxFit.fill)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Image.asset(eImageAssets.discount,
                                    width: Sizes.s40, height: Sizes.s40),
                                const HSpace(Sizes.s10),
                                Text(
                                        language(context,
                                            appFonts.totalReceivedCommission),
                                        style: appCss.dmDenseMedium15.textColor(
                                            appColor(context)
                                                .appTheme
                                                .whiteColor
                                                .withOpacity(0.7)))
                                    .width(Sizes.s110)
                              ]),
                              Text(
                                  "${getSymbol(context)}${currency(context).currencyVal * commissionList!.total!}",
                                  style: appCss.dmDenseblack20.textColor(
                                      appColor(context).appTheme.whiteColor))
                            ]).paddingSymmetric(horizontal: Insets.i12)),
                    const VSpace(Sizes.s20),
                    if (!isServiceman && !isFreelancer)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: Sizes.s200,
                                child: Text(
                                    language(
                                        context, appFonts.onlyCompletedByMe),
                                    style: appCss.dmDenseMedium12.textColor(
                                        value.isCompletedMe
                                            ? appColor(context).appTheme.primary
                                            : appColor(context)
                                                .appTheme
                                                .darkText))),
                            FlutterSwitchCommon(
                                value: value.isCompletedMe,
                                onToggle: (val) =>
                                    value.onTapSwitch(val, context))
                          ]).paddingAll(Insets.i15).boxShapeExtension(
                          color: value.isCompletedMe
                              ? appColor(context)
                                  .appTheme
                                  .primary
                                  .withOpacity(0.15)
                              : appColor(context).appTheme.fieldCardBg,
                          radius: AppRadius.r10),
                    if (!isServiceman && !isFreelancer) const VSpace(Sizes.s20),
                    if (commissionList!.histories!.isEmpty) const CommonEmpty(),
                    if (commissionList!.histories!.isNotEmpty)
                      ...commissionList!.histories!.asMap().entries.map((e) =>
                          CommissionHistoryLayout(
                              data: e.value,
                              onTap: () => route.pushNamed(
                                  context, routeName.bookingDetails,
                                  arg: e.value)))
                  ]).paddingSymmetric(horizontal: Insets.i20))),
      );
    });
  }
}
