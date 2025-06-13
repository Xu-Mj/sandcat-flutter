// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seq_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SeqModelImpl _$$SeqModelImplFromJson(Map<String, dynamic> json) =>
    _$SeqModelImpl(
      seq: (json['seq'] as num).toInt(),
      sendSeq: (json['sendSeq'] as num).toInt(),
    );

Map<String, dynamic> _$$SeqModelImplToJson(_$SeqModelImpl instance) =>
    <String, dynamic>{
      'seq': instance.seq,
      'sendSeq': instance.sendSeq,
    };
