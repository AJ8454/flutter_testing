import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_testing/domain/article_model.dart';

class ArticleRepo {
  // need to make api call from facade

  final List<Article> _articles = List.generate(
    30,
    (_) => Article(
      title: lorem(paragraphs: 1, words: 3),
      body: lorem(paragraphs: 10, words: 500),
    ),
  );

  Future<List<Article>> getArticles() async {
    await Future.delayed(const Duration(seconds: 2));
    return _articles;
  }
}
