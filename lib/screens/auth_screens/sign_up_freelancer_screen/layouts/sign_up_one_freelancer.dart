import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../../../config.dart';
import '../../../../widgets/multi_dropdown_common.dart';

class SignUpOneFreelancer extends StatelessWidget {
  const SignUpOneFreelancer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpCompanyProvider>(builder: (context1, value, child) {
      return Form(
        key: value.signupFreelanceFormKey1,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ContainerWithTextLayout(title: appFonts.userName)
              .paddingOnly(bottom: Insets.i8),
          TextFieldCommon(
                  focusNode: value.ownerNameFocus,
                  controller: value.ownerName,
                  hintText: appFonts.enterName,
                  validator: (v) => validation.nameValidation(context, v),
                  prefixIcon: eSvgAssets.user)
              .paddingSymmetric(horizontal: Insets.i20),
          ContainerWithTextLayout(title: appFonts.phoneNo)
              .paddingOnly(bottom: Insets.i8, top: Insets.i20),
          RegisterWidgetClass().phoneTextBox(
            dialCode: value.dialCode,
              context, value.providerNumber, value.providerNumberFocus,
              onChanged: (CountryCodeCustom? code) =>
                  value.changeDialCode(code!),
              onFieldSubmitted: (values) => validation.fieldFocusChange(
                  context, value.providerNumberFocus, value.emailFocus)),
          ContainerWithTextLayout(title: appFonts.email)
              .paddingOnly(bottom: Insets.i8, top: Insets.i20),
          TextFieldCommon(
                  focusNode: value.providerEmailFocus,
                  controller: value.providerEmail,
                  validator: (v) => validation.emailValidation(context, v),
                  hintText: appFonts.enterEmail,
                  prefixIcon: eSvgAssets.email)
              .paddingSymmetric(horizontal: Insets.i20),
          ContainerWithTextLayout(title: appFonts.knownLanguage)
              .paddingOnly(bottom: Insets.i8, top: Insets.i20),
          Stack(children: [
            MultiSelectDropDownCustom(
                    onOptionSelected: (options) =>
                        value.onLanguageSelect(options),
                    searchEnabled: true,
                    selectedOptions: value.languageSelect,
                    options: knownLanguageList
                        .asMap()
                        .entries
                        .map((e) => ValueItem(
                            label: language(context, e.value.key),
                            value: e.value.id))
                        .toList(),
                    selectionType: SelectionType.multi,
                    hint: "Select language",
                    hintStyle: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.lightText),
                    chipConfig: CommonWidgetLayout().chipWidget(context),
                    dropdownHeight: 300,
                    padding: const EdgeInsets.only(
                        left: Insets.i40, right: Insets.i10),
                    showClearIcon: false,
                    borderColor: appColor(context).appTheme.trans,
                    borderRadius: AppRadius.r8,
                    suffixIcon: SvgPicture.asset(eSvgAssets.dropDown,
                        colorFilter: ColorFilter.mode(
                            value.languageSelect.isNotEmpty
                                ? appColor(context).appTheme.darkText
                                : appColor(context).appTheme.lightText,
                            BlendMode.srcIn)),
                    optionTextStyle: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.darkText),
                    selectedOptionIcon: Icon(Icons.check_box_rounded,
                        color: appColor(context).appTheme.primary))
                .paddingSymmetric(horizontal: Insets.i20),
            SvgPicture.asset(
              eSvgAssets.country,
              colorFilter: ColorFilter.mode(
                  value.languageSelect.isNotEmpty
                      ? appColor(context).appTheme.darkText
                      : appColor(context).appTheme.lightText,
                  BlendMode.srcIn),
            ).paddingOnly(
                left: rtl(context) ? 0 : Insets.i35,
                right: rtl(context) ? Insets.i35 : 0,
                top: Insets.i16)
          ]),
          ContainerWithTextLayout(title: appFonts.identityType)
              .paddingOnly(bottom: Insets.i8, top: Insets.i20),
          DropDownLayout(
                  hintText: appFonts.selectType,
                  icon: eSvgAssets.identity,
                  doc: value.documentModel,
                  isIcon: true,
                  document: documentList,
                  onChanged: (val) => value.onIdentityChange(val))
              .paddingSymmetric(horizontal: Insets.i20),
          Text(language(context, appFonts.identityNo),
                  style: appCss.dmDenseSemiBold14
                      .textColor(appColor(context).appTheme.darkText))
              .padding(
                  bottom: Insets.i8, top: Insets.i20, horizontal: Insets.i20),
          TextFieldCommon(
                  focusNode: value.identityNumberFocus,
                  controller: value.identityNumber,
                  validator: (v) => validation.dynamicTextValidation(
                      context, v, appFonts.enterIdentityNo),
                  hintText: appFonts.enterIdentityNo,
                  prefixIcon: eSvgAssets.identity)
              .paddingSymmetric(horizontal: Insets.i20),
          Text(language(context, appFonts.uploadPhoto),
                  style: appCss.dmDenseSemiBold14
                      .textColor(appColor(context).appTheme.darkText))
              .padding(
                  bottom: Insets.i8, top: Insets.i20, horizontal: Insets.i20),
          DottedBorder(
                  color: appColor(context).appTheme.stroke,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(AppRadius.r10),
                  child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(AppRadius.r8)),
                      child: value.docFile != null
                          ? ClipSmoothRect(
                              radius: SmoothBorderRadius(
                                cornerRadius: 8,
                                cornerSmoothing: 1,
                              ),
                              child: Image.file(
                                File(value.docFile!.path),
                                height: Sizes.s70,
                                width: Sizes.s70,
                                fit: BoxFit.cover,
                              ))
                          : Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              color: appColor(context).appTheme.whiteBg,
                              child: Column(children: [
                                SvgPicture.asset(eSvgAssets.upload),
                                const VSpace(Sizes.s6),
                                Text(
                                    language(context, appFonts.uploadLogoImage),
                                    style: appCss.dmDenseMedium12.textColor(
                                        appColor(context).appTheme.lightText))
                              ]).paddingSymmetric(vertical: Insets.i15))))
              .inkWell(onTap: () => value.onImagePick(context, isLogo: false))
              .paddingSymmetric(horizontal: Insets.i20),
          ContainerWithTextLayout(title: appFonts.experience)
              .paddingOnly(top: Insets.i24, bottom: Insets.i8),
          Row(children: [
            Expanded(
                flex: 3,
                child: TextFieldCommon(
                        keyboardType: TextInputType.number,
                        focusNode: value.experienceFocus,
                        controller: value.experience,
                        validator: (v) =>
                            validation.commonValidation(context, v),
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
          ContainerWithTextLayout(title: appFonts.password)
              .paddingOnly(bottom: Insets.i8, top: Insets.i20),
          TextFieldCommon(
                  focusNode: value.passwordFocus,
                  controller: value.password,
                  hintText: appFonts.enterPassword,
                  validator: (v) => validation.dynamicTextValidation(
                      context, v, appFonts.pleaseEnterPassword),
                  prefixIcon: eSvgAssets.lock)
              .paddingSymmetric(horizontal: Insets.i20),
          ContainerWithTextLayout(title: appFonts.confirmPassword)
              .paddingOnly(bottom: Insets.i8, top: Insets.i20),
          TextFieldCommon(
                  focusNode: value.reEnterPasswordFocus,
                  controller: value.reEnterPassword,
                  hintText: appFonts.reEnterPassword,
                  validator: (v) => validation.confirmPassValidation(
                      context, v, value.password.text),
                  prefixIcon: eSvgAssets.lock)
              .paddingSymmetric(horizontal: Insets.i20)
        ]),
      );
    });
  }
}
