import 'package:flutter/material.dart';
import 'package:trakt_client/src/client/base.dart';
import 'package:trakt_client/src/client/client.dart';
import 'package:trakt_client/src/client/env.dart';

import 'package:trakt_client/src/model/trakt_token.dart';
import 'package:trakt_client/src/model/trakt_token_form.dart';

part 'package:trakt_client/src/service/authentication_service.dart';

/// `MSMR` -> Map Sends, Map Returns
///
/// `MSMLR` ->  Map Sends, Map List Returns
///
/// `MLS_MR` ->  Map List Sends, Map Returns
///
/// `MLS_MLR` ->  Map List Sends, Map List Returns
///
abstract class TraktServiceCore {
  Future<TraktBase<T>> _post_MS_MR<T>({
    @required String path,
    @required Map<String, dynamic> queryParameters,
    @required Map<String, dynamic> content,
    @required T Function(Map<String, dynamic> response) builder,
  }) {
    return Client().post<T, Map<String, dynamic>>(
      path: path,
      parameters: queryParameters,
      content: content,
      builder: builder,
    );
  }
}