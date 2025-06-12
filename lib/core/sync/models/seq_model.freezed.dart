// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seq_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SeqModel _$SeqModelFromJson(Map<String, dynamic> json) {
  return _SeqModel.fromJson(json);
}

/// @nodoc
mixin _$SeqModel {
  /// 接收消息的序列号
  int get seq => throw _privateConstructorUsedError;

  /// 发送消息的序列号
  int get sendSeq => throw _privateConstructorUsedError;

  /// Serializes this SeqModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeqModelCopyWith<SeqModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeqModelCopyWith<$Res> {
  factory $SeqModelCopyWith(SeqModel value, $Res Function(SeqModel) then) =
      _$SeqModelCopyWithImpl<$Res, SeqModel>;
  @useResult
  $Res call({int seq, int sendSeq});
}

/// @nodoc
class _$SeqModelCopyWithImpl<$Res, $Val extends SeqModel>
    implements $SeqModelCopyWith<$Res> {
  _$SeqModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seq = null,
    Object? sendSeq = null,
  }) {
    return _then(_value.copyWith(
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
      sendSeq: null == sendSeq
          ? _value.sendSeq
          : sendSeq // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeqModelImplCopyWith<$Res>
    implements $SeqModelCopyWith<$Res> {
  factory _$$SeqModelImplCopyWith(
          _$SeqModelImpl value, $Res Function(_$SeqModelImpl) then) =
      __$$SeqModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int seq, int sendSeq});
}

/// @nodoc
class __$$SeqModelImplCopyWithImpl<$Res>
    extends _$SeqModelCopyWithImpl<$Res, _$SeqModelImpl>
    implements _$$SeqModelImplCopyWith<$Res> {
  __$$SeqModelImplCopyWithImpl(
      _$SeqModelImpl _value, $Res Function(_$SeqModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SeqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seq = null,
    Object? sendSeq = null,
  }) {
    return _then(_$SeqModelImpl(
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
      sendSeq: null == sendSeq
          ? _value.sendSeq
          : sendSeq // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SeqModelImpl implements _SeqModel {
  const _$SeqModelImpl({required this.seq, required this.sendSeq});

  factory _$SeqModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeqModelImplFromJson(json);

  /// 接收消息的序列号
  @override
  final int seq;

  /// 发送消息的序列号
  @override
  final int sendSeq;

  @override
  String toString() {
    return 'SeqModel(seq: $seq, sendSeq: $sendSeq)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeqModelImpl &&
            (identical(other.seq, seq) || other.seq == seq) &&
            (identical(other.sendSeq, sendSeq) || other.sendSeq == sendSeq));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, seq, sendSeq);

  /// Create a copy of SeqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeqModelImplCopyWith<_$SeqModelImpl> get copyWith =>
      __$$SeqModelImplCopyWithImpl<_$SeqModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeqModelImplToJson(
      this,
    );
  }
}

abstract class _SeqModel implements SeqModel {
  const factory _SeqModel(
      {required final int seq, required final int sendSeq}) = _$SeqModelImpl;

  factory _SeqModel.fromJson(Map<String, dynamic> json) =
      _$SeqModelImpl.fromJson;

  /// 接收消息的序列号
  @override
  int get seq;

  /// 发送消息的序列号
  @override
  int get sendSeq;

  /// Create a copy of SeqModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeqModelImplCopyWith<_$SeqModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
