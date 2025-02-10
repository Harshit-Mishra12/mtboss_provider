import '../../../config.dart';

class BankDetailBodyWidget extends StatelessWidget {
  const BankDetailBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BankDetailProvider>(builder: (context1, value, child) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContainerWithTextLayout(
                title: language(context, appFonts.bankName)),
            const VSpace(Sizes.s8),
            TextFieldCommon(
                    focusNode: value.bankNameFocus,
                    onFieldSubmitted: (v) => validation.fieldFocusChange(
                        context, value.bankNameFocus, value.holdNameFocus),
                    textCapitalization: TextCapitalization.characters,
                    controller: value.bankNameCtrl,
                    hintText: appFonts.bankName,
                    prefixIcon: eSvgAssets.bank)
                .paddingSymmetric(horizontal: Insets.i20),
            ContainerWithTextLayout(title: appFonts.holderName)
                .paddingOnly(top: Insets.i10, bottom: Insets.i5),
            TextFieldCommon(
                    focusNode: value.holdNameFocus,
                    controller: value.holderNameCtrl,
                    onFieldSubmitted: (v) => validation.fieldFocusChange(
                        context, value.holdNameFocus, value.accountFocus),
                    textCapitalization: TextCapitalization.characters,
                    hintText: appFonts.holderName,
                    prefixIcon: eSvgAssets.profile)
                .paddingSymmetric(horizontal: Insets.i20),
            ContainerWithTextLayout(title: appFonts.accountNo)
                .paddingOnly(top: Insets.i10, bottom: Insets.i5),
            TextFieldCommon(
                    focusNode: value.accountFocus,
                    onFieldSubmitted: (v) => validation.fieldFocusChange(
                        context, value.accountFocus, value.branchFocus),
                    controller: value.accountCtrl,
                    hintText: appFonts.accountNo,
                    prefixIcon: eSvgAssets.account)
                .paddingSymmetric(horizontal: Insets.i20),
            ContainerWithTextLayout(title: appFonts.branchName)
                .paddingOnly(top: Insets.i10, bottom: Insets.i5),
            TextFieldCommon(
                    focusNode: value.branchFocus,
                    onFieldSubmitted: (v) => validation.fieldFocusChange(
                        context, value.branchFocus, value.ifscFocus),
                    controller: value.branchCtrl,
                    textCapitalization: TextCapitalization.characters,
                    hintText: appFonts.branchName,
                    prefixIcon: eSvgAssets.bank)
                .paddingSymmetric(horizontal: Insets.i20),
            ContainerWithTextLayout(title: appFonts.ifscCode)
                .paddingOnly(top: Insets.i10, bottom: Insets.i5),
            TextFieldCommon(
                    focusNode: value.ifscFocus,
                    onFieldSubmitted: (v) => validation.fieldFocusChange(
                        context, value.ifscFocus, value.swiftFocus),
                    controller: value.ifscCtrl,
                    textCapitalization: TextCapitalization.characters,
                    hintText: appFonts.ifscCode,
                    prefixIcon: eSvgAssets.identity)
                .paddingSymmetric(horizontal: Insets.i20),
            ContainerWithTextLayout(title: appFonts.swiftCode)
                .paddingOnly(top: Insets.i10, bottom: Insets.i5),
            TextFieldCommon(
                    focusNode: value.swiftFocus,
                    onFieldSubmitted: (v) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    controller: value.swiftCtrl,
                    textCapitalization: TextCapitalization.characters,
                    hintText: appFonts.swiftCode,
                    prefixIcon: eSvgAssets.identity)
                .paddingSymmetric(horizontal: Insets.i20),
          ]).paddingSymmetric(vertical: Insets.i20);
    });
  }
}
