import 'dart:convert';
import 'iservice_web_response.dart';

abstract interface class IServiceWebRequest {
  const IServiceWebRequest();

  Future<IServiceWebResponse> get(String url, {Map<String, String>? headers});

  Future<IServiceWebResponse> post(String url,
      {Object? body, Map<String, String>? headers, Encoding? encoding});

  Future<IServiceWebResponse> delete(String url,
      {Object? body, Map<String, String>? headers, Encoding? encoding});

  Future<IServiceWebResponse> put(String url,
      {Object? body, Map<String, String>? headers, Encoding? encoding});
}
