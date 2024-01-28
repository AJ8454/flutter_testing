import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_testing/providers/articles_providers.dart';

class ArticleListWidget extends ConsumerWidget {
  const ArticleListWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final articleRef = ref.watch(articleNotifierProvider);
    return Container();
  }
}
