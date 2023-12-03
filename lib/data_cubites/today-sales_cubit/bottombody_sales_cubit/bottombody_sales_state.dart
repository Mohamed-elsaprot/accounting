
import '../../../domain_models/fatorah_model/fatorah_item_model/fatorah_item.dart';

abstract class FatorahItemsState {
 const FatorahItemsState();
}

class FatorahItemsInitial extends FatorahItemsState{}

class ChangeFatorahItemsList extends FatorahItemsState{
 const ChangeFatorahItemsList({required this.itemsList});
 final List<FatorahModelItem> itemsList;
}