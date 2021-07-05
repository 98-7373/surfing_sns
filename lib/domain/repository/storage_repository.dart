abstract class StorageRepository {
  Future<void> savePersistenceStorage(String key, String value);
  Future<String> loadPersistenceStorage(String key);
  Future<String> loadPersistenceUser(String key, String value);
  Future<bool> isExistKey(String key);
  Future<void> remove(String key);
}
const String key_couple_id = 'couple_id';