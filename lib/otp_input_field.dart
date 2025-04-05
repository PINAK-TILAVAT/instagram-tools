import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputField extends StatefulWidget {
  final TextEditingController controller;
  final bool hasError;
  final Function(bool) onCompleted;

  const OtpInputField({
    Key? key,
    required this.controller,
    this.hasError = false,
    required this.onCompleted,
  }) : super(key: key);

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  List<TextEditingController> digitControllers = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers and focus nodes for each digit
    for (int i = 0; i < 6; i++) {
      digitControllers.add(TextEditingController());
      focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    for (int i = 0; i < 6; i++) {
      digitControllers[i].dispose();
      focusNodes[i].dispose();
    }
    super.dispose();
  }

  // Update the main controller when digits change
  void _updateMainController() {
    String otp = '';
    for (var controller in digitControllers) {
      otp += controller.text;
    }
    widget.controller.text = otp;
    widget.onCompleted(otp.length == 6);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        6,
        (index) => SizedBox(
          width: 45,
          height: 50,
          child: TextField(
            controller: digitControllers[index],
            focusNode: focusNodes[index],
            onChanged: (value) {
              if (value.isNotEmpty) {
                // Move to next field if current is filled
                if (index < 5) {
                  focusNodes[index + 1].requestFocus();
                } else {
                  // Last field, hide keyboard
                  FocusScope.of(context).unfocus();
                }
              } else if (value.isEmpty && index > 0) {
                // Move to previous field if backspace is pressed
                focusNodes[index - 1].requestFocus();
              }
              _updateMainController();
            },
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                ),
              ),
              errorBorder:
                  widget.hasError
                      ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      )
                      : null,
            ),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
    );
  }
}
