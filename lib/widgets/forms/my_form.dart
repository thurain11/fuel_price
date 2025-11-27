import 'package:flutter/services.dart';
import '../../global.dart';

class MyForm extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? hintText;
  final String? labelText;
  final bool scureText;
  final FocusNode? focusNode;
  final String? errorText;
  final Function()? onTap;
  final Function(String)? onChange;
  final String? Function(String?)? validate;
  final Widget? suffixIcon;
  final Widget? prefixWidget;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatter;
  final int? maxLength;
  final int? maxLine;
  final bool hasBorder;
  final bool? isFilled;
  final Color? fillColor;
  final Widget? suffixWidget;
  final bool autoFocus;
  final String? prefixText;
  final bool enable;
  final TextStyle? style;
  final Widget? formIcon;
  final bool isRequired;
  final double contentPadding;
  final BuildContext? context;

  const MyForm({
    Key? key,
    this.context,
    this.label,
    this.controller,
    this.inputType,
    this.hintText,
    this.labelText,
    this.scureText = false,
    this.errorText,
    this.onChange,
    this.onTap,
    this.focusNode,
    this.validate,
    this.suffixIcon,
    this.prefixWidget,
    this.prefixIcon,
    this.inputFormatter,
    this.maxLength,
    this.maxLine,
    this.hasBorder = true,
    this.isFilled = true,
    this.fillColor,
    this.suffixWidget,
    this.autoFocus = false,
    this.enable = true,
    this.prefixText,
    this.style,
    this.formIcon,
    this.isRequired = false,
    this.contentPadding = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (formIcon != null)
            Expanded(flex: 1, child: formIcon ?? Container()),
            if (formIcon != null)
            SizedBox(
              width: 2,
            ),
            Expanded(
              flex: 8,
              child: TextFormField(
                autofocus: autoFocus,
                focusNode: focusNode,
                onTap: onTap,
                keyboardType: inputType,
                controller: controller,
                obscureText: scureText,
                onChanged: onChange,
                validator: validate,
                inputFormatters: inputFormatter,
                maxLength: maxLength,

                maxLines: scureText ? 1 : maxLine,
                style: style == null ? Theme.of(context).textTheme.titleMedium : style,
                decoration: InputDecoration(
                  // fillColor: focusNode!.hasFocus ? Colors.teal.withOpacity(0.1) : Colors.grey.shade100,
                    fillColor: fillColor == null ? Theme.of(context).cardColor : fillColor,
                    filled: isFilled,
                    hintText: hintText,
                    label: Row(
                      children: [
                        Text(labelText ?? ""),
                        Padding(
                          padding: EdgeInsets.all(3.0),
                        ),
                        if (isRequired) Text('*', style: TextStyle(color: Colors.red))
                      ],
                    ),
                    suffixIcon: suffixIcon,
                    suffix: suffixWidget,
                    prefixText: prefixText,
                    prefixStyle: Theme.of(context).textTheme.titleMedium,
                    prefixIcon: prefixIcon,
                    prefix: prefixWidget,
                    errorText: errorText,
                    contentPadding: EdgeInsets.symmetric(vertical: contentPadding),
                    // border: InputBorder.none,

                    enabled: enable,
                    hintStyle: Theme.of(context).textTheme.labelSmall,
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.7, color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.7, color: Colors.grey))
                  // border: _focusNode.hasFocus ? OutlineInputBorder(
                  //   borderSide: BorderSide(
                  //       color: Colors.indigo,
                  //       width: 0.0
                  //   ),
                  // ):null,

                  // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xfff38cf69).withOpacity(0.6), width: 1)),
                  // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1,style: BorderStyle.solid)),

                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
