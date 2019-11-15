import 'package:flutter/material.dart';

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
        errorText: showError ? errorMsg ?? 'Value Can\'t Be Empty' : ' ',
        errorStyle: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.red),
        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1)),
        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple, width: 1)),
        focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple[700], width: 2)),
      ),
      controller: controller,
      focusNode: focusNode,
      keyboardAppearance: Brightness.dark,
      keyboardType: textInputType,
      textInputAction: nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
      validator: validator,
      onFieldSubmitted: (value) =>
          nextFocusNode != null ? FocusScope.of(context).requestFocus(nextFocusNode) : print('nextFocusNode is null - Value: $value'),
    ),
  );
}
