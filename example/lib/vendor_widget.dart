import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterwave_payment/flutterwave_payment.dart';

class AddVendorWidget extends StatefulWidget {
  const AddVendorWidget({Key key}) : super(key: key);

  @override
  _AddVendorWidgetState createState() => _AddVendorWidgetState();
}

class _AddVendorWidgetState extends State<AddVendorWidget> {
  var formKey = GlobalKey<FormState>();
  var refFocusNode = FocusNode();
  var ratioFocusNode = FocusNode();
  bool autoValidate = false;
  String id;
  String ratio;

  @override
  void dispose() {
    refFocusNode.dispose();
    ratioFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: formKey,
        autovalidateMode: autoValidate? AutovalidateMode.always: AutovalidateMode.disabled,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration:
                  const InputDecoration(hintText: 'Your Vendor\'s Rave Reference'),
              onSaved: (value) => id = value,
              textCapitalization: TextCapitalization.words,
              focusNode: refFocusNode,
              autofocus: true,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                refFocusNode.unfocus();
                FocusScope.of(context).requestFocus(ratioFocusNode);
              },
              validator: (value) =>
                  value.trim().isEmpty ? 'Field is required' : null,
            ),
          const SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration:const InputDecoration(hintText: 'Ratio for this vendor'),
              onSaved: (value) => ratio = value,
              keyboardType: TextInputType.number,
              focusNode: ratioFocusNode,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (value) {
                ratioFocusNode.unfocus();
                validateInputs();
              },
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) =>
                  value.trim().isEmpty ? 'Field is required' : null,
            )
          ],
        ),
      ),
      actions: <Widget>[
        OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child:const Text('CANCEL')),
        OutlinedButton(onPressed: validateInputs, child:const Text('ADD')),
      ],
    );
  }

  void validateInputs() {
    var formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      Navigator.of(context).pop(SubAccount(id, ratio));
    } else {
      setState(() => autoValidate = true);
    }
  }
}
