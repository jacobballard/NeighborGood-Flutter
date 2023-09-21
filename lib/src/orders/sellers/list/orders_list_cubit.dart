import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orders_list_state.dart';

class SellersOrdersListCubit extends Cubit<SellersOrdersListState> {
  SellersOrdersListCubit() : super(const SellersOrdersListState());
}
