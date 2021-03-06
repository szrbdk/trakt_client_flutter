import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:trakt_client_flutter/src/client/base.dart';
import 'package:trakt_client_flutter/src/client/env.dart';

class Client {
  Client._();
  factory Client() => _instance;
  static final Client _instance = Client._();

  String _getUrl(String path) => '${Env().config.traktApiUrl}/$path';

  BaseOptions _dioOptions(Map<String, dynamic> extraHeaders) {
    var headers = {
      'trakt-api-key': Env().config.traktClient,
      'trakt-api-version': Env().config.traktApiVersion,
      'Content-type': 'application/json',
    };
    if (extraHeaders != null && extraHeaders.isNotEmpty) {
      extraHeaders.forEach((key, value) {
        headers.putIfAbsent(key, () => value);
      });
    }
    return BaseOptions(
      headers: headers,
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Future<TraktBase<T>> post<T, K>({
    @required String path,
    @required Map<String, dynamic> parameters,
    @required Map<String, dynamic> extraHeaders,
    @required Map<String, dynamic> content,
    @required T Function(K data) builder,
  }) {
    var completer = Completer<TraktBase<T>>();
    var dio = Dio(_dioOptions(extraHeaders));
    var url = _getUrl(path);

    dio.post(url, queryParameters: parameters, data: content).then((response) {
      completer.complete(
        TraktBase.fromResponse(
          header: response.headers.map,
          data: builder(response.data as K),
        ),
      );
    }).catchError((error) {
      completer.completeError(error);
    });
    return completer.future;
  }

  Future<TraktBase<T>> get<T, K>({
    @required String path,
    @required Map<String, dynamic> parameters,
    @required Map<String, dynamic> extraHeaders,
    @required T Function(K data) builder,
  }) {
    var completer = Completer<TraktBase<T>>();
    var dio = Dio(_dioOptions(extraHeaders));
    var url = _getUrl(path);

    dio.get(url, queryParameters: parameters).then((response) {
      completer.complete(
        TraktBase.fromResponse(
          header: response.headers.map,
          data: builder(response.data as K),
        ),
      );
    }).catchError((error) {
      completer.completeError(error);
    });
    return completer.future;
  }

  Future<TraktBase<T>> delete<T, K>({
    @required String path,
    @required Map<String, dynamic> parameters,
    @required Map<String, dynamic> extraHeaders,
    @required T Function(K data) builder,
  }) {
    var completer = Completer<TraktBase<T>>();
    var dio = Dio(_dioOptions(extraHeaders));
    var url = _getUrl(path);

    dio.delete(url, queryParameters: parameters).then((response) {
      completer.complete(
        TraktBase.fromResponse(
          header: response.headers.map,
          data: builder(response.data as K),
        ),
      );
    }).catchError((error) {
      completer.completeError(error);
    });
    return completer.future;
  }

  Future<TraktBase<T>> put<T, K>({
    @required String path,
    @required Map<String, dynamic> parameters,
    @required Map<String, dynamic> extraHeaders,
    @required Map<String, dynamic> content,
    @required T Function(K data) builder,
  }) {
    var completer = Completer<TraktBase<T>>();
    var dio = Dio(_dioOptions(extraHeaders));
    var url = _getUrl(path);

    dio.post(url, queryParameters: parameters, data: content).then((response) {
      completer.complete(
        TraktBase.fromResponse(
          header: response.headers.map,
          data: builder(response.data as K),
        ),
      );
    }).catchError((error) {
      completer.completeError(error);
    });
    return completer.future;
  }
}
