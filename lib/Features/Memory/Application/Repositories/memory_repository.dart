import 'package:app_26/Features/Memory/Application/Services/memory_service.dart';
import 'package:app_26/Features/Memory/Domain/Entities/memory_create_entity.dart';
import 'package:app_26/Features/Memory/Domain/Repositories/memory_repository.dart';

class IMemoryRepository extends MemoryRepository {
  final MemoryService service;

  IMemoryRepository(this.service);

  @override
  Future<void> createMemory(MemoryCreateEntity entity, String key) async {
    try {
      service.createMemory(entity, key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool?> validatedKey(String key) async {
    try {
      return await service.validateKey(key);
    } catch (e) {
      rethrow;
    }
  }
}
