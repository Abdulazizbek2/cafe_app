import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:cafe_app/core/extension/extension.dart";
import "package:cafe_app/core/widgets/inputs/masked_text_input_formatter.dart";

class CustomPhoneTextField extends StatefulWidget {
  const CustomPhoneTextField({
    this.controller,
    super.key,
    this.titleText,
    this.showError,
    this.autoFocus = false,
    this.onChanged,
    this.prefixText,
    this.errorText,
    this.inputAction,
    this.currentFocus,
    this.nextFocus,
    this.obscureText,
    this.hintText,
    this.context,
    this.onTap,
    this.readOnly = false,
    this.suffixText,
    this.suffixIcon,
    this.suffixStyle,
    this.prefixIcon,
    this.fillColor,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.onComplete,
    this.required = false,
    this.labelText,
    this.validator,
    this.filled,
    this.haveBorder = true,
  });

  final String? titleText;
  final String? labelText;
  final bool? showError;
  final TextEditingController? controller;
  final bool autoFocus;
  final void Function(String value)? onChanged;
  final String? prefixText;
  final String? errorText;
  final TextInputAction? inputAction;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final String? hintText;
  final bool? obscureText;
  final BuildContext? context;
  final void Function()? onTap;
  final void Function()? onComplete;
  final bool readOnly;
  final String? suffixText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? suffixStyle;
  final Color? fillColor;
  final EdgeInsets? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final bool required;
  final String? Function(String?)? validator;
  final bool? filled;
  final bool haveBorder;

  @override
  State<CustomPhoneTextField> createState() => _CustomPhoneTextFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty("titleText", titleText))
      ..add(
        ObjectFlagProperty<String? Function(String? p1)?>.has(
          "validator",
          validator,
        ),
      )
      ..add(StringProperty("labelText", labelText))
      ..add(DiagnosticsProperty<bool?>("showError", showError))
      ..add(
        DiagnosticsProperty<TextEditingController?>("controller", controller),
      )
      ..add(DiagnosticsProperty<bool>("autoFocus", autoFocus))
      ..add(
        ObjectFlagProperty<void Function(String value)?>.has(
          "onChanged",
          onChanged,
        ),
      )
      ..add(StringProperty("prefixText", prefixText))
      ..add(StringProperty("errorText", errorText))
      ..add(EnumProperty<TextInputAction?>("inputAction", inputAction))
      ..add(DiagnosticsProperty<FocusNode?>("currentFocus", currentFocus))
      ..add(DiagnosticsProperty<FocusNode?>("nextFocus", nextFocus))
      ..add(StringProperty("hintText", hintText))
      ..add(DiagnosticsProperty<bool?>("obscureText", obscureText))
      ..add(DiagnosticsProperty<BuildContext?>("context", context))
      ..add(ObjectFlagProperty<void Function()?>.has("onTap", onTap))
      ..add(ObjectFlagProperty<void Function()?>.has("onComplete", onComplete))
      ..add(DiagnosticsProperty<bool>("readOnly", readOnly))
      ..add(StringProperty("suffixText", suffixText))
      ..add(DiagnosticsProperty<TextStyle?>("suffixStyle", suffixStyle))
      ..add(ColorProperty("fillColor", fillColor))
      ..add(DiagnosticsProperty<EdgeInsets?>("contentPadding", contentPadding))
      ..add(DiagnosticsProperty<InputBorder?>("focusedBorder", focusedBorder))
      ..add(DiagnosticsProperty<InputBorder?>("enabledBorder", enabledBorder))
      ..add(DiagnosticsProperty<InputBorder?>("errorBorder", errorBorder))
      ..add(
        DiagnosticsProperty<InputBorder?>(
          "focusedErrorBorder",
          focusedErrorBorder,
        ),
      )
      ..add(DiagnosticsProperty<bool>("required", required))
      ..add(DiagnosticsProperty<bool?>("filled", filled))
      ..add(DiagnosticsProperty<bool>("haveBorder", haveBorder));
  }
}

class _CustomPhoneTextFieldState extends State<CustomPhoneTextField> {
  String? _prefixText;
  late FocusNode focusNode = widget.currentFocus ?? FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          setState(() {
            _prefixText = "+998 ";
          });
        } else {
          if (widget.controller!.text.isEmpty) {
            setState(() {
              _prefixText = null;
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (widget.titleText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                "${widget.titleText}",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          TextFormField(
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: <TextInputFormatter>[
              MaskedTextInputFormatter(
                mask: "## ### ## ##",
                separator: " ",
                filter: RegExp("[0-9]"),
              ),
            ],
            style: const TextStyle(
              fontSize: 14,
              height: 16 / 14,
              fontWeight: FontWeight.w400,
            ),
            obscureText: widget.obscureText ?? false,
            readOnly: widget.readOnly,
            controller: widget.controller,
            focusNode: focusNode,
            onTap: widget.onTap,
            scrollPadding: EdgeInsets.zero,
            autofocus: widget.autoFocus,
            onChanged: widget.onChanged,
            onFieldSubmitted: (String term) => _fieldFocusChange(
              context,
              focusNode,
              widget.nextFocus,
            ),
            obscuringCharacter: "*",
            textInputAction: widget.inputAction,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              fillColor: widget.fillColor,
              filled: widget.filled,
              suffixIcon: widget.suffixIcon,
              labelText: widget.labelText,
              prefixText: _prefixText,
              prefixIconConstraints: BoxConstraints(
                maxWidth: _prefixText != null ? 56 : 12,
                minWidth: _prefixText != null ? 48 : 12,
              ),
              hintText: _prefixText == null ? widget.hintText : "",
              errorText: widget.showError ?? false ? widget.errorText : null,
            ),
            cursorColor: context.theme.colorScheme.primary,
            keyboardType: TextInputType.phone,
            onEditingComplete: widget.onComplete,
          ),
        ],
      );

  void _fieldFocusChange(
    BuildContext context,
    FocusNode? currentFocus,
    FocusNode? nextFocus,
  ) {
    if (currentFocus != null && nextFocus != null) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FocusNode>("focusNode", focusNode));
  }
}
