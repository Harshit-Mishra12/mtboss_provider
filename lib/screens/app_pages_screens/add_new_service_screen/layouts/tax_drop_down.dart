import 'dart:developer';

import '../../../../config.dart';

class TaxDropDownLayout extends StatelessWidget {
  final String? icon, hintText;
  final int? doc;
  final ValueChanged? onChanged;
  final bool? isIcon, isField, isBig, isListIcon, isOnlyText;
  final List<TaxModel>? tax;

  const TaxDropDownLayout(
      {super.key,
        this.icon,
        this.hintText,
        this.onChanged,
        this.isField = false,
        this.isIcon = false,
        this.isBig = false,
        this.isListIcon = false,
        this.isOnlyText = false,
        this.doc, this.tax});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: ButtonTheme(
            child: DropdownButtonFormField(
                hint: Text(language(context, hintText ?? ""),
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.lightText)),
                decoration: InputDecoration(
                    prefixIcon: isIcon == true
                        ? SvgPicture.asset(icon!,
                        fit: BoxFit.scaleDown,
                        colorFilter: ColorFilter.mode(
                            tax != null && tax!.isNotEmpty
                                ? doc == null
                                ? appColor(context)
                                .appTheme
                                .lightText
                                : appColor(context)
                                .appTheme
                                .darkText
                           :appColor(context)
                                .appTheme
                                .lightText ,
                            BlendMode.srcIn))
                        : null,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    disabledBorder:CommonWidgetLayout().noneDecoration(),
                    focusedBorder: CommonWidgetLayout().noneDecoration(),
                    enabledBorder:CommonWidgetLayout().noneDecoration(),
                    border:CommonWidgetLayout().noneDecoration()),
                padding: EdgeInsets.zero,
                value:doc,
                borderRadius:
                const BorderRadius.all(Radius.circular(AppRadius.r8)),
                style: appCss.dmDenseMedium14
                    .textColor(doc == null
                    ? appColor(context).appTheme.lightText
                    : appColor(context).appTheme.darkText),
                icon: SvgPicture.asset(eSvgAssets.dropDown,
                    colorFilter: ColorFilter.mode(
                        doc == null
                            ? appColor(context).appTheme.lightText
                            : appColor(context).appTheme.darkText,
                        BlendMode.srcIn)),
                isDense: true,
                isExpanded: true,
                items:  tax!.asMap().entries.map((e) {
                  return DropdownMenuItem(
                      value: e.value.id,
                      child: Row(
                        children: [
                          Text(language(context, e.value.name),
                              style: appCss.dmDenseMedium14.textColor(
                                  doc == null
                                      ? appColor(context)
                                      .appTheme
                                      .lightText
                                      : appColor(context)
                                      .appTheme
                                      .darkText)),
                        ],
                      ));
                }).toList(),
                onChanged: onChanged)))
        .padding(
        vertical: isBig == true
            ? Insets.i14
            : isOnlyText == true
            ? Insets.i5
            : 0,
        left: isIcon == false
            ? rtl(context)
            ? Insets.i15
            : Insets.i10
            : rtl(context)
            ? Insets.i15
            : Insets.i2,
        right: rtl(context) ? 10 : Insets.i10)
        .decorated(
        color: isField == true
            ? appColor(context).appTheme.fieldCardBg
            : appColor(context).appTheme.whiteBg,
        borderRadius: BorderRadius.circular(AppRadius.r8));
  }
}
