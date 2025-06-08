/// Interface for database operations
abstract class DatabaseService {
  /// Initialize the database
  Future<void> initialize();

  /// Close the database connection
  Future<void> close();

  /// Execute a transaction
  Future<T> transaction<T>(Future<T> Function() action);

  /// Insert data into a table
  Future<int> insert(String table, Map<String, dynamic> data);

  /// Query data from a table
  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  });

  /// Update data in a table
  Future<int> update(
    String table,
    Map<String, dynamic> data, {
    String? where,
    List<dynamic>? whereArgs,
  });

  /// Delete data from a table
  Future<int> delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  });

  /// Execute a raw SQL query
  Future<List<Map<String, dynamic>>> rawQuery(
    String sql, [
    List<dynamic>? arguments,
  ]);

  /// Execute a raw SQL command
  Future<int> rawExecute(
    String sql, [
    List<dynamic>? arguments,
  ]);

  /// Get the database version
  Future<int> getVersion();

  /// Check if a table exists
  Future<bool> tableExists(String tableName);
}
