part of 'player_bloc.dart';

class PlayerState extends Equatable {
  final int money;
  final int stars;
  final int diamonds;
  final int avatar;
  final int level;
  final int counter;
  final List<Mission> missions;
  final List<Item> items;

  const PlayerState(
      {this.money = 0,
      this.stars = 0,
      this.diamonds = 0,
      this.avatar = 1,
      this.level = 1,
      this.counter = 0,
      this.missions = const [
        Mission(id: 1, mission: 'Visita 3 ubicacions'),
        Mission(id: 2, mission: 'Compra un objecte'),
        Mission(id: 3, mission: 'Canvia el teu avatar'),
        Mission(id: 4, mission: 'Puja de nivell')
      ],
      this.items = const [Item(image: 1, price: 5, property: true)]});

  PlayerState copyWith(
          {int? money,
          int? stars,
          int? diamonds,
          int? avatar,
          int? level,
          int? counter,
          List<Mission>? missions,
          List<Item>? items}) =>
      PlayerState(
          money: money ?? this.money,
          stars: stars ?? this.stars,
          diamonds: diamonds ?? this.diamonds,
          avatar: avatar ?? this.avatar,
          level: level ?? this.level,
          missions: missions ?? this.missions,
          counter: counter ?? this.counter,
          items: items ?? this.items);

  @override
  List<Object> get props =>
      [money, stars, diamonds, avatar, level, counter, missions, items];
}
