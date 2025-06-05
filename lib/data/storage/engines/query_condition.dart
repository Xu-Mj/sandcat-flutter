/// 查询操作符
enum QueryOperator {
  /// 等于
  equal,

  /// 不等于
  notEqual,

  /// 大于
  greaterThan,

  /// 小于
  lessThan,

  /// 大于等于
  greaterThanOrEqual,

  /// 小于等于
  lessThanOrEqual,

  /// 包含
  contains,

  /// 开头为
  startsWith,

  /// 结尾为
  endsWith,

  /// 在列表中
  inList,

  /// 不在列表中
  notInList,

  /// 为空
  isNull,

  /// 不为空
  isNotNull,
}

/// 查询条件
/// 用于构建存储引擎的查询条件
class QueryCondition {
  /// 字段名
  final String? field;

  /// 操作符
  final String? operator;

  /// 值
  final dynamic value;

  /// 子条件
  final List<QueryCondition>? conditions;

  /// 逻辑操作符
  final String? logicalOperator;

  /// 创建查询条件
  const QueryCondition(
    this.field,
    this.operator,
    this.value, {
    this.conditions,
    this.logicalOperator,
  });

  /// 使用枚举创建查询条件
  QueryCondition.fromOperator(
    this.field,
    QueryOperator op,
    this.value, {
    this.conditions,
    this.logicalOperator,
  }) : operator = _operatorToString(op);

  /// 创建空的查询条件
  static QueryCondition empty() {
    return const QueryCondition(null, null, null);
  }

  /// 将枚举操作符转换为字符串
  static String _operatorToString(QueryOperator op) {
    switch (op) {
      case QueryOperator.equal:
        return '=';
      case QueryOperator.notEqual:
        return '!=';
      case QueryOperator.greaterThan:
        return '>';
      case QueryOperator.lessThan:
        return '<';
      case QueryOperator.greaterThanOrEqual:
        return '>=';
      case QueryOperator.lessThanOrEqual:
        return '<=';
      case QueryOperator.contains:
        return 'LIKE';
      case QueryOperator.startsWith:
        return 'LIKE';
      case QueryOperator.endsWith:
        return 'LIKE';
      case QueryOperator.inList:
        return 'IN';
      case QueryOperator.notInList:
        return 'NOT IN';
      case QueryOperator.isNull:
        return 'IS NULL';
      case QueryOperator.isNotNull:
        return 'IS NOT NULL';
    }
  }

  /// 创建等于条件
  static QueryCondition equals(String field, dynamic value) {
    return QueryCondition(field, '=', value);
  }

  /// 创建不等于条件
  static QueryCondition notEquals(String field, dynamic value) {
    return QueryCondition(field, '!=', value);
  }

  /// 创建大于条件
  static QueryCondition greaterThan(String field, dynamic value) {
    return QueryCondition(field, '>', value);
  }

  /// 创建小于条件
  static QueryCondition lessThan(String field, dynamic value) {
    return QueryCondition(field, '<', value);
  }

  /// 创建大于等于条件
  static QueryCondition greaterThanOrEquals(String field, dynamic value) {
    return QueryCondition(field, '>=', value);
  }

  /// 创建小于等于条件
  static QueryCondition lessThanOrEquals(String field, dynamic value) {
    return QueryCondition(field, '<=', value);
  }

  /// 创建包含条件
  static QueryCondition contains(String field, String value) {
    return QueryCondition(field, 'LIKE', '%$value%');
  }

  /// 创建开头为条件
  static QueryCondition startsWith(String field, String value) {
    return QueryCondition(field, 'LIKE', '$value%');
  }

  /// 创建结尾为条件
  static QueryCondition endsWith(String field, String value) {
    return QueryCondition(field, 'LIKE', '%$value');
  }

  /// 创建在列表中条件
  static QueryCondition inList(String field, List<dynamic> values) {
    return QueryCondition(field, 'IN', values);
  }

  /// 创建AND条件
  static QueryCondition and(List<QueryCondition> conditions) {
    return QueryCondition(
      null,
      null,
      null,
      conditions: conditions,
      logicalOperator: 'AND',
    );
  }

  /// 创建OR条件
  static QueryCondition or(List<QueryCondition> conditions) {
    return QueryCondition(
      null,
      null,
      null,
      conditions: conditions,
      logicalOperator: 'OR',
    );
  }

  @override
  String toString() {
    if (conditions != null && conditions!.isNotEmpty) {
      final conditionsStr = conditions!
          .map((c) => c.toString())
          .join(logicalOperator == 'AND' ? ' AND ' : ' OR ');
      return '($conditionsStr)';
    } else if (field != null && operator != null) {
      return '$field $operator $value';
    } else {
      return 'Empty Condition';
    }
  }
}
