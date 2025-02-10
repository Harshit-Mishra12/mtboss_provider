import '../../../../config.dart';

class PackageDescriptionForm extends StatelessWidget {
  const PackageDescriptionForm({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<AddPackageProvider>(builder: (context, value, child) {
        return Column(children: [
          ContainerWithTextLayout(title: appFonts.hexa)
              .paddingOnly( bottom: Insets.i8),
          TextFieldCommon(

              focusNode: value.hexaFocus,onTap: ()=> value.showPicker(context),
              controller: value.hexaCtrl,
              validator: (value) => validation.dynamicTextValidation(context, value, appFonts.pleaseSelectHexaCode),
              hintText: language(context, appFonts.hexaCode),
              prefixIcon: eSvgAssets.category)
              .padding(horizontal: Insets.i20, bottom: Insets.i15),
          ContainerWithTextLayout(title: appFonts.packageDescription)
              .paddingOnly(bottom: Insets.i8),
          Stack(children: [
            TextFieldCommon(
                    focusNode: value.descriptionFocus,
                    isNumber: true,
                    controller: value.descriptionCtrl,
                    hintText: appFonts.writeHere,
                validator: (value) => validation.dynamicTextValidation(context, value, appFonts.enterDescription),
                    maxLines: 3,
                    minLines: 3,
                    isMaxLine: true)
                .paddingSymmetric(horizontal: Insets.i20),
            SvgPicture.asset(eSvgAssets.details, fit: BoxFit.scaleDown,colorFilter: ColorFilter.mode(!value.descriptionFocus.hasFocus
                ? value.descriptionCtrl.text.isNotEmpty
                ? appColor(context).appTheme.darkText
                : appColor(context).appTheme.lightText
                : appColor(context).appTheme.darkText, BlendMode.srcIn)).paddingOnly(
                left: rtl(context) ? 0 : Insets.i35,
                right: rtl(context) ? Insets.i35 : 0,
                top: Insets.i13)
          ]),
          ContainerWithTextLayout(title: appFonts.amount)
              .paddingOnly(top: Insets.i15, bottom: Insets.i8),
          TextFieldCommon(
            keyboardType: TextInputType.number,
                  focusNode: value.amountFocus,
                  controller: value.amountCtrl,
              validator: (value) => validation.dynamicTextValidation(context, value, appFonts.enterAmount),
                  hintText: language(context, appFonts.enterAmt),
                  prefixIcon: eSvgAssets.dollar)
              .padding(horizontal: Insets.i20, bottom: Insets.i15),
          ContainerWithTextLayout(title: appFonts.discount)
              .paddingOnly( bottom: Insets.i8),
          TextFieldCommon(
              keyboardType: TextInputType.number,
              focusNode: value.discountFocus,
              controller: value.discountCtrl,
              hintText: language(context, appFonts.discount),
              prefixIcon: eSvgAssets.discount)
              .padding(horizontal: Insets.i20, bottom: Insets.i15),
          Row(children: [
            Expanded(
                child: Column(children: [
              Row(children: [
                const SmallContainer(),
                const HSpace(Sizes.s20),
                Text(language(context, appFonts.startDate),
                    overflow: TextOverflow.ellipsis,
                    style: appCss.dmDenseSemiBold14
                        .textColor(appColor(context).appTheme.darkText))
              ]).paddingOnly(bottom: Insets.i8),
              TextFieldCommon(
                      isEnable: false,
                      focusNode: value.startDateFocus,
                      controller: value.startDateCtrl,
                  style: appCss.dmDenseMedium13
                      .textColor(appColor(context).appTheme.darkText),
                  validator: (value) => validation.dynamicTextValidation(context, value, appFonts.pleaseSelectStartDate),
                      hintText: appFonts.startDate,
                      prefixIcon: eSvgAssets.calender).inkWell(onTap: ()=> value.onDateSelect(context,value.startDateCtrl.text))
                  .paddingOnly(
                      left: rtl(context) ? 0 : Insets.i20,
                      right: rtl(context) ? Insets.i20 : 0)
            ])),
            const HSpace(Sizes.s15),
            Expanded(
                child:
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(language(context, appFonts.endDate),
                      style: appCss.dmDenseSemiBold14
                          .textColor(appColor(context).appTheme.darkText))
                  .paddingOnly(bottom: Insets.i10, top: Insets.i5),
              TextFieldCommon(
                      isEnable: false,
                      focusNode: value.endDateFocus,
                      controller: value.endDateCtrl,
                      hintText: appFonts.endDate,
                  style: appCss.dmDenseMedium13
                      .textColor(appColor(context).appTheme.darkText),
                  validator: (value) => validation.dynamicTextValidation(context, value, appFonts.pleaseSelectEndDate),
                      prefixIcon: eSvgAssets.calender).inkWell(onTap: ()=> value.onDateSelect(context,value.endDateCtrl.text))
                  .paddingOnly(
                      right: rtl(context) ? 0 : Insets.i20,
                      left: rtl(context) ? Insets.i20 : 0)
            ]))
          ]),
          const VSpace(Sizes.s15),
          ContainerWithTextLayout(title: appFonts.disclaimer)
              .paddingOnly(bottom: Insets.i8),
          Stack(children: [
            TextFieldCommon(
                    focusNode: value.disclaimerFocus,
                    isNumber: true,
                    controller: value.disclaimerCtrl,
                    hintText: appFonts.addCustomNote,

                    maxLines: 3,
                    minLines: 3,
                    isMaxLine: true)
                .paddingSymmetric(horizontal: Insets.i20),
            SvgPicture.asset(eSvgAssets.details,
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(
                        !value.disclaimerFocus.hasFocus
                            ? value.disclaimerCtrl.text.isNotEmpty
                            ? appColor(context).appTheme.darkText
                            : appColor(context).appTheme.lightText
                            : appColor(context).appTheme.darkText,
                        BlendMode.srcIn))
                .paddingOnly(
                    left: rtl(context) ? 0 : Insets.i35,
                    right: rtl(context) ? Insets.i35 : 0,
                    top: Insets.i13)
          ]),
          const VSpace(Sizes.s20),
          StatusLayoutCommon(
              title: appFonts.activeNow,
              value: value.isSwitch,
              onToggle: (val) => value.onSwitch(val))
        ]);
      }
    );
  }
}
