import '../../../config.dart';

class EarningHistoryScreen extends StatelessWidget {
  const EarningHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EarningHistoryProvider>(builder: (context, value, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(
              const Duration(milliseconds: 100), () => value.onInit()),
          child: Scaffold(
              appBar: AppBar(
                  leadingWidth: 80,
                  title: Text(language(context, appFonts.earningHistory),
                      style: appCss.dmDenseBold18
                          .textColor(appColor(context).appTheme.darkText)),
                  centerTitle: true,
                  leading: CommonArrow(
                          arrow: rtl(context)
                              ? eSvgAssets.arrowRight
                              : eSvgAssets.arrowLeft,
                          onTap: () => route.pop(context))
                      .padding(vertical: Insets.i8),
                  actions: [
                    CommonArrow(arrow: eSvgAssets.calender)
                        .paddingSymmetric(horizontal: Insets.i20)
                        .inkWell(onTap: () => value.onTapCalender(context))
                  ]),
              body: SingleChildScrollView(
                  child: Column(children: [
                Row(children: [
                  Expanded(
                      flex: 4,
                      child: Text(language(context, appFonts.sortByCategories),
                          style: appCss.dmDenseMedium14.textColor(
                              appColor(context).appTheme.lightText))),
                  Expanded(
                      flex: 3,
                      child: DarkDropDownLayout(
                          hintText: "All categories",
                          val: value.countryValue,
                          isOnlyText: true,
                          isIcon: false,
                          isField: true,
                          categoryList: appArray.allCategories,
                          onChanged: (val) => value.onChangeCountry(val)))
                ]).paddingSymmetric(vertical: Insets.i20),
                ...commissionList!.histories!
                    .asMap()
                    .entries
                    .map((e) => HistoryLayout(data: e.value))

              ]).paddingSymmetric(horizontal: Insets.i20))));
    });
  }
}
