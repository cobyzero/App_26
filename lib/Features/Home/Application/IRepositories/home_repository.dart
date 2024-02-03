import 'package:app_26/Features/Home/Application/Services/home_services.dart';
import 'package:app_26/Features/Home/Domain/Entities/memory_entity.dart';
import 'package:app_26/Features/Home/Domain/Repositories/home_repository.dart';

class IHomeRepository extends HomeRepository {
  final HomeServices services;

  IHomeRepository(this.services);
  @override
  Stream<Iterable<MemoryEntity>> getMemorys(String userId) {
    final data = services.getMemorys(userId);
    try {
      return data.map(
        (event) {
          return event.docs.map(
            (e) {
              return MemoryEntity.fromJson(
                e.data(),
              );
            },
          );
        },
      );
    } catch (e) {
      throw Exception("Error al mapear memorys");
    }
  }

  @override
  Future<void> unlockMemory(String userId, int keys, String memoryId) async {
    await services.unlockMemory(userId, keys, memoryId);
  }
}
