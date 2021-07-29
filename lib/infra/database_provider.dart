import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// final databaseProvider = ChangeNotifierProvider((ref) => AppDatabase());

class DatabaseProvider {

  DatabaseProvider._() {
    initDatabase();
  }
  static DatabaseProvider? _instance;

  factory DatabaseProvider() {
    if (_instance == null) {
      _instance = DatabaseProvider._();
    }
    return _instance!;
  }

  static Database? _database = null;
  Future<Database>  get database async {
    if(_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    print("DB Creating...");
    final databasesPath = join(await getDatabasesPath(), "todo_app_data.db");
    return await openDatabase(
      databasesPath,
      version: 1,
      onCreate: (Database db, int version) async {
        print('DB created!!');
        await db.execute('CREATE TABLE IF NOT EXISTS Task(id String PRIMARY KEY, title TEXT, task TEXT, completed INTEGER)');
      },
    );
  }
}
