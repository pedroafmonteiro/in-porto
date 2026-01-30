import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../../objectbox.g.dart';

class ObjectBox {
  static ObjectBox? _instance;
  late final Store store;

  ObjectBox._create(this.store);

  static Future<ObjectBox> create() async {
    if (_instance != null) return _instance!;
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "obx-db"));
    _instance = ObjectBox._create(store);
    return _instance!;
  }

  static Future<Store> getStore() async {
    if (_instance == null) {
      await create();
    }
    return _instance!.store;
  }
}
