import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:sandcat/core/api/msg.dart';
import 'package:sandcat/core/models/seq/seq_model.dart';
import 'package:sandcat/core/network/api_client.dart';
import 'package:sandcat/core/protos/generated/common.pb.dart';
import 'package:sandcat/core/protos/extensions/msg_extensions.dart';

/// 消息API的HTTP实现
@LazySingleton(as: MsgApi)
class MsgApiImpl implements MsgApi {
  final ApiClient _apiClient;

  MsgApiImpl(this._apiClient);

  @override
  Future<List<Msg>> pullOfflineMessages({
    required String userId,
    int? sendStart,
    int? sendEnd,
    int? start,
    int? end,
  }) async {
    final response = await _apiClient.post('/message', data: {
      'userId': userId,
      'sendStart': sendStart,
      'sendEnd': sendEnd,
      'start': start,
      'end': end,
    });

    final List<dynamic> messagesJson = response.data as List<dynamic>;
    // 使用扩展方法直接从Map列表创建Msg对象
    return MsgExtensions.fromMapList(messagesJson);
  }

  @override
  Future<SeqModel> getSequence(String userId) async {
    final response = await _apiClient.get('/message/seq/$userId');
    return SeqModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> deleteMessages({
    required String userId,
    required List<String> messageIds,
  }) async {
    await _apiClient.delete('/message', data: {
      'user_id': userId,
      'msg_id': messageIds,
    });
  }
}
