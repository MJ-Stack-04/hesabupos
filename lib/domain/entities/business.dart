
class Business {
  final String id;
  final String name;
  final String? industry;

  Business({
    required this.id,
    required this.name,
    this.industry,
  });

  Business copyWith({
    String? id,
    String? name,
    String? industry,
  }) {
    return Business(
      id: id ?? this.id,
      name: name ?? this.name,
      industry: industry ?? this.industry,
    );
  }
}