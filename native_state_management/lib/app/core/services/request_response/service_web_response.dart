import 'package:native_state_management/app/core/services/request_response/interface/iservice_web_response.dart';

class ServiceWebResponse implements IServiceWebResponse {
  @override
  final String body;
  @override
  final int statusCode;
  @override
  final Map<String, String> headers;

  const ServiceWebResponse(
      {required this.body, required this.statusCode, required this.headers});
}
