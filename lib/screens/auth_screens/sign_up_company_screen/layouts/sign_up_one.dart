import '../../../../config.dart';

class SignUpOne extends StatelessWidget {
  const SignUpOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpCompanyProvider>(builder: (context1, value, child) {
      return Form(
          key: value.signupFormKey1,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ContainerWithTextLayout(title: appFonts.logo),
            const VSpace(Sizes.s12),
             CompanyLogoLayout(imageFile: value.imageFile)
                .inkWell(onTap: () => value.onImagePick(context))
                .paddingSymmetric(horizontal: Insets.i20),
            ContainerWithTextLayout(title: appFonts.companyName)
                .paddingOnly(top: Insets.i24, bottom: Insets.i8),
            TextFieldCommon(
                    controller: value.companyName,
                    validator: (v) => validation.nameValidation(context, v),
                    focusNode: value.companyNameFocus,
                    hintText: appFonts.enterCompanyName,
                    prefixIcon: eSvgAssets.companyName)
                .paddingSymmetric(horizontal: Insets.i20),
            ContainerWithTextLayout(title: appFonts.companyPhoneNo)
                .paddingOnly(top: Insets.i24, bottom: Insets.i8),
            RegisterWidgetClass().phoneTextBox(
                dialCode: value.dialCode,
                context, value.companyPhone, value.phoneNameFocus,
                onChanged: (CountryCodeCustom? code) =>
                    value.changeDialCode(code!),
                onFieldSubmitted: (values) => validation.fieldFocusChange(
                    context, value.phoneNameFocus, value.companyMailFocus)),
            ContainerWithTextLayout(title: appFonts.companyMail)
                .paddingOnly(top: Insets.i24, bottom: Insets.i8),
            TextFieldCommon(
                    validator: (v) => validation.emailValidation(context, v),
                    controller: value.companyMail,
                    focusNode: value.companyMailFocus,
                    keyboardType: TextInputType.emailAddress,
                    hintText: appFonts.enterMail,
                    prefixIcon: eSvgAssets.email)
                .paddingSymmetric(horizontal: Insets.i20),
            ContainerWithTextLayout(title: appFonts.experience)
                .paddingOnly(top: Insets.i24, bottom: Insets.i8),
            Row(children: [
              Expanded(
                  flex: 3,
                  child: TextFieldCommon(
                          keyboardType: TextInputType.number,
                          validator: (v) =>
                              validation.commonValidation(context, v),
                          focusNode: value.experienceFocus,
                          controller: value.experience,
                          hintText: appFonts.addExperience,
                          prefixIcon: eSvgAssets.timer)
                      .paddingOnly(
                          left: rtl(context) ? 0 : Insets.i20,
                          right: rtl(context) ? Insets.i20 : 0)),
              Expanded(
                  flex: 2,
                  child: DarkDropDownLayout(
                          isBig: true,
                          val: value.chosenValue,
                          hintText: appFonts.month,
                          isIcon: false,
                          categoryList: appArray.experienceList,
                          onChanged: (val) => value.onDropDownChange(val))
                      .paddingOnly(
                          right: rtl(context) ? Insets.i8 : Insets.i20,
                          left: rtl(context) ? Insets.i20 : Insets.i8))
            ]),
            ContainerWithTextLayout(title: appFonts.description)
                .paddingOnly(top: Insets.i24, bottom: Insets.i8),
            Stack(children: [
              TextFieldCommon(
                      focusNode: value.descriptionFocus,
                      isNumber: true,
                      validator: (v) => validation.dynamicTextValidation(
                          context, v, appFonts.pleaseEnterDesc),
                      controller: value.description,
                      hintText: appFonts.enterDetails,
                      maxLines: 3,
                      minLines: 3,
                      isMaxLine: true)
                  .paddingSymmetric(horizontal: Insets.i20),
              SvgPicture.asset(eSvgAssets.details,
                      fit: BoxFit.scaleDown,
                      colorFilter: ColorFilter.mode(
                          !value.descriptionFocus.hasFocus
                              ? value.description.text.isNotEmpty
                                  ? appColor(context).appTheme.darkText
                                  : appColor(context).appTheme.lightText
                              : appColor(context).appTheme.darkText,
                          BlendMode.srcIn))
                  .paddingOnly(
                      left: rtl(context) ? 0 : Insets.i35,
                      right: rtl(context) ? Insets.i35 : 0,
                      top: Insets.i13)
            ])
          ]));
    });
  }
}
