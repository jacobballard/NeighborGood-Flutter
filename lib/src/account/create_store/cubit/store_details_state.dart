part of 'store_details_cubit.dart';

class StoreDetailsState extends Equatable {
  final StoreTitle title;
  final StoreDescription description;
  final String instagram;
  final String tiktok;
  final String facebook;
  final FormzStatus status;

  const StoreDetailsState({
    this.title = const StoreTitle.pure(),
    this.description = const StoreDescription.pure(),
    this.instagram = "",
    this.tiktok = "",
    this.facebook = "",
    this.status = FormzStatus.pure,
  });

  StoreDetailsState copyWith({
    StoreTitle? title,
    StoreDescription? description,
    String? instagram,
    String? tiktok,
    String? facebook,
    FormzStatus? status,
  }) {
    return StoreDetailsState(
      title: title ?? this.title,
      description: description ?? this.description,
      instagram: instagram ?? this.instagram,
      tiktok: tiktok ?? this.tiktok,
      facebook: facebook ?? this.facebook,
      status: status ?? this.status,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [title, description, instagram, tiktok, facebook, status];
}
