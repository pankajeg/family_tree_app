import '../../domain/repositories/family_repository.dart';
import '../models/family_member.dart';

class FamilyRepositoryImpl implements FamilyRepository {
  @override
  Future<List<FamilyMember>> getFamilyMembers() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    return const <FamilyMember>[
      FamilyMember(id: '1', name: 'Alex Johnson', relationship: 'Grandparent'),
      FamilyMember(
        id: '2',
        name: 'Michael Johnson',
        relationship: 'Parent',
        parentId: '1',
      ),
      FamilyMember(
        id: '3',
        name: 'Sophia Johnson',
        relationship: 'Child',
        parentId: '2',
      ),
      FamilyMember(
        id: '4',
        name: 'Liam Johnson',
        relationship: 'Child',
        parentId: '2',
      ),
    ];
  }
}
