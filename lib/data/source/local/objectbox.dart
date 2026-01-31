import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../../objectbox.g.dart';

class ObjectBox {
  static ObjectBox? _instance;
  static Future<ObjectBox>? _creating;
  late final Store store;
  Admin? admin;
  ObjectBox._create(this.store) {
    if (Admin.isAvailable()) {
      admin = Admin(store);
    }
  }

  static Future<ObjectBox> create() async {
    if (_instance != null) return _instance!;
    if (_creating != null) return await _creating!;

    _creating = () async {
      final docsDir = await getApplicationDocumentsDirectory();
      final store = await openStore(directory: p.join(docsDir.path, "obx-db"));
      _instance = ObjectBox._create(store);
      return _instance!;
    }();

    try {
      return await _creating!;
    } finally {
      _creating = null;
    }
  }

  static Future<Store> getStore() async {
    if (_instance == null) {
      await create();
    }
    return _instance!.store;
  }
}
