import 'package:flutter/material.dart';
import 'package:flutter_testing/widgets/article_form_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Articles")),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArticleForm(),
            ],
          ),
        ),
      ),
    );
  }
}
