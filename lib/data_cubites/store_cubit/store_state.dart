abstract class StoreState {
 const StoreState();
}

class StoreInitial extends StoreState{
 const StoreInitial();
}

class ChangeProductsCount extends StoreState{}

class UpdateSearchList extends StoreState{}

class AddNewProduct extends StoreState{}

class DeleteProduct extends StoreState{}

class UpdateProduct extends StoreState{}
