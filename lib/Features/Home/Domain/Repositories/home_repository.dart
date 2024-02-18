import 'package:app_26/Features/Home/Domain/Entities/memory_entity.dart';

abstract class HomeRepository {
  Stream<Iterable<MemoryEntity>> getMemorys(String userId);
  Future<void> unlockMemory(String userId, int keys, String memoryId);
}
