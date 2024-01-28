import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_testing/manager/form_manager.dart';
import 'package:flutter_testing/widgets/text_form_field_widget.dart';

class ArticleForm extends ConsumerStatefulWidget {
  const ArticleForm({super.key});

  @override
  ConsumerState<ArticleForm> createState() => _ArticleFormState();
}

class _ArticleFormState extends ConsumerState<ArticleForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passowrdController = TextEditingController();
  final TextEditingController _passowrdConfirmController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formManager = ref.watch(formManagerProvider);

    return Column(
      children: [
        TextFromFieldWidget(
          controller: _emailController,
          label: "Email",
          hint: "Enter Email",
          stream: formManager.email,
          onChanged: (value) => formManager.inEmail.add(value),
        ),
        const SizedBox(height: 20),
        TextFromFieldWidget(
          controller: _passowrdController,
          label: "Password",
          hint: "Enter Password",
          stream: formManager.passowrd,
          onChanged: (value) {
            formManager.inpassowrd.add(value);
            // if (_passowrdConfirmController.text.isNotEmpty) {
            //   formManager.inconfirmPassowrd.add(null);
            //   // _passowrdConfirmController.clear();
            // }
          },
        ),
        const SizedBox(height: 20),
        StreamBuilder<bool>(
            stream: formManager.enableConfirmPassword,
            builder: (context, snapshot) {
              return TextFromFieldWidget(
                controller: _passowrdConfirmController,
                label: "Confirm Password",
                hint: "Enter Confirm  Password",
                enabled: snapshot.hasData == true,
                stream: formManager.confirmPassowrd,
                onChanged: (value) => formManager.inconfirmPassowrd.add(value),
              );
            }),
        const SizedBox(height: 20),
        StreamBuilder<bool>(
          stream: formManager.submitValid,
          builder: (context, snapshot) {
            return ElevatedButton(
              onPressed: snapshot.hasData ? () {} : null,
              child: Text("Submit ${snapshot.hasData}"),
            );
          },
        ),
      ],
    );
  }
}
