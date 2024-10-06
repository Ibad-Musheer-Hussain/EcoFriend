import 'package:hive/hive.dart';

class JsonStorage {
  final Box _box;

  JsonStorage(this._box);

  Future<void> storeJsonData(Map<dynamic, dynamic> jsonData) async {
    await _box.put('jsonDataKey', jsonData);
  }

  Map<dynamic, dynamic> getJsonData() {
    return _box.get('jsonDataKey');
  }

  Future<void> clearData() async {
    await _box.clear();
  }
}
