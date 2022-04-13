import 'package:mine_calculator/features/domain/entities/slot.dart';
import 'package:mine_calculator/features/domain/entities/tonage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static final Db instance = Db._init();

  static Database? _database;

  Db._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('mine_calculator.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const numType = 'REAL NOT NULL';
    const intType = 'INTEGER NOT NULL';
    // const boolType = 'BOOLEAN NOT NULL';

    await db.execute(
      '''
      CREATE TABLE $tableSlot ( 
        ${SlotFields.id} $idType, 
        ${SlotFields.type} $textType,
        ${SlotFields.title} $textType,
        ${SlotFields.createAt} $textType
        )
      ''',
    );

    await db.execute(
      '''
      CREATE TABLE $tableTonage ( 
        ${TonageFields.id} $idType, 
        ${TonageFields.idType} $intType,
        ${TonageFields.dateTime} $textType,
        ${TonageFields.dum} $numType,
        ${TonageFields.grade} $numType,
        ${TonageFields.tonage} $numType
        )
      ''',
    );
  }

  //* Slot Section
  Future<Slot> createSlot(Slot slot) async {
    final db = await instance.database;

    final id = await db.insert(tableSlot, slot.toJson());
    return slot.copyWith(id: id);
  }

  Future<Slot> findOneSlot(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableSlot,
      columns: SlotFields.values,
      where: '${SlotFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Slot.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Slot>> findAllSlot(String type) async {
    final db = await instance.database;
    const orderBy = '${SlotFields.createAt} DESC';
    final result = await db.query(
      tableSlot,
      orderBy: orderBy,
      where: '${SlotFields.type} = ?',
      whereArgs: [type],
    );
    return result.map((json) => Slot.fromJson(json)).toList();
  }

  Future<int> updateSlots(Slot slot) async {
    final db = await instance.database;

    return db.update(
      tableSlot,
      slot.toJson(),
      where: '${SlotFields.id} = ?',
      whereArgs: [slot.id],
    );
  }

  Future<int> deleteSlots(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableSlot,
      where: '${SlotFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  // * Tonage Section
  Future<Tonage> createTonage(Tonage tonage) async {
    final db = await instance.database;

    final id = await db.insert(tableTonage, tonage.toJson());
    return tonage.copyWith(id: id);
  }

  Future<List<Tonage>> findAllTonage(int idType) async {
    final db = await instance.database;
    const orderBy = '${TonageFields.dateTime} DESC';
    final result = await db.query(
      tableTonage,
      orderBy: orderBy,
      where: '${TonageFields.idType} = ?',
      whereArgs: [idType],
    );
    return result.map((json) => Tonage.fromJson(json)).toList();
  }

  Future<int> updateTonage(Tonage tonage) async {
    final db = await instance.database;

    return db.update(
      tableTonage,
      tonage.toJson(),
      where: '${TonageFields.id} = ?',
      whereArgs: [tonage.id],
    );
  }

  Future<int> deleteTonage(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableTonage,
      where: '${TonageFields.id} = ?',
      whereArgs: [id],
    );
  }
}
