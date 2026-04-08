import '../../data/models/family_member.dart';

abstract class FamilyRepository {
  Future<List<FamilyMember>> getFamilyMembers();
}
