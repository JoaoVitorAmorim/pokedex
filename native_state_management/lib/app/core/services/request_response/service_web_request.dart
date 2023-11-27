import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:native_state_management/app/core/services/request_response/interface/iservice_web_request.dart';
import 'package:native_state_management/app/core/services/request_response/interface/iservice_web_response.dart';
import 'service_web_response.dart';
import 'package:retry/retry.dart';

final class ServiceWebHttp implements IServiceWebRequest {
  const ServiceWebHttp();

  @override
  Future<IServiceWebResponse> get(String url,
      {Map<String, String>? headers}) async {
    late final http.Response response;
    try {
      if (kIsWeb) {
        response = await retry(
          () => http.get(Uri.parse(url), headers: headers),
          retryIf: (e) => e is SocketException || e is TimeoutException,
        );
      } else {
        response = await Isolate.run<http.Response>(() => retry(
              () => http.get(Uri.parse(url), headers: headers),
              retryIf: (e) => e is SocketException || e is TimeoutException,
            ));
      }
      return ServiceWebResponse(
          statusCode: response.statusCode,
          body: response.body,
          headers: response.headers);
    } catch (e) {
      return ServiceWebResponse(
        statusCode: 500,
        body: 'detail:${e.toString()}',
        headers: {},
      );
    }
  }

  @override
  Future<IServiceWebResponse> post(String url,
      {Object? body, Map<String, String>? headers, Encoding? encoding}) async {
    late final http.Response response;

    if (kIsWeb) {
      response = await retry(
        () => http.post(Uri.parse(url),
            headers: headers, body: body, encoding: encoding),
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } else {
      response = await Isolate.run<http.Response>(
        () => retry(
          () => http.post(Uri.parse(url),
              headers: headers, body: body, encoding: encoding),
          retryIf: (e) => e is SocketException || e is TimeoutException,
        ),
      );
    }

    return ServiceWebResponse(
        statusCode: response.statusCode,
        body: response.body,
        headers: response.headers);
  }

  @override
  Future<IServiceWebResponse> delete(String url,
      {Object? body, Map<String, String>? headers, Encoding? encoding}) async {
    late final http.Response response;

    if (kIsWeb) {
      response = await retry(
        () => http.delete(Uri.parse(url),
            headers: headers, body: body, encoding: encoding),
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } else {
      response = await Isolate.run<http.Response>(
        () => retry(
          () => http.delete(Uri.parse(url),
              headers: headers, body: body, encoding: encoding),
          retryIf: (e) => e is SocketException || e is TimeoutException,
        ),
      );
    }

    return ServiceWebResponse(
        statusCode: response.statusCode,
        body: response.body,
        headers: response.headers);
  }

  @override
  Future<IServiceWebResponse> put(String url,
      {Object? body, Map<String, String>? headers, Encoding? encoding}) async {
    late final http.Response response;

    if (kIsWeb) {
      response = await retry(
        () => http.put(Uri.parse(url),
            headers: headers, body: body, encoding: encoding),
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } else {
      response = await Isolate.run<http.Response>(
        () => retry(
          () => http.put(Uri.parse(url),
              headers: headers, body: body, encoding: encoding),
          retryIf: (e) => e is SocketException || e is TimeoutException,
        ),
      );
    }

    return ServiceWebResponse(
        statusCode: response.statusCode,
        body: response.body,
        headers: response.headers);
  }
}
