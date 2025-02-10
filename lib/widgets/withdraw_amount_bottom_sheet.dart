import 'package:flutter/cupertino.dart';

import '../config.dart';

class WithdrawAmountBottomSheet extends StatelessWidget {
  const WithdrawAmountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider,WalletProvider>(builder: (context1, value,wallet, child) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.90,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(language(context, appFonts.withdrawMoney),
                              style: appCss.dmDenseMedium18.textColor(
                                  appColor(context).appTheme.darkText)),
                          const Icon(CupertinoIcons.multiply)
                              .inkWell(onTap: () => route.pop(context))
                        ]).paddingSymmetric(horizontal: Insets.i20),

                    Expanded(
                        child: Form(
                          key: wallet.withdrawKey,
                          child: Column(children: [
                            const VSpace(Sizes.s25),
                            Expanded(
                                child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(language(context, appFonts.amount),
                                                style: appCss.dmDenseMedium14
                                                    .textColor(appColor(context)
                                                    .appTheme
                                                    .darkText)),
                                            Text(language(context, "${language(context, appFonts.availableBal)} : ${(userModel!.providerWallet != null? double.parse(userModel!.providerWallet!.balance.toString()):0.0)}"),
                                                style: appCss.dmDenseMedium14
                                                    .textColor(appColor(context)
                                                    .appTheme
                                                    .primary))
                                          ]
                                        ).paddingOnly(bottom: Insets.i8),
                                        TextFieldCommon(
                                          keyboardType: TextInputType.number,
                                            focusNode: wallet.amountFocus,
                                            controller: wallet.withDrawAmountCtrl,
                                            validator: (value) => validation.dynamicTextValidation(context, value, appFonts.enterAmount),
                                            hintText: appFonts.enterAmount,
                                            prefixIcon: eSvgAssets.earning),
                                        const VSpace(Sizes.s20),
                                        Text(language(context, appFonts.customMessage),
                                            style: appCss.dmDenseMedium14
                                                .textColor(appColor(context)
                                                .appTheme
                                                .darkText)).paddingOnly(bottom: Insets.i8),
                                        Stack(children: [
                                          TextFieldCommon(
                                              focusNode: value.messageFocus,
                                              isNumber: true,
                                              controller: wallet.messageCtrl,
                                              validator: (value) => validation.dynamicTextValidation(context, value, appFonts.enterDescription),
                                              hintText: appFonts.enterDetails,
                                              maxLines: 3,
                                              minLines: 3,
                                              isMaxLine: true),
                                          SvgPicture.asset(eSvgAssets.details, fit: BoxFit.scaleDown,colorFilter: ColorFilter.mode( !value.messageFocus.hasFocus ? wallet.messageCtrl.text.isNotEmpty ?
                                          appColor(context).appTheme.darkText
                                              : appColor(context).appTheme.lightText
                                              : appColor(context).appTheme.darkText, BlendMode.srcIn))
                                              .paddingOnly(
                                              left: rtl(context) ? 0 : Insets.i15,
                                              right: rtl(context) ? Insets.i15 : 0,
                                              top: Insets.i13)
                                        ]),
                                      ]
                                    ).paddingAll(Insets.i15).boxShapeExtension(color: appColor(context).appTheme.fieldCardBg,radius: AppRadius.r15)).paddingSymmetric(horizontal: Insets.i20)),

                            BottomSheetButtonCommon(
                                textOne: appFonts.cancel,
                                textTwo: appFonts.withdraw,
                                applyTap: ()=> wallet.withdrawRequest(context),
                                clearTap: () {
                                  wallet.amountCtrl.text ="";
                                  wallet.withDrawAmountCtrl.text ="";
                                  wallet.messageCtrl.text ="";

                                  route.pop(context);
                                }).padding(horizontal: Insets.i20,bottom: Insets.i20)
                          ]),
                        ))
                  ]).paddingOnly(top: Insets.i20))
              .bottomSheetExtension(context),
        ),
      );
    });
  }
}
