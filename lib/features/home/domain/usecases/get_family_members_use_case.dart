import '../../data/models/family_member.dart';
import '../repositories/family_repository.dart';

class GetFamilyMembersUseCase {
  const GetFamilyMembersUseCase(this._repository);

  final FamilyRepository _repository;

  Future<List<FamilyMember>> call() {
    return _repository.getFamilyMembers();
  }
}
