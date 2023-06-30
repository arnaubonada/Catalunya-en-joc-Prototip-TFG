import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prototip_tfg/models/models.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(const PlayerState()) {
    on<OnAddMoneyEvent>((event, emit) =>
        emit(state.copyWith(money: state.money + event.money)));
    on<OnAddDiamondEvent>((event, emit) =>
        emit(state.copyWith(diamonds: state.diamonds + event.diamond)));
    on<OnAddStarEvent>(
        (event, emit) => emit(state.copyWith(stars: state.stars + event.star)));
    on<OnAddLevelEvent>((event, emit) {
      emit(state.copyWith(level: state.level + event.level));
      add(const OnMissionCompletedEvent(3));
    });
    on<OnMissionCompletedEvent>((event, emit) {
      List<Mission> missionCopy = List.from(state.missions);
      missionCopy[event.mission] =
          state.missions[event.mission].copyWith(completed: true);
      emit(state.copyWith(missions: missionCopy));
    });
    on<OnBuyItemEvent>((event, emit) {
      emit(state.copyWith(items: [...state.items, event.item]));
      add(const OnMissionCompletedEvent(1));
    });
    on<OnVisitLocationEvent>((event, emit) {
      emit(state.copyWith(counter: state.counter + 1));
      if (state.counter == 3) {
        add(const OnMissionCompletedEvent(0));
      }
    });
    on<OnChangeAvatarEvent>((event, emit) {
      emit(state.copyWith(avatar: event.avatar));
      add(const OnMissionCompletedEvent(2));
    });
  }
}
