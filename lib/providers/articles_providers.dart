import 'package:flutter_testing/domain/article_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'articles_providers.g.dart';

@riverpod
class ArticleNotifier extends _$ArticleNotifier {
  @override
  List<Article> build() => [];

  Future<void> getArticles() async {
    //
  }
}
