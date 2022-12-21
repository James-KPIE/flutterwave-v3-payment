import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterwave_payment/src/common/strings.dart';
import 'package:flutterwave_payment/src/common/validator_utills.dart';
import 'package:flutterwave_payment/src/ui/fields/base_field.dart';

class CVVField extends BaseTextField {
  CVVField({
    required FormFieldSetter<String> onSaved,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    ValueChanged<String>? onFieldSubmitted,
  }) : super(
          labelText: 'CVV',
          hintText: '123',
          onSaved: onSaved,
          validator: (String? value) => validateCVV(value),
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: textInputAction,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            new LengthLimitingTextInputFormatter(4),
          ],
        );

  static String? validateCVV(String? value) =>
      ValidatorUtils.isCVVValid(value) ? null : Strings.invalidCVV;
}
