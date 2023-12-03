abstract class AccountingState{
const  AccountingState();
}

class AccountingInitial extends AccountingState{
 const AccountingInitial();
}

class Gard extends AccountingState{}
class ExpensesSearch extends AccountingState{}
class DeptSearch extends AccountingState{}
class ClientOrdersSearch extends AccountingState{}
class DeleteFatorah extends AccountingState{}
class ChangeFatorah extends AccountingState{}


