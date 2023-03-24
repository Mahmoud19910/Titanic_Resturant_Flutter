// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UsersInfoDao? _usersDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 3,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UsersInfo` (`uid` TEXT NOT NULL, `name` TEXT, `pass` TEXT, `phone` TEXT, `photo` BLOB, PRIMARY KEY (`uid`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UsersInfoDao get usersDao {
    return _usersDaoInstance ??= _$UsersInfoDao(database, changeListener);
  }
}

class _$UsersInfoDao extends UsersInfoDao {
  _$UsersInfoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _usersInfoInsertionAdapter = InsertionAdapter(
            database,
            'UsersInfo',
            (UsersInfo item) => <String, Object?>{
                  'uid': item.uid,
                  'name': item.name,
                  'pass': item.pass,
                  'phone': item.phone,
                  'photo': item.photo
                },
            changeListener),
        _usersInfoUpdateAdapter = UpdateAdapter(
            database,
            'UsersInfo',
            ['uid'],
            (UsersInfo item) => <String, Object?>{
                  'uid': item.uid,
                  'name': item.name,
                  'pass': item.pass,
                  'phone': item.phone,
                  'photo': item.photo
                },
            changeListener),
        _usersInfoDeletionAdapter = DeletionAdapter(
            database,
            'UsersInfo',
            ['uid'],
            (UsersInfo item) => <String, Object?>{
                  'uid': item.uid,
                  'name': item.name,
                  'pass': item.pass,
                  'phone': item.phone,
                  'photo': item.photo
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UsersInfo> _usersInfoInsertionAdapter;

  final UpdateAdapter<UsersInfo> _usersInfoUpdateAdapter;

  final DeletionAdapter<UsersInfo> _usersInfoDeletionAdapter;

  @override
  Stream<List<UsersInfo>> getAllUsers() {
    return _queryAdapter.queryListStream('SELECT * FROM UsersInfo',
        mapper: (Map<String, Object?> row) => UsersInfo(
            uid: row['uid'] as String,
            name: row['name'] as String?,
            pass: row['pass'] as String?,
            phone: row['phone'] as String?,
            photo: row['photo'] as Uint8List?),
        queryableName: 'UsersInfo',
        isView: false);
  }

  @override
  Future<UsersInfo?> getUsersById(String uid) async {
    return _queryAdapter.query('SELECT * FROM UsersInfo WHERE uid = ?1',
        mapper: (Map<String, Object?> row) => UsersInfo(
            uid: row['uid'] as String,
            name: row['name'] as String?,
            pass: row['pass'] as String?,
            phone: row['phone'] as String?,
            photo: row['photo'] as Uint8List?),
        arguments: [uid]);
  }

  @override
  Future<UsersInfo?> getUsersByPhoneNumber(String phone) async {
    return _queryAdapter.query('SELECT * FROM UsersInfo WHERE phone = ?1',
        mapper: (Map<String, Object?> row) => UsersInfo(
            uid: row['uid'] as String,
            name: row['name'] as String?,
            pass: row['pass'] as String?,
            phone: row['phone'] as String?,
            photo: row['photo'] as Uint8List?),
        arguments: [phone]);
  }

  @override
  Future<void> deleteUsersById(String uid) async {
    await _queryAdapter.queryNoReturn('DELETE FROM UsersInfo WHERE uid = ?1',
        arguments: [uid]);
  }

  @override
  Future<void> insertUsers(UsersInfo user) async {
    await _usersInfoInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUsers(UsersInfo usersInfo) async {
    await _usersInfoUpdateAdapter.update(usersInfo, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUsers(UsersInfo user) async {
    await _usersInfoDeletionAdapter.delete(user);
  }
}
