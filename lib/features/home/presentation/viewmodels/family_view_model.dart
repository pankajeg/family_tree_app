import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/presentation/viewmodels/base_view_model.dart';
import '../../data/models/family_member.dart';
import '../../data/repositories/family_repository_impl.dart';
import '../../domain/repositories/family_repository.dart';
import '../../domain/usecases/get_family_members_use_case.dart';

final familyRepositoryProvider = Provider<FamilyRepository>(
  (ref) => FamilyRepositoryImpl(),
);

final getFamilyMembersUseCaseProvider = Provider<GetFamilyMembersUseCase>(
  (ref) => GetFamilyMembersUseCase(ref.read(familyRepositoryProvider)),
);

final familyViewModelProvider =
    AsyncNotifierProvider<FamilyViewModel, List<FamilyMember>>(
      FamilyViewModel.new,
    );

class FamilyViewModel extends BaseViewModel<List<FamilyMember>> {
  @override
  Future<List<FamilyMember>> build() async {
    return ref.read(getFamilyMembersUseCaseProvider).call();
  }

  Future<void> refresh() async {
    await execute(() => ref.read(getFamilyMembersUseCaseProvider).call());
  }
}
