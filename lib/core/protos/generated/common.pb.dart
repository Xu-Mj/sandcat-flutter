//
//  Generated code. Do not modify.
//  source: common.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'common.pbenum.dart';

/// / decode message content by content type
/// / the content is candidate, when message type is Candidate
/// / the content is sustain, when message type is Hangup
/// / the content is String::to_vec(), when message type is SingleMsg/GroupMsg
/// / other message type, the content is bincode::serialize(&T)
class Msg extends $pb.GeneratedMessage {
  factory Msg({
    $core.String? senderId,
    $core.String? receiverId,
    $core.String? clientId,
    $core.String? serverId,
    $fixnum.Int64? createTime,
    $fixnum.Int64? sendTime,
    $fixnum.Int64? seq,
    MsgType? msgType,
    ContentType? contentType,
    $core.List<$core.int>? content,
    $core.bool? isRead,
    $core.String? groupId,
    PlatformType? platform,
    $core.String? avatar,
    $core.String? nickname,
    $core.String? relatedMsgId,
    $fixnum.Int64? sendSeq,
  }) {
    final result = create();
    if (senderId != null) result.sendId = senderId;
    if (receiverId != null) result.receiverId = receiverId;
    if (clientId != null) result.clientId = clientId;
    if (serverId != null) result.serverId = serverId;
    if (createTime != null) result.createTime = createTime;
    if (sendTime != null) result.sendTime = sendTime;
    if (seq != null) result.seq = seq;
    if (msgType != null) result.msgType = msgType;
    if (contentType != null) result.contentType = contentType;
    if (content != null) result.content = content;
    if (isRead != null) result.isRead = isRead;
    if (groupId != null) result.groupId = groupId;
    if (platform != null) result.platform = platform;
    if (avatar != null) result.avatar = avatar;
    if (nickname != null) result.nickname = nickname;
    if (relatedMsgId != null) result.relatedMsgId = relatedMsgId;
    if (sendSeq != null) result.sendSeq = sendSeq;
    return result;
  }

  Msg._();

  factory Msg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Msg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Msg',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'message'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sendId')
    ..aOS(2, _omitFieldNames ? '' : 'receiverId')
    ..aOS(3, _omitFieldNames ? '' : 'clientId')
    ..aOS(4, _omitFieldNames ? '' : 'serverId')
    ..aInt64(5, _omitFieldNames ? '' : 'createTime')
    ..aInt64(6, _omitFieldNames ? '' : 'sendTime')
    ..aInt64(7, _omitFieldNames ? '' : 'seq')
    ..e<MsgType>(8, _omitFieldNames ? '' : 'msgType', $pb.PbFieldType.OE,
        defaultOrMaker: MsgType.MsgTypeSingleMsg,
        valueOf: MsgType.valueOf,
        enumValues: MsgType.values)
    ..e<ContentType>(
        9, _omitFieldNames ? '' : 'contentType', $pb.PbFieldType.OE,
        defaultOrMaker: ContentType.Default,
        valueOf: ContentType.valueOf,
        enumValues: ContentType.values)
    ..a<$core.List<$core.int>>(
        10, _omitFieldNames ? '' : 'content', $pb.PbFieldType.OY)
    ..aOB(11, _omitFieldNames ? '' : 'isRead')
    ..aOS(12, _omitFieldNames ? '' : 'groupId')
    ..e<PlatformType>(13, _omitFieldNames ? '' : 'platform', $pb.PbFieldType.OE,
        defaultOrMaker: PlatformType.Desktop,
        valueOf: PlatformType.valueOf,
        enumValues: PlatformType.values)
    ..aOS(14, _omitFieldNames ? '' : 'avatar')
    ..aOS(15, _omitFieldNames ? '' : 'nickname')
    ..aOS(16, _omitFieldNames ? '' : 'relatedMsgId')
    ..aInt64(17, _omitFieldNames ? '' : 'sendSeq')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Msg clone() => Msg()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Msg copyWith(void Function(Msg) updates) =>
      super.copyWith((message) => updates(message as Msg)) as Msg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Msg create() => Msg._();
  @$core.override
  Msg createEmptyInstance() => create();
  static $pb.PbList<Msg> createRepeated() => $pb.PbList<Msg>();
  @$core.pragma('dart2js:noInline')
  static Msg getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Msg>(create);
  static Msg? _defaultInstance;

  /// must have
  @$pb.TagNumber(1)
  $core.String get sendId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sendId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSendId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSendId() => $_clearField(1);

  /// must have
  @$pb.TagNumber(2)
  $core.String get receiverId => $_getSZ(1);
  @$pb.TagNumber(2)
  set receiverId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReceiverId() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiverId() => $_clearField(2);

  /// must have
  @$pb.TagNumber(3)
  $core.String get clientId => $_getSZ(2);
  @$pb.TagNumber(3)
  set clientId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasClientId() => $_has(2);
  @$pb.TagNumber(3)
  void clearClientId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get serverId => $_getSZ(3);
  @$pb.TagNumber(4)
  set serverId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasServerId() => $_has(3);
  @$pb.TagNumber(4)
  void clearServerId() => $_clearField(4);

  /// timestamp
  @$pb.TagNumber(5)
  $fixnum.Int64 get createTime => $_getI64(4);
  @$pb.TagNumber(5)
  set createTime($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCreateTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreateTime() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get sendTime => $_getI64(5);
  @$pb.TagNumber(6)
  set sendTime($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSendTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearSendTime() => $_clearField(6);

  /// receiver sequence
  @$pb.TagNumber(7)
  $fixnum.Int64 get seq => $_getI64(6);
  @$pb.TagNumber(7)
  set seq($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSeq() => $_has(6);
  @$pb.TagNumber(7)
  void clearSeq() => $_clearField(7);

  /// is there necessary to cary the user's avatar and nickname?
  @$pb.TagNumber(8)
  MsgType get msgType => $_getN(7);
  @$pb.TagNumber(8)
  set msgType(MsgType value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasMsgType() => $_has(7);
  @$pb.TagNumber(8)
  void clearMsgType() => $_clearField(8);

  @$pb.TagNumber(9)
  ContentType get contentType => $_getN(8);
  @$pb.TagNumber(9)
  set contentType(ContentType value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasContentType() => $_has(8);
  @$pb.TagNumber(9)
  void clearContentType() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.List<$core.int> get content => $_getN(9);
  @$pb.TagNumber(10)
  set content($core.List<$core.int> value) => $_setBytes(9, value);
  @$pb.TagNumber(10)
  $core.bool hasContent() => $_has(9);
  @$pb.TagNumber(10)
  void clearContent() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get isRead => $_getBF(10);
  @$pb.TagNumber(11)
  set isRead($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIsRead() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsRead() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get groupId => $_getSZ(11);
  @$pb.TagNumber(12)
  set groupId($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasGroupId() => $_has(11);
  @$pb.TagNumber(12)
  void clearGroupId() => $_clearField(12);

  /// platform of the sender
  @$pb.TagNumber(13)
  PlatformType get platform => $_getN(12);
  @$pb.TagNumber(13)
  set platform(PlatformType value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasPlatform() => $_has(12);
  @$pb.TagNumber(13)
  void clearPlatform() => $_clearField(13);

  /// user avatar
  @$pb.TagNumber(14)
  $core.String get avatar => $_getSZ(13);
  @$pb.TagNumber(14)
  set avatar($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasAvatar() => $_has(13);
  @$pb.TagNumber(14)
  void clearAvatar() => $_clearField(14);

  /// user nickname
  @$pb.TagNumber(15)
  $core.String get nickname => $_getSZ(14);
  @$pb.TagNumber(15)
  set nickname($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasNickname() => $_has(14);
  @$pb.TagNumber(15)
  void clearNickname() => $_clearField(15);

  /// related message id
  @$pb.TagNumber(16)
  $core.String get relatedMsgId => $_getSZ(15);
  @$pb.TagNumber(16)
  set relatedMsgId($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasRelatedMsgId() => $_has(15);
  @$pb.TagNumber(16)
  void clearRelatedMsgId() => $_clearField(16);

  /// / send sequence
  @$pb.TagNumber(17)
  $fixnum.Int64 get sendSeq => $_getI64(16);
  @$pb.TagNumber(17)
  set sendSeq($fixnum.Int64 value) => $_setInt64(16, value);
  @$pb.TagNumber(17)
  $core.bool hasSendSeq() => $_has(16);
  @$pb.TagNumber(17)
  void clearSendSeq() => $_clearField(17);
}

class MsgContent extends $pb.GeneratedMessage {
  factory MsgContent({
    $core.String? content,
    Mention? mention,
  }) {
    final result = create();
    if (content != null) result.content = content;
    if (mention != null) result.mention = mention;
    return result;
  }

  MsgContent._();

  factory MsgContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MsgContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MsgContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'message'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'content')
    ..aOM<Mention>(2, _omitFieldNames ? '' : 'mention',
        subBuilder: Mention.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MsgContent clone() => MsgContent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MsgContent copyWith(void Function(MsgContent) updates) =>
      super.copyWith((message) => updates(message as MsgContent)) as MsgContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MsgContent create() => MsgContent._();
  @$core.override
  MsgContent createEmptyInstance() => create();
  static $pb.PbList<MsgContent> createRepeated() => $pb.PbList<MsgContent>();
  @$core.pragma('dart2js:noInline')
  static MsgContent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MsgContent>(create);
  static MsgContent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get content => $_getSZ(0);
  @$pb.TagNumber(1)
  set content($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => $_clearField(1);

  @$pb.TagNumber(2)
  Mention get mention => $_getN(1);
  @$pb.TagNumber(2)
  set mention(Mention value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMention() => $_has(1);
  @$pb.TagNumber(2)
  void clearMention() => $_clearField(2);
  @$pb.TagNumber(2)
  Mention ensureMention() => $_ensure(1);
}

class Mention extends $pb.GeneratedMessage {
  factory Mention({
    $core.bool? all,
    $core.Iterable<$core.String>? userIds,
  }) {
    final result = create();
    if (all != null) result.all = all;
    if (userIds != null) result.userIds.addAll(userIds);
    return result;
  }

  Mention._();

  factory Mention.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Mention.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Mention',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'message'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'all')
    ..pPS(2, _omitFieldNames ? '' : 'userIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Mention clone() => Mention()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Mention copyWith(void Function(Mention) updates) =>
      super.copyWith((message) => updates(message as Mention)) as Mention;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Mention create() => Mention._();
  @$core.override
  Mention createEmptyInstance() => create();
  static $pb.PbList<Mention> createRepeated() => $pb.PbList<Mention>();
  @$core.pragma('dart2js:noInline')
  static Mention getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Mention>(create);
  static Mention? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get all => $_getBF(0);
  @$pb.TagNumber(1)
  set all($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAll() => $_has(0);
  @$pb.TagNumber(1)
  void clearAll() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get userIds => $_getList(1);
}

class MsgRead extends $pb.GeneratedMessage {
  factory MsgRead({
    $core.Iterable<$fixnum.Int64>? msgSeq,
    $core.String? userId,
  }) {
    final result = create();
    if (msgSeq != null) result.msgSeq.addAll(msgSeq);
    if (userId != null) result.userId = userId;
    return result;
  }

  MsgRead._();

  factory MsgRead.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MsgRead.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MsgRead',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'message'),
      createEmptyInstance: create)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'msgSeq', $pb.PbFieldType.K6)
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MsgRead clone() => MsgRead()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MsgRead copyWith(void Function(MsgRead) updates) =>
      super.copyWith((message) => updates(message as MsgRead)) as MsgRead;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MsgRead create() => MsgRead._();
  @$core.override
  MsgRead createEmptyInstance() => create();
  static $pb.PbList<MsgRead> createRepeated() => $pb.PbList<MsgRead>();
  @$core.pragma('dart2js:noInline')
  static MsgRead getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MsgRead>(create);
  static MsgRead? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get msgSeq => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class Candidate extends $pb.GeneratedMessage {
  factory Candidate({
    $core.String? candidate,
    $core.String? sdpMid,
    $core.int? sdpMIndex,
  }) {
    final result = create();
    if (candidate != null) result.candidate = candidate;
    if (sdpMid != null) result.sdpMid = sdpMid;
    if (sdpMIndex != null) result.sdpMIndex = sdpMIndex;
    return result;
  }

  Candidate._();

  factory Candidate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Candidate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Candidate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'message'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'candidate')
    ..aOS(2, _omitFieldNames ? '' : 'sdpMid')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'sdpMIndex', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Candidate clone() => Candidate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Candidate copyWith(void Function(Candidate) updates) =>
      super.copyWith((message) => updates(message as Candidate)) as Candidate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Candidate create() => Candidate._();
  @$core.override
  Candidate createEmptyInstance() => create();
  static $pb.PbList<Candidate> createRepeated() => $pb.PbList<Candidate>();
  @$core.pragma('dart2js:noInline')
  static Candidate getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Candidate>(create);
  static Candidate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get candidate => $_getSZ(0);
  @$pb.TagNumber(1)
  set candidate($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCandidate() => $_has(0);
  @$pb.TagNumber(1)
  void clearCandidate() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sdpMid => $_getSZ(1);
  @$pb.TagNumber(2)
  set sdpMid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSdpMid() => $_has(1);
  @$pb.TagNumber(2)
  void clearSdpMid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get sdpMIndex => $_getIZ(2);
  @$pb.TagNumber(3)
  set sdpMIndex($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSdpMIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearSdpMIndex() => $_clearField(3);
}

class AgreeSingleCall extends $pb.GeneratedMessage {
  factory AgreeSingleCall({
    $core.String? sdp,
  }) {
    final result = create();
    if (sdp != null) result.sdp = sdp;
    return result;
  }

  AgreeSingleCall._();

  factory AgreeSingleCall.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AgreeSingleCall.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AgreeSingleCall',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'message'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sdp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AgreeSingleCall clone() => AgreeSingleCall()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AgreeSingleCall copyWith(void Function(AgreeSingleCall) updates) =>
      super.copyWith((message) => updates(message as AgreeSingleCall))
          as AgreeSingleCall;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AgreeSingleCall create() => AgreeSingleCall._();
  @$core.override
  AgreeSingleCall createEmptyInstance() => create();
  static $pb.PbList<AgreeSingleCall> createRepeated() =>
      $pb.PbList<AgreeSingleCall>();
  @$core.pragma('dart2js:noInline')
  static AgreeSingleCall getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AgreeSingleCall>(create);
  static AgreeSingleCall? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sdp => $_getSZ(0);
  @$pb.TagNumber(1)
  set sdp($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSdp() => $_has(0);
  @$pb.TagNumber(1)
  void clearSdp() => $_clearField(1);
}

class SingleCallInvite extends $pb.GeneratedMessage {
  factory SingleCallInvite({
    SingleCallInviteType? inviteType,
  }) {
    final result = create();
    if (inviteType != null) result.inviteType = inviteType;
    return result;
  }

  SingleCallInvite._();

  factory SingleCallInvite.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SingleCallInvite.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SingleCallInvite',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'message'),
      createEmptyInstance: create)
    ..e<SingleCallInviteType>(
        1, _omitFieldNames ? '' : 'inviteType', $pb.PbFieldType.OE,
        defaultOrMaker: SingleCallInviteType.SingleAudio,
        valueOf: SingleCallInviteType.valueOf,
        enumValues: SingleCallInviteType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SingleCallInvite clone() => SingleCallInvite()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SingleCallInvite copyWith(void Function(SingleCallInvite) updates) =>
      super.copyWith((message) => updates(message as SingleCallInvite))
          as SingleCallInvite;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SingleCallInvite create() => SingleCallInvite._();
  @$core.override
  SingleCallInvite createEmptyInstance() => create();
  static $pb.PbList<SingleCallInvite> createRepeated() =>
      $pb.PbList<SingleCallInvite>();
  @$core.pragma('dart2js:noInline')
  static SingleCallInvite getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SingleCallInvite>(create);
  static SingleCallInvite? _defaultInstance;

  @$pb.TagNumber(1)
  SingleCallInviteType get inviteType => $_getN(0);
  @$pb.TagNumber(1)
  set inviteType(SingleCallInviteType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInviteType() => $_has(0);
  @$pb.TagNumber(1)
  void clearInviteType() => $_clearField(1);
}

class SingleCallInviteAnswer extends $pb.GeneratedMessage {
  factory SingleCallInviteAnswer({
    $core.bool? agree,
    SingleCallInviteType? inviteType,
  }) {
    final result = create();
    if (agree != null) result.agree = agree;
    if (inviteType != null) result.inviteType = inviteType;
    return result;
  }

  SingleCallInviteAnswer._();

  factory SingleCallInviteAnswer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SingleCallInviteAnswer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SingleCallInviteAnswer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'message'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'agree')
    ..e<SingleCallInviteType>(
        2, _omitFieldNames ? '' : 'inviteType', $pb.PbFieldType.OE,
        defaultOrMaker: SingleCallInviteType.SingleAudio,
        valueOf: SingleCallInviteType.valueOf,
        enumValues: SingleCallInviteType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SingleCallInviteAnswer clone() =>
      SingleCallInviteAnswer()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SingleCallInviteAnswer copyWith(
          void Function(SingleCallInviteAnswer) updates) =>
      super.copyWith((message) => updates(message as SingleCallInviteAnswer))
          as SingleCallInviteAnswer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SingleCallInviteAnswer create() => SingleCallInviteAnswer._();
  @$core.override
  SingleCallInviteAnswer createEmptyInstance() => create();
  static $pb.PbList<SingleCallInviteAnswer> createRepeated() =>
      $pb.PbList<SingleCallInviteAnswer>();
  @$core.pragma('dart2js:noInline')
  static SingleCallInviteAnswer getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SingleCallInviteAnswer>(create);
  static SingleCallInviteAnswer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get agree => $_getBF(0);
  @$pb.TagNumber(1)
  set agree($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAgree() => $_has(0);
  @$pb.TagNumber(1)
  void clearAgree() => $_clearField(1);

  @$pb.TagNumber(2)
  SingleCallInviteType get inviteType => $_getN(1);
  @$pb.TagNumber(2)
  set inviteType(SingleCallInviteType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasInviteType() => $_has(1);
  @$pb.TagNumber(2)
  void clearInviteType() => $_clearField(2);
}

class SingleCallInviteNotAnswer extends $pb.GeneratedMessage {
  factory SingleCallInviteNotAnswer({
    SingleCallInviteType? inviteType,
  }) {
    final result = create();
    if (inviteType != null) result.inviteType = inviteType;
    return result;
  }

  SingleCallInviteNotAnswer._();

  factory SingleCallInviteNotAnswer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SingleCallInviteNotAnswer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SingleCallInviteNotAnswer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'message'),
      createEmptyInstance: create)
    ..e<SingleCallInviteType>(
        1, _omitFieldNames ? '' : 'inviteType', $pb.PbFieldType.OE,
        defaultOrMaker: SingleCallInviteType.SingleAudio,
        valueOf: SingleCallInviteType.valueOf,
        enumValues: SingleCallInviteType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SingleCallInviteNotAnswer clone() =>
      SingleCallInviteNotAnswer()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SingleCallInviteNotAnswer copyWith(
          void Function(SingleCallInviteNotAnswer) updates) =>
      super.copyWith((message) => updates(message as SingleCallInviteNotAnswer))
          as SingleCallInviteNotAnswer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SingleCallInviteNotAnswer create() => SingleCallInviteNotAnswer._();
  @$core.override
  SingleCallInviteNotAnswer createEmptyInstance() => create();
  static $pb.PbList<SingleCallInviteNotAnswer> createRepeated() =>
      $pb.PbList<SingleCallInviteNotAnswer>();
  @$core.pragma('dart2js:noInline')
  static SingleCallInviteNotAnswer getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SingleCallInviteNotAnswer>(create);
  static SingleCallInviteNotAnswer? _defaultInstance;

  @$pb.TagNumber(1)
  SingleCallInviteType get inviteType => $_getN(0);
  @$pb.TagNumber(1)
  set inviteType(SingleCallInviteType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInviteType() => $_has(0);
  @$pb.TagNumber(1)
  void clearInviteType() => $_clearField(1);
}

class SingleCallInviteCancel extends $pb.GeneratedMessage {
  factory SingleCallInviteCancel({
    SingleCallInviteType? inviteType,
  }) {
    final result = create();
    if (inviteType != null) result.inviteType = inviteType;
    return result;
  }

  SingleCallInviteCancel._();

  factory SingleCallInviteCancel.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SingleCallInviteCancel.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SingleCallInviteCancel',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'message'),
      createEmptyInstance: create)
    ..e<SingleCallInviteType>(
        2, _omitFieldNames ? '' : 'inviteType', $pb.PbFieldType.OE,
        defaultOrMaker: SingleCallInviteType.SingleAudio,
        valueOf: SingleCallInviteType.valueOf,
        enumValues: SingleCallInviteType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SingleCallInviteCancel clone() =>
      SingleCallInviteCancel()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SingleCallInviteCancel copyWith(
          void Function(SingleCallInviteCancel) updates) =>
      super.copyWith((message) => updates(message as SingleCallInviteCancel))
          as SingleCallInviteCancel;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SingleCallInviteCancel create() => SingleCallInviteCancel._();
  @$core.override
  SingleCallInviteCancel createEmptyInstance() => create();
  static $pb.PbList<SingleCallInviteCancel> createRepeated() =>
      $pb.PbList<SingleCallInviteCancel>();
  @$core.pragma('dart2js:noInline')
  static SingleCallInviteCancel getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SingleCallInviteCancel>(create);
  static SingleCallInviteCancel? _defaultInstance;

  @$pb.TagNumber(2)
  SingleCallInviteType get inviteType => $_getN(0);
  @$pb.TagNumber(2)
  set inviteType(SingleCallInviteType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasInviteType() => $_has(0);
  @$pb.TagNumber(2)
  void clearInviteType() => $_clearField(2);
}

class SingleCallOffer extends $pb.GeneratedMessage {
  factory SingleCallOffer({
    $core.String? sdp,
  }) {
    final result = create();
    if (sdp != null) result.sdp = sdp;
    return result;
  }

  SingleCallOffer._();

  factory SingleCallOffer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SingleCallOffer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SingleCallOffer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'message'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sdp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SingleCallOffer clone() => SingleCallOffer()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SingleCallOffer copyWith(void Function(SingleCallOffer) updates) =>
      super.copyWith((message) => updates(message as SingleCallOffer))
          as SingleCallOffer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SingleCallOffer create() => SingleCallOffer._();
  @$core.override
  SingleCallOffer createEmptyInstance() => create();
  static $pb.PbList<SingleCallOffer> createRepeated() =>
      $pb.PbList<SingleCallOffer>();
  @$core.pragma('dart2js:noInline')
  static SingleCallOffer getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SingleCallOffer>(create);
  static SingleCallOffer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sdp => $_getSZ(0);
  @$pb.TagNumber(1)
  set sdp($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSdp() => $_has(0);
  @$pb.TagNumber(1)
  void clearSdp() => $_clearField(1);
}

class Hangup extends $pb.GeneratedMessage {
  factory Hangup({
    SingleCallInviteType? inviteType,
    $fixnum.Int64? sustain,
  }) {
    final result = create();
    if (inviteType != null) result.inviteType = inviteType;
    if (sustain != null) result.sustain = sustain;
    return result;
  }

  Hangup._();

  factory Hangup.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Hangup.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Hangup',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'message'),
      createEmptyInstance: create)
    ..e<SingleCallInviteType>(
        1, _omitFieldNames ? '' : 'inviteType', $pb.PbFieldType.OE,
        defaultOrMaker: SingleCallInviteType.SingleAudio,
        valueOf: SingleCallInviteType.valueOf,
        enumValues: SingleCallInviteType.values)
    ..aInt64(2, _omitFieldNames ? '' : 'sustain')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Hangup clone() => Hangup()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Hangup copyWith(void Function(Hangup) updates) =>
      super.copyWith((message) => updates(message as Hangup)) as Hangup;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Hangup create() => Hangup._();
  @$core.override
  Hangup createEmptyInstance() => create();
  static $pb.PbList<Hangup> createRepeated() => $pb.PbList<Hangup>();
  @$core.pragma('dart2js:noInline')
  static Hangup getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Hangup>(create);
  static Hangup? _defaultInstance;

  @$pb.TagNumber(1)
  SingleCallInviteType get inviteType => $_getN(0);
  @$pb.TagNumber(1)
  set inviteType(SingleCallInviteType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInviteType() => $_has(0);
  @$pb.TagNumber(1)
  void clearInviteType() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sustain => $_getI64(1);
  @$pb.TagNumber(2)
  set sustain($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSustain() => $_has(1);
  @$pb.TagNumber(2)
  void clearSustain() => $_clearField(2);
}

/// / use to send single message or group message;
/// / message ws is used to connect the client by websocket;
/// / and it receive message from clients; then send message to mq;
/// / so only provide the send message function for other rpc service;
class Single extends $pb.GeneratedMessage {
  factory Single({
    $core.String? content,
    ContentType? contentType,
  }) {
    final result = create();
    if (content != null) result.content = content;
    if (contentType != null) result.contentType = contentType;
    return result;
  }

  Single._();

  factory Single.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Single.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Single',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'message'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'content')
    ..e<ContentType>(
        3, _omitFieldNames ? '' : 'contentType', $pb.PbFieldType.OE,
        defaultOrMaker: ContentType.Default,
        valueOf: ContentType.valueOf,
        enumValues: ContentType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Single clone() => Single()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Single copyWith(void Function(Single) updates) =>
      super.copyWith((message) => updates(message as Single)) as Single;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Single create() => Single._();
  @$core.override
  Single createEmptyInstance() => create();
  static $pb.PbList<Single> createRepeated() => $pb.PbList<Single>();
  @$core.pragma('dart2js:noInline')
  static Single getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Single>(create);
  static Single? _defaultInstance;

  /// message content
  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(0);
  @$pb.TagNumber(2)
  set content($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(2)
  void clearContent() => $_clearField(2);

  /// message type
  @$pb.TagNumber(3)
  ContentType get contentType => $_getN(1);
  @$pb.TagNumber(3)
  set contentType(ContentType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasContentType() => $_has(1);
  @$pb.TagNumber(3)
  void clearContentType() => $_clearField(3);
}

class MsgResponse extends $pb.GeneratedMessage {
  factory MsgResponse({
    $core.String? clientId,
    $core.String? serverId,
    $fixnum.Int64? sendTime,
    $core.String? err,
  }) {
    final result = create();
    if (clientId != null) result.clientId = clientId;
    if (serverId != null) result.serverId = serverId;
    if (sendTime != null) result.sendTime = sendTime;
    if (err != null) result.err = err;
    return result;
  }

  MsgResponse._();

  factory MsgResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MsgResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MsgResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'message'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'clientId')
    ..aOS(2, _omitFieldNames ? '' : 'serverId')
    ..aInt64(3, _omitFieldNames ? '' : 'sendTime')
    ..aOS(4, _omitFieldNames ? '' : 'err')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MsgResponse clone() => MsgResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MsgResponse copyWith(void Function(MsgResponse) updates) =>
      super.copyWith((message) => updates(message as MsgResponse))
          as MsgResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MsgResponse create() => MsgResponse._();
  @$core.override
  MsgResponse createEmptyInstance() => create();
  static $pb.PbList<MsgResponse> createRepeated() => $pb.PbList<MsgResponse>();
  @$core.pragma('dart2js:noInline')
  static MsgResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MsgResponse>(create);
  static MsgResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get clientId => $_getSZ(0);
  @$pb.TagNumber(1)
  set clientId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get serverId => $_getSZ(1);
  @$pb.TagNumber(2)
  set serverId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasServerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearServerId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get sendTime => $_getI64(2);
  @$pb.TagNumber(3)
  set sendTime($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSendTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearSendTime() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get err => $_getSZ(3);
  @$pb.TagNumber(4)
  set err($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasErr() => $_has(3);
  @$pb.TagNumber(4)
  void clearErr() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
