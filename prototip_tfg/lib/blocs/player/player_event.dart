part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class OnAddMoneyEvent extends PlayerEvent {
  final int money;
  const OnAddMoneyEvent(this.money);
}

class OnAddDiamondEvent extends PlayerEvent {
  final int diamond;
  const OnAddDiamondEvent(this.diamond);
}

class OnAddLevelEvent extends PlayerEvent {
  final int level;
  const OnAddLevelEvent(this.level);
}

class OnAddStarEvent extends PlayerEvent {
  final int star;
  const OnAddStarEvent(this.star);
}

class OnBuyItemEvent extends PlayerEvent {
  final Item item;
  const OnBuyItemEvent(this.item);
}

class OnMissionCompletedEvent extends PlayerEvent {
  final int mission;
  const OnMissionCompletedEvent(this.mission);
}

class OnVisitLocationEvent extends PlayerEvent {}

class OnChangeAvatarEvent extends PlayerEvent {
  final int avatar;
  const OnChangeAvatarEvent(this.avatar);
}
