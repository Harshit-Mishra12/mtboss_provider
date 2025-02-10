import 'dart:developer';
import 'dart:io';

import 'package:fixit_provider/providers/common_providers/common_api_provider.dart';
import 'package:fixit_provider/services/common_list_services.dart';
import 'package:fixit_provider/widgets/multi_dropdown_common.dart';

import 'package:flutter/cupertino.dart';
import '../../../../config.dart';

class SignUpThree extends StatelessWidget {
  const SignUpThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<SignUpCompanyProvider,CommonApiProvider>(builder: (context1, value,api, child) {

      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: value.signupFormKey3,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ContainerWithTextLayout(title: isFreelancer ? appFonts.userName : appFonts.ownerName)
                .paddingOnly(bottom: Insets.i8),
            TextFieldCommon(
                focusNode: value.ownerNameFocus,
              controller: value.ownerName,
                    validator: (v) => validation.nameValidation(context, v),
                    hintText: appFonts.enterName,
                    prefixIcon:
                        eSvgAssets.user)
                .paddingSymmetric(horizontal: Insets.i20),
            ContainerWithTextLayout(title: appFonts.phoneNo)
                .paddingOnly(bottom: Insets.i8, top: Insets.i20),
            RegisterWidgetClass().phoneTextBox(
                dialCode: value.providerDialCode,
                context, value.providerNumber, value.providerNumberFocus,
                onChanged: (CountryCodeCustom? code) => value.changeProviderDialCode(code!),
                onFieldSubmitted: (values) => validation.fieldFocusChange(
                    context, value.providerNumberFocus, value.emailFocus)),
            ContainerWithTextLayout(title: appFonts.email)
                .paddingOnly(bottom: Insets.i8, top: Insets.i20),
            TextFieldCommon(
                focusNode: value.providerEmailFocus,
                validator: (v) => validation.emailValidation(context, v),
                    controller: value.providerEmail,
                    hintText: appFonts.enterEmail,
                    prefixIcon:
                        eSvgAssets.email)
                .paddingSymmetric(horizontal: Insets.i20),
            ContainerWithTextLayout(title: appFonts.knownLanguage)
                .paddingOnly(bottom: Insets.i8, top: Insets.i20),
            Stack(
              children: [
                MultiSelectDropDownCustom(
                  backgroundColor: appColor(context).appTheme.whiteBg,optionsBackgroundColor: appColor(context).appTheme.whiteBg,
                        onOptionSelected: (options)=> value.onLanguageSelect(options),
                        searchEnabled: true,
                    options:knownLanguageList.asMap().entries.map((e) => ValueItem(
                        label: language(context, e.value.key),
                        value: e.value.id)).toList() ,
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
selectedOptionBackgroundColor: appColor(context).appTheme.whiteBg,
                        suffixIcon: SvgPicture.asset(eSvgAssets.dropDown,
                            colorFilter: ColorFilter.mode(value.languageSelect.isNotEmpty
                                ? appColor(context).appTheme.darkText
                                : appColor(context).appTheme.lightText, BlendMode.srcIn) ),optionTextStyle: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.darkText),
                        selectedOptionIcon: Icon(Icons.check_box_rounded,color: appColor(context).appTheme.primary))
                    .paddingSymmetric(horizontal: Insets.i20),
                SvgPicture.asset(eSvgAssets.country, colorFilter: ColorFilter.mode(value.languageSelect.isNotEmpty ? appColor(context).appTheme.darkText : appColor(context).appTheme.lightText, BlendMode.srcIn),).paddingOnly(
                    left: rtl(context) ? 0 : Insets.i35,
                    right: rtl(context) ? Insets.i35 : 0,
                    top: Insets.i16)
              ]
            ),

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
            ContainerWithTextLayout(title: appFonts.identityNo)
                .paddingOnly(bottom: Insets.i8, top: Insets.i20),
            TextFieldCommon(
                focusNode: value.identityNumberFocus,
                validator: (v) => validation.dynamicTextValidation(context, v,appFonts.enterIdentityNo),
                controller: value.identityNumber,
                    hintText: appFonts.enterIdentityNo,
                    prefixIcon: eSvgAssets.identity)
                .paddingSymmetric(horizontal: Insets.i20),
            ContainerWithTextLayout(title: appFonts.uploadPhoto)
                .paddingOnly(bottom: Insets.i8, top: Insets.i20),
            DottedBorder(
                    color: appColor(context).appTheme.stroke,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(AppRadius.r10),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(AppRadius.r8)),
                        child:value.docFile != null ? ClipSmoothRect(
                            radius: SmoothBorderRadius(
                              cornerRadius: 8,
                              cornerSmoothing: 1,
                            ),
                            child: Image.file(File(value.docFile!.path),height: Sizes.s70,width: Sizes.s70,fit: BoxFit.cover,)) : Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            color: appColor(context).appTheme.whiteBg,
                            child: Column(
                              children: [
                                SvgPicture.asset(eSvgAssets.upload),
                                const VSpace(Sizes.s6),
                                Text(language(context, appFonts.uploadLogoImage),
                                    style: appCss.dmDenseMedium12.textColor(
                                        appColor(context).appTheme.lightText))
                              ]
                            ).paddingSymmetric(vertical: Insets.i15)))).inkWell(onTap: ()=> value.onImagePick(context,isLogo: false))
                .paddingSymmetric(horizontal: Insets.i20),
            ContainerWithTextLayout(title: appFonts.password)
                .paddingOnly(bottom: Insets.i8, top: Insets.i20),
            TextFieldCommon(
              obscureText: value.isNewPassword,
                focusNode: value.passwordFocus,
              controller: value.password,
                suffixIcon: SvgPicture.asset(
                    value.isNewPassword
                        ? eSvgAssets.hide
                        : eSvgAssets.eye,
                    fit: BoxFit.scaleDown)
                    .inkWell(onTap: () => value.newPasswordSeenTap()),
                validator: (v) => validation.dynamicTextValidation(context, v,appFonts.pleaseEnterPassword),
                    hintText: appFonts.enterPassword,
                    prefixIcon:
                        eSvgAssets.lock)
                .paddingSymmetric(horizontal: Insets.i20),
            ContainerWithTextLayout(title: appFonts.confirmPassword)
                .paddingOnly(bottom: Insets.i8, top: Insets.i20),
            TextFieldCommon(
                obscureText: value.isConfirmPassword,

                focusNode: value.reEnterPasswordFocus,
                suffixIcon: SvgPicture.asset(
                    value.isConfirmPassword
                        ? eSvgAssets.hide
                        : eSvgAssets.eye,
                    fit: BoxFit.scaleDown)
                    .inkWell(onTap: () => value.confirmPasswordSeenTap()),
                  controller: value.reEnterPassword,
                    hintText: appFonts.reEnterPassword,
                validator: (v) => validation.confirmPassValidation(context, v,value.password.text),
                    prefixIcon: eSvgAssets.lock)
                .paddingSymmetric(horizontal: Insets.i20)
          ]),
        ),
      );
    });
  }
}
