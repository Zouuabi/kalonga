abstract interface class Storage {
  Future<int?> read({required String key});
  Future<String?> readString({required String key});

  Future<void> writeInt({required String key, required int value});
  Future<void> writeString({required String key, required String value});

  Future<void> delete({required String key});

  Future<void> clear();
}

class StorageException implements Exception {
  const StorageException(this.error);

  final Object error;
}
