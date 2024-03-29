part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}
class GetNotificationState extends NotificationState {
  final List<Notifications> beers;
  GetNotificationState(this.beers);
}
class GetNotificationTestState extends NotificationState {}
class GetSingleOrderState extends NotificationState {}
class ChangeLoadingState extends NotificationState {}
