import 'package:fixit_provider/widgets/multi_dropdown_common.dart';
import 'package:flutter/cupertino.dart';

import '../../../../config.dart';

class TextFieldLayout extends StatelessWidget {


  const TextFieldLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileDetailProvider>(builder: (context1, value, child) {
        return Column(children: [
          ContainerWithTextLayout(title: appFonts.userName),
          const VSpace(Sizes.s8),
          TextFieldCommon(
              controller: value.txtName,
              hintText: isServiceman? appFonts.enterName:appFonts.ownerName,
              focusNode: value.nameFocus,
              onFieldSubmitted: (values) => validation.fieldFocusChange(
                  context, value.nameFocus, value.emailFocus),
              prefixIcon: eSvgAssets.user,
              validator: (value) => validation.nameValidation(
                  context, value)).paddingSymmetric(horizontal: Insets.i20),
          const VSpace(Sizes.s15),
          ContainerWithTextLayout(title: language(context, appFonts.email)),
          const VSpace(Sizes.s8),
          TextFieldCommon(
              controller: value.txtEmail,
              hintText: language(context, appFonts.enterEmail),
              focusNode: value.emailFocus,
              onFieldSubmitted: (values) => validation.fieldFocusChange(
                  context, value.emailFocus, value.phoneFocus),
              prefixIcon: eSvgAssets.email,
              validator: (value) => validation.emailValidation(
                  context, value)).paddingSymmetric(horizontal: Insets.i20),
          const VSpace(Sizes.s15),
          ContainerWithTextLayout(title: language(context, appFonts.phoneNo)),
          const VSpace(Sizes.s10),
          RegisterWidgetClass().phoneTextBox(
dialCode: value.dialCode,
              context, value.txtPhone, value.phoneFocus,
              onChanged: (CountryCodeCustom? code) => value.changeDialCode(code!),
              onFieldSubmitted: (values) => validation.fieldFocusChange(
                  context, value.phoneFocus, value.phoneFocus)),
          if(isServiceman)
          Column(
            children: [
              const VSpace(Sizes.s15),
              ContainerWithTextLayout(title: language(context, appFonts.knowLanguage)),
              const VSpace(Sizes.s10),
              Stack(
                  children: [
                    MultiSelectDropDownCustom(

                        backgroundColor: appColor(context).appTheme.whiteBg,
                        onOptionSelected: (options) => value.onLanguageSelect(options),
                        selectedOptions: value.languageSelect,
                        options: knownLanguageList
                            .asMap()
                            .entries
                            .map((e) => ValueItem(
                            label: language(context, e.value.key), value: e.value.id))
                            .toList(),
                        selectionType: SelectionType.multi,
                        hint: language(context, appFonts.selectLocation),
                        optionsBackgroundColor: appColor(context).appTheme.whiteBg,
                        selectedOptionBackgroundColor: appColor(context).appTheme.whiteBg,
                        hintStyle: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.lightText),
                        chipConfig: CommonWidgetLayout().chipWidget(context),
                        padding: EdgeInsets.only(
                            left: rtl(context) ? Insets.i10 : Insets.i40,
                            right: rtl(context) ? Insets.i40 : Insets.i10),
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
                    SvgPicture.asset(eSvgAssets.country, colorFilter: ColorFilter.mode(value.languageSelect.isNotEmpty ? appColor(context).appTheme.darkText : appColor(context).appTheme.lightText, BlendMode.srcIn),).paddingOnly(
                        left: rtl(context) ? 0 : Insets.i35,
                        right: rtl(context) ? Insets.i35 : 0,
                        top: Insets.i16)
                  ]
              ),
              const VSpace(Sizes.s15),
              ContainerWithTextLayout(title: language(context, appFonts.location)),
              const VSpace(Sizes.s10),
              TextFieldCommon(
                  onTap: () => route
                      .pushNamed(
                      context, routeName.location,arg:{"isServiceman":userModel!.role!.name == "provider" ?false:true,"data": value.address,})
                      .then((e){

                  }),
                  focusNode: value.location,
                  validator: (name) => validation.dynamicTextValidation(context, name,appFonts.pleaseAddAddress),
                  controller: value.locationCtrl,
                  hintText: appFonts.location,
                  prefixIcon: eSvgAssets.locationOut)
                  .paddingSymmetric(horizontal: Insets.i20),
            ],
          ),

        ]);
      }
    );
  }
}
