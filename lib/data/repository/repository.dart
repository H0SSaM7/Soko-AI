import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:sokoai/data/dataSource/remote_data_source.dart';
import 'package:sokoai/data/network/error_handler.dart';
import 'package:sokoai/data/network/network_info.dart';

import '../network/failture.dart';

abstract class Repository {
  Future<Either<Failture, String>> getContent(List<Content> contents);
}

class RepositoryImple extends Repository {
  final RemoteDataSource _dataSource;
  final NetworkInfo _networkInfo;
  RepositoryImple(this._dataSource, this._networkInfo);
  @override
  Future<Either<Failture, String>> getContent(List<Content> contents) async {
    try {
      final hasInternet = await _networkInfo.isConected;
      if (!hasInternet) {
        return left(DataSource.noInternetConnection.toFailture());
      }
      final content = await _dataSource.getContent(contents);
      return Right(content);
    } catch (e) {
      log(e.toString());
      return Left(DataSource.unknown.toFailture());
    }
  }
}
