import '../../../../config.dart';

class AddServiceLayout extends StatelessWidget {
  final List<ExtraCharges>? extraCharge;
  const AddServiceLayout({super.key, this.extraCharge});

  @override
  Widget build(BuildContext context) {
    /*final value = Provider.of<AddExtraChargesProvider>(context);*/
    return Column(
      children: extraCharge!.asMap().entries.map((e) => Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(e.value.title!,
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.darkText)),
            const VSpace(Sizes.s5),
            Text("${getSymbol(context)}${currency(context).currencyVal * e.value.perServiceAmount!} per service",
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.primary))
          ]),
          Image.asset(eImageAssets.serviceIcon,
              height: Sizes.s46, width: Sizes.s46)
        ]),
        const DottedLines().paddingSymmetric(vertical: Insets.i12),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(language(context, appFonts.noOfServiceDone),
              style: appCss.dmDenseMedium12
                  .textColor(appColor(context).appTheme.darkText)),
          Text(e.value.noServiceDone != null ? e.value.noServiceDone.toString():"0",
              style: appCss.dmDenseMedium12
                  .textColor(appColor(context).appTheme.darkText))
        ])
      ]).paddingAll(Insets.i15).boxBorderExtension(context, isShadow: true).paddingOnly(bottom: Insets.i20)).toList()
    );
  }
}
