import 'package:app_26/Features/Memory/Domain/Entities/memory_create_entity.dart';

abstract class MemoryRepository {
  Future<void> createMemory(MemoryCreateEntity entity, String key);
  Future<bool?> validatedKey(String key);
}
