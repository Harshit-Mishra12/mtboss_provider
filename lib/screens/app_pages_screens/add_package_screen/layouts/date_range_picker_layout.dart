import 'package:flutter/cupertino.dart';
import '../../../../config.dart';

class DateRangePickerLayout extends StatelessWidget {
  const DateRangePickerLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPackageProvider>(builder: (context1, value, child) {
      return SizedBox(
          height: MediaQuery.of(context).size.height * 0.57,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(language(context, appFonts.selectDate),
                  style: appCss.dmDenseMedium18
                      .textColor(appColor(context).appTheme.darkText)),
              const Icon(CupertinoIcons.multiply)
                  .inkWell(onTap: () => route.pop(context))
            ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i15),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CommonArrow(
                  arrow: eSvgAssets.arrowLeft,
                  onTap: () => value.onLeftArrow()),
              const HSpace(Sizes.s20),
              Container(
                  height: Sizes.s34,
                  alignment: Alignment.center,
                  width: Sizes.s100,
                  child: DropdownButton(
                      underline: Container(),
                      focusColor: Colors.white,
                      value: value.chosenValue,
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: appColor(context).appTheme.darkText,
                      items: appArray.monthList
                          .map<DropdownMenuItem>((monthValue) {
                        return DropdownMenuItem(
                            onTap: () => value.onTapMonth(monthValue['title']),
                            value: monthValue,
                            child: Text(monthValue['title'],
                                style: TextStyle(
                                    color:
                                        appColor(context).appTheme.darkText)));
                      }).toList(),
                      icon: SvgPicture.asset(eSvgAssets.dropDown),
                      onChanged: (choseVal) =>
                          value.onDropDownChange(choseVal))).boxShapeExtension(
                  color: appColor(context).appTheme.fieldCardBg,
                  radius: AppRadius.r4),
              const HSpace(Sizes.s20),
              Container(
                      alignment: Alignment.center,
                      height: Sizes.s34,
                      width: Sizes.s87,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("${value.selectedYear.year}"),
                            SvgPicture.asset(eSvgAssets.dropDown)
                          ]))
                  .boxShapeExtension(
                      color: appColor(context).appTheme.fieldCardBg,
                      radius: AppRadius.r4)
                  .inkWell(onTap: () => value.selectYear(context)),
              const HSpace(Sizes.s20),
              CommonArrow(
                  arrow: eSvgAssets.arrowRight,
                  onTap: () => value.onRightArrow()),
            ]).paddingSymmetric(horizontal: Insets.i10),
            const VSpace(Sizes.s15),
            const CustomTableDateRange(),
            const VSpace(Sizes.s15),
            ButtonCommon(
                    title: appFonts.selectDate,
                    onTap: () => value.onSelect(context))
                .paddingSymmetric(horizontal: Insets.i20)
          ]));
    });
  }
}
