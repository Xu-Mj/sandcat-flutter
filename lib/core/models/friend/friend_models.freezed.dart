// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FriendShipList _$FriendShipListFromJson(Map<String, dynamic> json) {
  return _FriendShipList.fromJson(json);
}

/// @nodoc
mixin _$FriendShipList {
  List<Map<String, dynamic>> get friends => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get fs => throw _privateConstructorUsedError;

  /// Serializes this FriendShipList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendShipList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendShipListCopyWith<FriendShipList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendShipListCopyWith<$Res> {
  factory $FriendShipListCopyWith(
          FriendShipList value, $Res Function(FriendShipList) then) =
      _$FriendShipListCopyWithImpl<$Res, FriendShipList>;
  @useResult
  $Res call(
      {List<Map<String, dynamic>> friends, List<Map<String, dynamic>> fs});
}

/// @nodoc
class _$FriendShipListCopyWithImpl<$Res, $Val extends FriendShipList>
    implements $FriendShipListCopyWith<$Res> {
  _$FriendShipListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendShipList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friends = null,
    Object? fs = null,
  }) {
    return _then(_value.copyWith(
      friends: null == friends
          ? _value.friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      fs: null == fs
          ? _value.fs
          : fs // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendShipListImplCopyWith<$Res>
    implements $FriendShipListCopyWith<$Res> {
  factory _$$FriendShipListImplCopyWith(_$FriendShipListImpl value,
          $Res Function(_$FriendShipListImpl) then) =
      __$$FriendShipListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Map<String, dynamic>> friends, List<Map<String, dynamic>> fs});
}

/// @nodoc
class __$$FriendShipListImplCopyWithImpl<$Res>
    extends _$FriendShipListCopyWithImpl<$Res, _$FriendShipListImpl>
    implements _$$FriendShipListImplCopyWith<$Res> {
  __$$FriendShipListImplCopyWithImpl(
      _$FriendShipListImpl _value, $Res Function(_$FriendShipListImpl) _then)
      : super(_value, _then);

  /// Create a copy of FriendShipList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friends = null,
    Object? fs = null,
  }) {
    return _then(_$FriendShipListImpl(
      friends: null == friends
          ? _value._friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      fs: null == fs
          ? _value._fs
          : fs // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendShipListImpl implements _FriendShipList {
  const _$FriendShipListImpl(
      {final List<Map<String, dynamic>> friends = const [],
      final List<Map<String, dynamic>> fs = const []})
      : _friends = friends,
        _fs = fs;

  factory _$FriendShipListImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendShipListImplFromJson(json);

  final List<Map<String, dynamic>> _friends;
  @override
  @JsonKey()
  List<Map<String, dynamic>> get friends {
    if (_friends is EqualUnmodifiableListView) return _friends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_friends);
  }

  final List<Map<String, dynamic>> _fs;
  @override
  @JsonKey()
  List<Map<String, dynamic>> get fs {
    if (_fs is EqualUnmodifiableListView) return _fs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fs);
  }

  @override
  String toString() {
    return 'FriendShipList(friends: $friends, fs: $fs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendShipListImpl &&
            const DeepCollectionEquality().equals(other._friends, _friends) &&
            const DeepCollectionEquality().equals(other._fs, _fs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_friends),
      const DeepCollectionEquality().hash(_fs));

  /// Create a copy of FriendShipList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendShipListImplCopyWith<_$FriendShipListImpl> get copyWith =>
      __$$FriendShipListImplCopyWithImpl<_$FriendShipListImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendShipListImplToJson(
      this,
    );
  }
}

abstract class _FriendShipList implements FriendShipList {
  const factory _FriendShipList(
      {final List<Map<String, dynamic>> friends,
      final List<Map<String, dynamic>> fs}) = _$FriendShipListImpl;

  factory _FriendShipList.fromJson(Map<String, dynamic> json) =
      _$FriendShipListImpl.fromJson;

  @override
  List<Map<String, dynamic>> get friends;
  @override
  List<Map<String, dynamic>> get fs;

  /// Create a copy of FriendShipList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendShipListImplCopyWith<_$FriendShipListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FriendInfo _$FriendInfoFromJson(Map<String, dynamic> json) {
  return _FriendInfo.fromJson(json);
}

/// @nodoc
mixin _$FriendInfo {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get account => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get region => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String get signature => throw _privateConstructorUsedError;
  bool get isFriend => throw _privateConstructorUsedError;

  /// Serializes this FriendInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendInfoCopyWith<FriendInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendInfoCopyWith<$Res> {
  factory $FriendInfoCopyWith(
          FriendInfo value, $Res Function(FriendInfo) then) =
      _$FriendInfoCopyWithImpl<$Res, FriendInfo>;
  @useResult
  $Res call(
      {String id,
      String name,
      String account,
      String avatar,
      String gender,
      int age,
      String region,
      String? email,
      String signature,
      bool isFriend});
}

/// @nodoc
class _$FriendInfoCopyWithImpl<$Res, $Val extends FriendInfo>
    implements $FriendInfoCopyWith<$Res> {
  _$FriendInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? account = null,
    Object? avatar = null,
    Object? gender = null,
    Object? age = null,
    Object? region = null,
    Object? email = freezed,
    Object? signature = null,
    Object? isFriend = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      isFriend: null == isFriend
          ? _value.isFriend
          : isFriend // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendInfoImplCopyWith<$Res>
    implements $FriendInfoCopyWith<$Res> {
  factory _$$FriendInfoImplCopyWith(
          _$FriendInfoImpl value, $Res Function(_$FriendInfoImpl) then) =
      __$$FriendInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String account,
      String avatar,
      String gender,
      int age,
      String region,
      String? email,
      String signature,
      bool isFriend});
}

/// @nodoc
class __$$FriendInfoImplCopyWithImpl<$Res>
    extends _$FriendInfoCopyWithImpl<$Res, _$FriendInfoImpl>
    implements _$$FriendInfoImplCopyWith<$Res> {
  __$$FriendInfoImplCopyWithImpl(
      _$FriendInfoImpl _value, $Res Function(_$FriendInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of FriendInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? account = null,
    Object? avatar = null,
    Object? gender = null,
    Object? age = null,
    Object? region = null,
    Object? email = freezed,
    Object? signature = null,
    Object? isFriend = null,
  }) {
    return _then(_$FriendInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      isFriend: null == isFriend
          ? _value.isFriend
          : isFriend // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendInfoImpl implements _FriendInfo {
  const _$FriendInfoImpl(
      {required this.id,
      required this.name,
      required this.account,
      required this.avatar,
      required this.gender,
      this.age = 0,
      required this.region,
      this.email,
      this.signature = '',
      this.isFriend = false});

  factory _$FriendInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendInfoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String account;
  @override
  final String avatar;
  @override
  final String gender;
  @override
  @JsonKey()
  final int age;
  @override
  final String region;
  @override
  final String? email;
  @override
  @JsonKey()
  final String signature;
  @override
  @JsonKey()
  final bool isFriend;

  @override
  String toString() {
    return 'FriendInfo(id: $id, name: $name, account: $account, avatar: $avatar, gender: $gender, age: $age, region: $region, email: $email, signature: $signature, isFriend: $isFriend)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.isFriend, isFriend) ||
                other.isFriend == isFriend));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, account, avatar,
      gender, age, region, email, signature, isFriend);

  /// Create a copy of FriendInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendInfoImplCopyWith<_$FriendInfoImpl> get copyWith =>
      __$$FriendInfoImplCopyWithImpl<_$FriendInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendInfoImplToJson(
      this,
    );
  }
}

abstract class _FriendInfo implements FriendInfo {
  const factory _FriendInfo(
      {required final String id,
      required final String name,
      required final String account,
      required final String avatar,
      required final String gender,
      final int age,
      required final String region,
      final String? email,
      final String signature,
      final bool isFriend}) = _$FriendInfoImpl;

  factory _FriendInfo.fromJson(Map<String, dynamic> json) =
      _$FriendInfoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get account;
  @override
  String get avatar;
  @override
  String get gender;
  @override
  int get age;
  @override
  String get region;
  @override
  String? get email;
  @override
  String get signature;
  @override
  bool get isFriend;

  /// Create a copy of FriendInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendInfoImplCopyWith<_$FriendInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FriendGroup _$FriendGroupFromJson(Map<String, dynamic> json) {
  return _FriendGroup.fromJson(json);
}

/// @nodoc
mixin _$FriendGroup {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get createTime => throw _privateConstructorUsedError;
  int get updateTime => throw _privateConstructorUsedError;
  int get displayOrder => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;

  /// Serializes this FriendGroup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendGroupCopyWith<FriendGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendGroupCopyWith<$Res> {
  factory $FriendGroupCopyWith(
          FriendGroup value, $Res Function(FriendGroup) then) =
      _$FriendGroupCopyWithImpl<$Res, FriendGroup>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      int createTime,
      int updateTime,
      int displayOrder,
      String? icon});
}

/// @nodoc
class _$FriendGroupCopyWithImpl<$Res, $Val extends FriendGroup>
    implements $FriendGroupCopyWith<$Res> {
  _$FriendGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? createTime = null,
    Object? updateTime = null,
    Object? displayOrder = null,
    Object? icon = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createTime: null == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as int,
      updateTime: null == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as int,
      displayOrder: null == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendGroupImplCopyWith<$Res>
    implements $FriendGroupCopyWith<$Res> {
  factory _$$FriendGroupImplCopyWith(
          _$FriendGroupImpl value, $Res Function(_$FriendGroupImpl) then) =
      __$$FriendGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      int createTime,
      int updateTime,
      int displayOrder,
      String? icon});
}

/// @nodoc
class __$$FriendGroupImplCopyWithImpl<$Res>
    extends _$FriendGroupCopyWithImpl<$Res, _$FriendGroupImpl>
    implements _$$FriendGroupImplCopyWith<$Res> {
  __$$FriendGroupImplCopyWithImpl(
      _$FriendGroupImpl _value, $Res Function(_$FriendGroupImpl) _then)
      : super(_value, _then);

  /// Create a copy of FriendGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? createTime = null,
    Object? updateTime = null,
    Object? displayOrder = null,
    Object? icon = freezed,
  }) {
    return _then(_$FriendGroupImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createTime: null == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as int,
      updateTime: null == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as int,
      displayOrder: null == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendGroupImpl implements _FriendGroup {
  const _$FriendGroupImpl(
      {required this.id,
      required this.userId,
      required this.name,
      required this.createTime,
      required this.updateTime,
      this.displayOrder = 0,
      this.icon});

  factory _$FriendGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendGroupImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String name;
  @override
  final int createTime;
  @override
  final int updateTime;
  @override
  @JsonKey()
  final int displayOrder;
  @override
  final String? icon;

  @override
  String toString() {
    return 'FriendGroup(id: $id, userId: $userId, name: $name, createTime: $createTime, updateTime: $updateTime, displayOrder: $displayOrder, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createTime, createTime) ||
                other.createTime == createTime) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, name, createTime,
      updateTime, displayOrder, icon);

  /// Create a copy of FriendGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendGroupImplCopyWith<_$FriendGroupImpl> get copyWith =>
      __$$FriendGroupImplCopyWithImpl<_$FriendGroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendGroupImplToJson(
      this,
    );
  }
}

abstract class _FriendGroup implements FriendGroup {
  const factory _FriendGroup(
      {required final String id,
      required final String userId,
      required final String name,
      required final int createTime,
      required final int updateTime,
      final int displayOrder,
      final String? icon}) = _$FriendGroupImpl;

  factory _FriendGroup.fromJson(Map<String, dynamic> json) =
      _$FriendGroupImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get name;
  @override
  int get createTime;
  @override
  int get updateTime;
  @override
  int get displayOrder;
  @override
  String? get icon;

  /// Create a copy of FriendGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendGroupImplCopyWith<_$FriendGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FriendTag _$FriendTagFromJson(Map<String, dynamic> json) {
  return _FriendTag.fromJson(json);
}

/// @nodoc
mixin _$FriendTag {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get tagName => throw _privateConstructorUsedError;
  String get tagColor => throw _privateConstructorUsedError;
  int get createTime => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this FriendTag to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendTagCopyWith<FriendTag> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendTagCopyWith<$Res> {
  factory $FriendTagCopyWith(FriendTag value, $Res Function(FriendTag) then) =
      _$FriendTagCopyWithImpl<$Res, FriendTag>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String tagName,
      String tagColor,
      int createTime,
      String? icon,
      int sortOrder});
}

/// @nodoc
class _$FriendTagCopyWithImpl<$Res, $Val extends FriendTag>
    implements $FriendTagCopyWith<$Res> {
  _$FriendTagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? tagName = null,
    Object? tagColor = null,
    Object? createTime = null,
    Object? icon = freezed,
    Object? sortOrder = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      tagName: null == tagName
          ? _value.tagName
          : tagName // ignore: cast_nullable_to_non_nullable
              as String,
      tagColor: null == tagColor
          ? _value.tagColor
          : tagColor // ignore: cast_nullable_to_non_nullable
              as String,
      createTime: null == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as int,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendTagImplCopyWith<$Res>
    implements $FriendTagCopyWith<$Res> {
  factory _$$FriendTagImplCopyWith(
          _$FriendTagImpl value, $Res Function(_$FriendTagImpl) then) =
      __$$FriendTagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String tagName,
      String tagColor,
      int createTime,
      String? icon,
      int sortOrder});
}

/// @nodoc
class __$$FriendTagImplCopyWithImpl<$Res>
    extends _$FriendTagCopyWithImpl<$Res, _$FriendTagImpl>
    implements _$$FriendTagImplCopyWith<$Res> {
  __$$FriendTagImplCopyWithImpl(
      _$FriendTagImpl _value, $Res Function(_$FriendTagImpl) _then)
      : super(_value, _then);

  /// Create a copy of FriendTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? tagName = null,
    Object? tagColor = null,
    Object? createTime = null,
    Object? icon = freezed,
    Object? sortOrder = null,
  }) {
    return _then(_$FriendTagImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      tagName: null == tagName
          ? _value.tagName
          : tagName // ignore: cast_nullable_to_non_nullable
              as String,
      tagColor: null == tagColor
          ? _value.tagColor
          : tagColor // ignore: cast_nullable_to_non_nullable
              as String,
      createTime: null == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as int,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendTagImpl implements _FriendTag {
  const _$FriendTagImpl(
      {required this.id,
      required this.userId,
      required this.tagName,
      this.tagColor = '#000000',
      required this.createTime,
      this.icon,
      this.sortOrder = 0});

  factory _$FriendTagImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendTagImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String tagName;
  @override
  @JsonKey()
  final String tagColor;
  @override
  final int createTime;
  @override
  final String? icon;
  @override
  @JsonKey()
  final int sortOrder;

  @override
  String toString() {
    return 'FriendTag(id: $id, userId: $userId, tagName: $tagName, tagColor: $tagColor, createTime: $createTime, icon: $icon, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendTagImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.tagName, tagName) || other.tagName == tagName) &&
            (identical(other.tagColor, tagColor) ||
                other.tagColor == tagColor) &&
            (identical(other.createTime, createTime) ||
                other.createTime == createTime) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, tagName, tagColor, createTime, icon, sortOrder);

  /// Create a copy of FriendTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendTagImplCopyWith<_$FriendTagImpl> get copyWith =>
      __$$FriendTagImplCopyWithImpl<_$FriendTagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendTagImplToJson(
      this,
    );
  }
}

abstract class _FriendTag implements FriendTag {
  const factory _FriendTag(
      {required final String id,
      required final String userId,
      required final String tagName,
      final String tagColor,
      required final int createTime,
      final String? icon,
      final int sortOrder}) = _$FriendTagImpl;

  factory _FriendTag.fromJson(Map<String, dynamic> json) =
      _$FriendTagImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get tagName;
  @override
  String get tagColor;
  @override
  int get createTime;
  @override
  String? get icon;
  @override
  int get sortOrder;

  /// Create a copy of FriendTag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendTagImplCopyWith<_$FriendTagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FriendPrivacySettings _$FriendPrivacySettingsFromJson(
    Map<String, dynamic> json) {
  return _FriendPrivacySettings.fromJson(json);
}

/// @nodoc
mixin _$FriendPrivacySettings {
  String get userId => throw _privateConstructorUsedError;
  String get friendId => throw _privateConstructorUsedError;
  bool get canSeeMoments => throw _privateConstructorUsedError;
  bool get canSeeOnlineStatus => throw _privateConstructorUsedError;
  bool get canSeeLocation => throw _privateConstructorUsedError;
  bool get canSeeMutualFriends => throw _privateConstructorUsedError;
  String get permissionLevel => throw _privateConstructorUsedError;
  String get customSettings => throw _privateConstructorUsedError;

  /// Serializes this FriendPrivacySettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendPrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendPrivacySettingsCopyWith<FriendPrivacySettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendPrivacySettingsCopyWith<$Res> {
  factory $FriendPrivacySettingsCopyWith(FriendPrivacySettings value,
          $Res Function(FriendPrivacySettings) then) =
      _$FriendPrivacySettingsCopyWithImpl<$Res, FriendPrivacySettings>;
  @useResult
  $Res call(
      {String userId,
      String friendId,
      bool canSeeMoments,
      bool canSeeOnlineStatus,
      bool canSeeLocation,
      bool canSeeMutualFriends,
      String permissionLevel,
      String customSettings});
}

/// @nodoc
class _$FriendPrivacySettingsCopyWithImpl<$Res,
        $Val extends FriendPrivacySettings>
    implements $FriendPrivacySettingsCopyWith<$Res> {
  _$FriendPrivacySettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendPrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? friendId = null,
    Object? canSeeMoments = null,
    Object? canSeeOnlineStatus = null,
    Object? canSeeLocation = null,
    Object? canSeeMutualFriends = null,
    Object? permissionLevel = null,
    Object? customSettings = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      friendId: null == friendId
          ? _value.friendId
          : friendId // ignore: cast_nullable_to_non_nullable
              as String,
      canSeeMoments: null == canSeeMoments
          ? _value.canSeeMoments
          : canSeeMoments // ignore: cast_nullable_to_non_nullable
              as bool,
      canSeeOnlineStatus: null == canSeeOnlineStatus
          ? _value.canSeeOnlineStatus
          : canSeeOnlineStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      canSeeLocation: null == canSeeLocation
          ? _value.canSeeLocation
          : canSeeLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      canSeeMutualFriends: null == canSeeMutualFriends
          ? _value.canSeeMutualFriends
          : canSeeMutualFriends // ignore: cast_nullable_to_non_nullable
              as bool,
      permissionLevel: null == permissionLevel
          ? _value.permissionLevel
          : permissionLevel // ignore: cast_nullable_to_non_nullable
              as String,
      customSettings: null == customSettings
          ? _value.customSettings
          : customSettings // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendPrivacySettingsImplCopyWith<$Res>
    implements $FriendPrivacySettingsCopyWith<$Res> {
  factory _$$FriendPrivacySettingsImplCopyWith(
          _$FriendPrivacySettingsImpl value,
          $Res Function(_$FriendPrivacySettingsImpl) then) =
      __$$FriendPrivacySettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String friendId,
      bool canSeeMoments,
      bool canSeeOnlineStatus,
      bool canSeeLocation,
      bool canSeeMutualFriends,
      String permissionLevel,
      String customSettings});
}

/// @nodoc
class __$$FriendPrivacySettingsImplCopyWithImpl<$Res>
    extends _$FriendPrivacySettingsCopyWithImpl<$Res,
        _$FriendPrivacySettingsImpl>
    implements _$$FriendPrivacySettingsImplCopyWith<$Res> {
  __$$FriendPrivacySettingsImplCopyWithImpl(_$FriendPrivacySettingsImpl _value,
      $Res Function(_$FriendPrivacySettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FriendPrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? friendId = null,
    Object? canSeeMoments = null,
    Object? canSeeOnlineStatus = null,
    Object? canSeeLocation = null,
    Object? canSeeMutualFriends = null,
    Object? permissionLevel = null,
    Object? customSettings = null,
  }) {
    return _then(_$FriendPrivacySettingsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      friendId: null == friendId
          ? _value.friendId
          : friendId // ignore: cast_nullable_to_non_nullable
              as String,
      canSeeMoments: null == canSeeMoments
          ? _value.canSeeMoments
          : canSeeMoments // ignore: cast_nullable_to_non_nullable
              as bool,
      canSeeOnlineStatus: null == canSeeOnlineStatus
          ? _value.canSeeOnlineStatus
          : canSeeOnlineStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      canSeeLocation: null == canSeeLocation
          ? _value.canSeeLocation
          : canSeeLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      canSeeMutualFriends: null == canSeeMutualFriends
          ? _value.canSeeMutualFriends
          : canSeeMutualFriends // ignore: cast_nullable_to_non_nullable
              as bool,
      permissionLevel: null == permissionLevel
          ? _value.permissionLevel
          : permissionLevel // ignore: cast_nullable_to_non_nullable
              as String,
      customSettings: null == customSettings
          ? _value.customSettings
          : customSettings // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendPrivacySettingsImpl implements _FriendPrivacySettings {
  const _$FriendPrivacySettingsImpl(
      {required this.userId,
      required this.friendId,
      this.canSeeMoments = true,
      this.canSeeOnlineStatus = true,
      this.canSeeLocation = true,
      this.canSeeMutualFriends = true,
      this.permissionLevel = 'full_access',
      this.customSettings = '{}'});

  factory _$FriendPrivacySettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendPrivacySettingsImplFromJson(json);

  @override
  final String userId;
  @override
  final String friendId;
  @override
  @JsonKey()
  final bool canSeeMoments;
  @override
  @JsonKey()
  final bool canSeeOnlineStatus;
  @override
  @JsonKey()
  final bool canSeeLocation;
  @override
  @JsonKey()
  final bool canSeeMutualFriends;
  @override
  @JsonKey()
  final String permissionLevel;
  @override
  @JsonKey()
  final String customSettings;

  @override
  String toString() {
    return 'FriendPrivacySettings(userId: $userId, friendId: $friendId, canSeeMoments: $canSeeMoments, canSeeOnlineStatus: $canSeeOnlineStatus, canSeeLocation: $canSeeLocation, canSeeMutualFriends: $canSeeMutualFriends, permissionLevel: $permissionLevel, customSettings: $customSettings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendPrivacySettingsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.friendId, friendId) ||
                other.friendId == friendId) &&
            (identical(other.canSeeMoments, canSeeMoments) ||
                other.canSeeMoments == canSeeMoments) &&
            (identical(other.canSeeOnlineStatus, canSeeOnlineStatus) ||
                other.canSeeOnlineStatus == canSeeOnlineStatus) &&
            (identical(other.canSeeLocation, canSeeLocation) ||
                other.canSeeLocation == canSeeLocation) &&
            (identical(other.canSeeMutualFriends, canSeeMutualFriends) ||
                other.canSeeMutualFriends == canSeeMutualFriends) &&
            (identical(other.permissionLevel, permissionLevel) ||
                other.permissionLevel == permissionLevel) &&
            (identical(other.customSettings, customSettings) ||
                other.customSettings == customSettings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      friendId,
      canSeeMoments,
      canSeeOnlineStatus,
      canSeeLocation,
      canSeeMutualFriends,
      permissionLevel,
      customSettings);

  /// Create a copy of FriendPrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendPrivacySettingsImplCopyWith<_$FriendPrivacySettingsImpl>
      get copyWith => __$$FriendPrivacySettingsImplCopyWithImpl<
          _$FriendPrivacySettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendPrivacySettingsImplToJson(
      this,
    );
  }
}

abstract class _FriendPrivacySettings implements FriendPrivacySettings {
  const factory _FriendPrivacySettings(
      {required final String userId,
      required final String friendId,
      final bool canSeeMoments,
      final bool canSeeOnlineStatus,
      final bool canSeeLocation,
      final bool canSeeMutualFriends,
      final String permissionLevel,
      final String customSettings}) = _$FriendPrivacySettingsImpl;

  factory _FriendPrivacySettings.fromJson(Map<String, dynamic> json) =
      _$FriendPrivacySettingsImpl.fromJson;

  @override
  String get userId;
  @override
  String get friendId;
  @override
  bool get canSeeMoments;
  @override
  bool get canSeeOnlineStatus;
  @override
  bool get canSeeLocation;
  @override
  bool get canSeeMutualFriends;
  @override
  String get permissionLevel;
  @override
  String get customSettings;

  /// Create a copy of FriendPrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendPrivacySettingsImplCopyWith<_$FriendPrivacySettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InteractionStats _$InteractionStatsFromJson(Map<String, dynamic> json) {
  return _InteractionStats.fromJson(json);
}

/// @nodoc
mixin _$InteractionStats {
  double get score => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  int get lastInteraction => throw _privateConstructorUsedError;

  /// Serializes this InteractionStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InteractionStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InteractionStatsCopyWith<InteractionStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InteractionStatsCopyWith<$Res> {
  factory $InteractionStatsCopyWith(
          InteractionStats value, $Res Function(InteractionStats) then) =
      _$InteractionStatsCopyWithImpl<$Res, InteractionStats>;
  @useResult
  $Res call({double score, int count, int lastInteraction});
}

/// @nodoc
class _$InteractionStatsCopyWithImpl<$Res, $Val extends InteractionStats>
    implements $InteractionStatsCopyWith<$Res> {
  _$InteractionStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InteractionStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? count = null,
    Object? lastInteraction = null,
  }) {
    return _then(_value.copyWith(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      lastInteraction: null == lastInteraction
          ? _value.lastInteraction
          : lastInteraction // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InteractionStatsImplCopyWith<$Res>
    implements $InteractionStatsCopyWith<$Res> {
  factory _$$InteractionStatsImplCopyWith(_$InteractionStatsImpl value,
          $Res Function(_$InteractionStatsImpl) then) =
      __$$InteractionStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double score, int count, int lastInteraction});
}

/// @nodoc
class __$$InteractionStatsImplCopyWithImpl<$Res>
    extends _$InteractionStatsCopyWithImpl<$Res, _$InteractionStatsImpl>
    implements _$$InteractionStatsImplCopyWith<$Res> {
  __$$InteractionStatsImplCopyWithImpl(_$InteractionStatsImpl _value,
      $Res Function(_$InteractionStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of InteractionStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? count = null,
    Object? lastInteraction = null,
  }) {
    return _then(_$InteractionStatsImpl(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      lastInteraction: null == lastInteraction
          ? _value.lastInteraction
          : lastInteraction // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InteractionStatsImpl implements _InteractionStats {
  const _$InteractionStatsImpl(
      {required this.score,
      required this.count,
      required this.lastInteraction});

  factory _$InteractionStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$InteractionStatsImplFromJson(json);

  @override
  final double score;
  @override
  final int count;
  @override
  final int lastInteraction;

  @override
  String toString() {
    return 'InteractionStats(score: $score, count: $count, lastInteraction: $lastInteraction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InteractionStatsImpl &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.lastInteraction, lastInteraction) ||
                other.lastInteraction == lastInteraction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, score, count, lastInteraction);

  /// Create a copy of InteractionStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InteractionStatsImplCopyWith<_$InteractionStatsImpl> get copyWith =>
      __$$InteractionStatsImplCopyWithImpl<_$InteractionStatsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InteractionStatsImplToJson(
      this,
    );
  }
}

abstract class _InteractionStats implements InteractionStats {
  const factory _InteractionStats(
      {required final double score,
      required final int count,
      required final int lastInteraction}) = _$InteractionStatsImpl;

  factory _InteractionStats.fromJson(Map<String, dynamic> json) =
      _$InteractionStatsImpl.fromJson;

  @override
  double get score;
  @override
  int get count;
  @override
  int get lastInteraction;

  /// Create a copy of InteractionStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InteractionStatsImplCopyWith<_$InteractionStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
