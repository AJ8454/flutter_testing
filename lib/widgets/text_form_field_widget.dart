import 'package:flutter/material.dart';

class TextFromFieldWidget extends StatelessWidget {
  final String label;
  final String hint;
  final String Function(String?)? validator;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool enabled;
  final Stream<String?>? stream;

  const TextFromFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.onChanged,
    this.stream,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            enabled: enabled,
            errorText: enabled
                ? snapshot.hasError
                    ? snapshot.error.toString()
                    : null
                : null,
          ),
        );
      },
    );
  }
}
