class Mission {
  final int id;
  final String mission;
  final bool completed;

  const Mission(
      {required this.id, required this.mission, this.completed = false});

  Mission copyWith({int? id, String? mission, bool? completed}) => Mission(
      id: id ?? this.id,
      mission: mission ?? this.mission,
      completed: completed ?? this.completed);
}
