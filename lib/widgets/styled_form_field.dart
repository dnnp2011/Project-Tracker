import 'package:flutter/material.dart';
import 'package:project_tracker/themes/theme.dart';

Widget styledFormField(
    {BuildContext context,
    TextEditingController controller,
    FormFieldValidator validator,
    FocusNode nextFocusNode,
    FocusNode focusNode,
    TextInputType textInputType,
    bool showError,
    String errorMsg,
    double fixedHeight}) {
  return Container(
    height: fixedHeight,
    child: TextFormField(
      decoration: InputDecoration(
        errorText: showError ? errorMsg ?? "Required value" : null,
        errorStyle: Theme.of(context).textTheme.caption.copyWith(color: ThemeColors.errorDp16),
        border: UnderlineInputBorder(borderSide: BorderSide(color: ThemeColors.secondaryDp16, width: 2)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ThemeColors.secondaryDp16, width: 2)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ThemeColors.secondaryDp16, width: 3)),
        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: ThemeColors.errorDp16, width: 2)),
        focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: ThemeColors.errorDp16, width: 3)),
      ),
      controller: controller,
      focusNode: focusNode,
      autovalidate: true,
      keyboardAppearance: Brightness.dark,
      keyboardType: textInputType,
      textInputAction: nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
//      validator: validator,
      onFieldSubmitted: (value) => nextFocusNode != null ? FocusScope.of(context).requestFocus(nextFocusNode) : print('nextFocusNode is null - Value: $value'),
    ),
  );
}
