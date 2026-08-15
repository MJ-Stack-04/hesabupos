
class Branch {
  final String id;
  final String name;
  final String? location;
  final String? description;
  final bool? isActive;

  Branch({
    required this.id,
    required this.name,
    this.location,
    this.description,
    this.isActive,
  });

  Branch copyWith({
    String? id,
    String? name,
    String? location,
    String? description,
    bool? isActive,
  }) {
    return Branch(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }
}