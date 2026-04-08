class FamilyMember {
  const FamilyMember({
    required this.id,
    required this.name,
    required this.relationship,
    this.parentId,
  });

  final String id;
  final String name;
  final String relationship;
  final String? parentId;
}
