import '../../../../config.dart';

class AddPackageBodyWidget extends StatelessWidget {
  const AddPackageBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AddPackageProvider, SelectServiceProvider>(
        builder: (context1, value, selectVal, child) {
      return SingleChildScrollView(
          child: Form(
        key: value.addPackageFormKey,
        child: Column(children: [
          Stack(children: [
            const FieldsBackground(),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ContainerWithTextLayout(
                  title: language(context, appFonts.packageName)),
              const VSpace(Sizes.s8),
              TextFieldCommon(
                      focusNode: value.packageFocus,
                      controller: value.packageCtrl,
                      validator: (value) => validation.dynamicTextValidation(
                          context, value, appFonts.enterPackageName),
                      hintText: language(context, appFonts.enterPackageName),
                      prefixIcon: eSvgAssets.packageName)
                  .padding(horizontal: Insets.i20, bottom: Insets.i15),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  const SmallContainer(),
                  const HSpace(Sizes.s20),
                  Text(language(context, appFonts.selectServiceOnly),
                          //overflow: TextOverflow.ellipsis,
                          style: appCss.dmDenseSemiBold14
                              .textColor(appColor(context).appTheme.darkText))
                      .width(Sizes.s120)
                ]),
                if (selectVal.selectServiceList.isNotEmpty)
                  Text(language(context, appFonts.editService),
                          textAlign:
                              rtl(context) ? TextAlign.end : TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: appCss.dmDenseMedium12
                              .textColor(appColor(context).appTheme.primary))
                      .inkWell(
                          onTap: () =>
                              route.pushNamed(context, routeName.selectService))
                      .paddingSymmetric(horizontal: Insets.i20)
              ]),
              const VSpace(Sizes.s15),
              selectVal.selectServiceList.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                              children: selectVal.selectServiceList
                                  .asMap()
                                  .entries
                                  .map((e) => SelectServiceLayout(
                                      onTapCross: () =>
                                          selectVal.onImageRemove(e.key),
                                      data: e.value))
                                  .toList())
                          .paddingOnly(
                              left: rtl(context) ? 0 : Insets.i20,
                              right: rtl(context) ? Insets.i20 : 0))
                  : AddNewBoxLayout(
                          title: appFonts.addNew,
                          onAdd: () =>
                              route.pushNamed(context, routeName.selectService))
                      .paddingSymmetric(horizontal: Insets.i20),
              const VSpace(Sizes.s20),
              const PackageDescriptionForm()
            ]).paddingSymmetric(vertical: Insets.i20)
          ]),
          ButtonCommon(
                  title: value.isEdit
                      ? appFonts.updatePackage
                      : appFonts.addPackage,
                  onTap: () => value.addData(context))
              .paddingOnly(top: Insets.i40, bottom: Insets.i30)
        ]).paddingSymmetric(horizontal: Insets.i20),
      ));
    });
  }
}
