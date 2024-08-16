import 'failture.dart';

// class ErrorHandler implements Exception {
//   late Failture failture;
//   ErrorHandler.handle(dynamic error) {
//     if (error is DioException) {
//       failture = _getError(error);
//     } else {
//       failture = DataSource.unknown.toFailture();
//     }
//     if (!kReleaseMode) {
//       log("<-------> \n ${error.toString()} \n <------->");
//       log("<====> ${failture.code} : ${failture.message} <====>");
//     }
//   }

//   Failture _getError(DioException error) {
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//         return DataSource.connectionTimeout.toFailture();

//       case DioExceptionType.sendTimeout:
//         return DataSource.recieveTimeOut.toFailture();

//       case DioExceptionType.receiveTimeout:
//         return DataSource.recieveTimeOut.toFailture();

//       case DioExceptionType.badCertificate:
//         return DataSource.badRequest.toFailture();

//       case DioExceptionType.badResponse:
//         if (error.response == null) {
//           return DataSource.unknown.toFailture();
//         } else {
//           if (error.response?.statusCode != null &&
//               error.response?.statusMessage != null) {
//             return Failture(
//                 error.response!.statusCode!, error.response!.statusMessage!);
//           }
//           return DataSource.unknown.toFailture();
//         }

//       case DioExceptionType.cancel:
//         return DataSource.cancel.toFailture();

//       case DioExceptionType.connectionError:
//         return DataSource.connectionTimeout.toFailture();

//       case DioExceptionType.unknown:
//         return DataSource.unknown.toFailture();
//     }
//   }
// }

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unautorised,
  notFound,
  internalServerError,
  recieveTimeOut,
  cacheError,
  noInternetConnection,
  unknown,
  connectionTimeout,
  cancel,
}

extension DataSourceExtention on DataSource {
  Failture toFailture() {
    switch (this) {
      case DataSource.success:
        return Failture(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failture(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failture(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failture(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unautorised:
        return Failture(ResponseCode.unautorised, ResponseMessage.unautorised);
      case DataSource.notFound:
        return Failture(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failture(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.recieveTimeOut:
        return Failture(
            ResponseCode.recieveTimeOut, ResponseMessage.recieveTimeOut);
      case DataSource.cacheError:
        return Failture(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failture(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.unknown:
        return Failture(ResponseCode.unknown, ResponseMessage.unknown);
      case DataSource.connectionTimeout:
        return Failture(
            ResponseCode.connectionTimeout, ResponseMessage.connectionTimeout);
      case DataSource.cancel:
        return Failture(ResponseCode.cancel, ResponseMessage.cancel);
    }
  }
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int forbidden = 403;
  static const int unautorised = 401;
  static const int notFound = 404;
  static const int internalServerError = 500;

  ///LOCAL

  static const int noInternetConnection = -1;
  static const int recieveTimeOut = -2;
  static const int cacheError = -3;
  static const int connectionTimeout = -4;
  static const int unknown = -5;
  static const int cancel = -6;
}

class ResponseMessage {
  static const String success = 'success';
  static const String noContent = 'noContent';
  static const String badRequest = 'badRequest';
  static const String forbidden = 'forbidden';
  static const String unautorised = 'unautorised';
  static const String notFound = 'notFound';
  static const String internalServerError = 'internalServerError';

  ///LOCA
  static const String noInternetConnection = 'noInternetConnection';
  static const String recieveTimeOut = 'recieveTimeOut';
  static const String connectionTimeout = 'connectionTimeout';
  static const String cacheError = 'cacheError';
  static const String unknown = 'unknown';
  static const String cancel = 'cancel';
}

class ApiInternalState {
  static const success = true;
  static const failture = false;
}
