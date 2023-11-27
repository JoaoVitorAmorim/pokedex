class Pokemon {
  final int? id;
  final String name;
  final String? url;
  final String? frontDefault;

  Pokemon({
    required this.name,
    this.id,
    this.url,
    this.frontDefault,
  });
}
