import 'dart:developer';

import '../../../../config.dart';

class DropDownLayout extends StatelessWidget {
  final String? icon, hintText, val;
  final List? categoryList;
  final String? doc;
  final CategoryModel? cat;
  final ValueChanged? onChanged;
  final bool? isIcon, isField, isBig, isListIcon, isOnlyText;
  final List<DocumentModel>? document;
  final List<CategoryModel>? category;

  const DropDownLayout(
      {super.key,
      this.icon,
      this.hintText,
      this.val,
      this.onChanged,
      this.isField = false,
      this.isIcon = false,
      this.isBig = false,
      this.categoryList,
      this.isListIcon = false,
      this.isOnlyText = false,
      this.document,
      this.doc,
      this.category,
      this.cat});

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
                                    document != null && document!.isNotEmpty
                                        ? doc == null
                                            ? appColor(context)
                                                .appTheme
                                                .lightText
                                            : appColor(context)
                                                .appTheme
                                                .darkText
                                        : category != null &&
                                                category!.isNotEmpty
                                            ? cat == null
                                                ? appColor(context)
                                                    .appTheme
                                                    .lightText
                                                : appColor(context)
                                                    .appTheme
                                                    .darkText
                                            : val == null
                                                ? appColor(context)
                                                    .appTheme
                                                    .lightText
                                                : appColor(context)
                                                    .appTheme
                                                    .darkText,
                                    BlendMode.srcIn))
                            : null,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        disabledBorder:CommonWidgetLayout().noneDecoration(),
                        focusedBorder: CommonWidgetLayout().noneDecoration(),
                        enabledBorder:CommonWidgetLayout().noneDecoration(),
                        border: CommonWidgetLayout().noneDecoration()),
                    padding: EdgeInsets.zero,
                    value: document != null && document!.isNotEmpty ? doc : val,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppRadius.r8)),
                    style: appCss.dmDenseMedium14
                        .textColor(document != null && document!.isNotEmpty
                            ? doc == null
                                ? appColor(context).appTheme.lightText
                                : appColor(context).appTheme.darkText
                            : category != null && category!.isNotEmpty
                                ? cat == null
                                    ? appColor(context).appTheme.lightText
                                    : appColor(context).appTheme.darkText
                                : val == null
                                    ? appColor(context).appTheme.lightText
                                    : appColor(context).appTheme.darkText),
                    icon: SvgPicture.asset(eSvgAssets.dropDown,
                        colorFilter: ColorFilter.mode(
                            document != null && document!.isNotEmpty
                                ? doc == null
                                    ? appColor(context).appTheme.lightText
                                    : appColor(context).appTheme.darkText
                                : category != null && category!.isNotEmpty
                                    ? cat == null
                                        ? appColor(context).appTheme.lightText
                                        : appColor(context).appTheme.darkText
                                    : val == null
                                        ? appColor(context).appTheme.lightText
                                        : appColor(context).appTheme.darkText,
                            BlendMode.srcIn)),
                    isDense: true,
                    isExpanded: true,
                    items: document != null && document!.isNotEmpty
                        ? document!.asMap().entries.map((e) {
                            return DropdownMenuItem(
                                value: e.value.id.toString(),
                                child: Row(
                                  children: [
                                    Text(language(context, e.value.title),
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
                          }).toList()
                        : category != null
                            ? category!.asMap().entries.map((e) {
                                return DropdownMenuItem(
                                    value: e.value,
                                    child: Row(
                                      children: [
                                        Text(language(context, e.value.title),
                                            style: appCss.dmDenseMedium14
                                                .textColor(doc == null
                                                    ? appColor(context)
                                                        .appTheme
                                                        .lightText
                                                    : appColor(context)
                                                        .appTheme
                                                        .darkText)),
                                      ],
                                    ));
                              }).toList()
                            : categoryList!.asMap().entries.map((e) {
                                return DropdownMenuItem(
                                    value: e.value,
                                    child: Row(
                                      children: [
                                        if (isListIcon == true)
                                          SizedBox(
                                                  height: Sizes.s13,
                                                  width: Sizes.s13,
                                                  child: SvgPicture.asset(
                                                    e.value["image"],
                                                    fit: BoxFit.scaleDown,
                                                  ))
                                              .paddingAll(Insets.i4)
                                              .decorated(
                                                  color: appColor(context)
                                                      .appTheme
                                                      .fieldCardBg,
                                                  shape: BoxShape.circle),
                                        if (isListIcon == true)
                                          const HSpace(Sizes.s12),
                                        Text(language(context, e.value),
                                            style: appCss.dmDenseMedium14
                                                .textColor(val == null
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
