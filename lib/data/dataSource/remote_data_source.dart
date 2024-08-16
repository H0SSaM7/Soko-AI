import 'package:google_generative_ai/google_generative_ai.dart';

abstract class RemoteDataSource {
  Future<String> getContent(List<Content> contents);
}

class RemoteDataSourceImple extends RemoteDataSource {
  final GenerativeModel _model;
  RemoteDataSourceImple(this._model);
  @override
  Future<String> getContent(List<Content> contents) async {
    final GenerateContentResponse response =
        await _model.generateContent(contents);
    return response.text ?? '';
  }
}
