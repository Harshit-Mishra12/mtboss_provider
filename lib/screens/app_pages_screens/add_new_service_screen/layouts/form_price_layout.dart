import '../../../../config.dart';

class FormPriceLayout extends StatelessWidget {
  const FormPriceLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewServiceProvider>(builder: (context1, value, child) {
      return Column(children: [
        ContainerWithTextLayout(title: language(context, appFonts.price))
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        Container(
                decoration: ShapeDecoration(
                    color: appColor(context).appTheme.whiteBg,
                    shape: RoundedRectangleBorder(
                        borderRadius: SmoothBorderRadius(
                            cornerRadius: AppRadius.r8, cornerSmoothing: 0))),
                child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: appArray.priceList
                            .asMap()
                            .entries
                            .map((e) => PriceLayout(
                                title: e.value["title"],
                                index: e.key,
                                selectIndex: value.selectIndex,
                                onTap: () => value.onChangePrice(e.key)))
                            .toList())
                    .paddingAll(Insets.i15))
            .paddingSymmetric(horizontal: Insets.i20),
        if (value.selectIndex == 0)
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ContainerWithTextLayout(title: language(context, appFonts.amount))
                .paddingOnly(top: Insets.i24, bottom: Insets.i12),
            TextFieldCommon(
                    keyboardType: TextInputType.number,
                    focusNode: value.amountFocus,
                    controller: value.amount,
                    hintText: appFonts.enterAmt,
                    prefixIcon: eSvgAssets.dollar)
                .padding(horizontal: Insets.i20)
          ]),
        if (value.selectIndex == 1)
          Column(children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContainerWithTextLayout(title: language(context, appFonts.amount))
                      .paddingOnly(bottom: Insets.i12),
              TextFieldCommon(
                  keyboardType: TextInputType.number,
                  focusNode: value.amountFocus,
                  controller: value.amount,
                  hintText: appFonts.enterAmt,
                  prefixIcon: eSvgAssets.dollar).paddingSymmetric(horizontal: Sizes.s20)
            ]),
            const VSpace(Sizes.s20),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContainerWithTextLayout(title: language(context, appFonts.discount))
                      .paddingOnly(bottom: Insets.i12),
              TextFieldCommon(
                  keyboardType: TextInputType.number,
                  focusNode: value.discountFocus,
                  controller: value.discount,
                  hintText: appFonts.addDic,
                  prefixIcon: eSvgAssets.discount).paddingSymmetric(horizontal: Sizes.s20)
            ])
          ]).padding( top: Insets.i24),
        ContainerWithTextLayout(title: language(context, appFonts.tax))
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        TaxDropDownLayout(
                doc: value.taxIndex,
                icon: eSvgAssets.receiptDiscount,
                hintText: appFonts.selectTax,
                isIcon: true,
                tax: taxList,
                onChanged: (val) => value.onChangeTax(val))
            .paddingSymmetric(horizontal: Insets.i20),
        const VSpace(Sizes.s20),

        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 8,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(language(context, appFonts.status),
                        style: appCss.dmDenseSemiBold14
                            .textColor(appColor(context).appTheme.darkText)),
                    Text(language(context, appFonts.thisServiceCanBe),
                        style: appCss.dmDenseRegular12
                            .textColor(appColor(context).appTheme.lightText))
                  ])),
          const HSpace(Sizes.s25),
          Expanded(
              flex: 2,
              child: FlutterSwitchCommon(
                  value: value.isSwitch,
                  onToggle: (val) => value.onTapSwitch(val)))
        ])
            .paddingAll(Insets.i15)
            .boxShapeExtension(color: appColor(context).appTheme.whiteBg)
            .paddingSymmetric(horizontal: Insets.i20)
      ]);
    });
  }
}
