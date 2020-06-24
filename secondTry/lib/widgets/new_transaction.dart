import 'package:flutter/material.dart';
class NewTransaction extends StatefulWidget {
    final Function addTransaction;
    NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
    final titileController = TextEditingController();

    final amountController = TextEditingController();

    void _submitData(){
      final enterTitle = titileController.text;
      final enterAmount = double.parse(amountController.text);
      if(enterAmount <=0 || enterTitle.isEmpty ){
        return;
      }

       widget.addTransaction(
      enterTitle,
      enterAmount
      );
      Navigator.of(context).pop();
    } 

     @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                  decoration: InputDecoration(labelText: 'Title',),
                  controller: titileController, 
                   onSubmitted: (val) =>_submitData(),
                  ), 
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) =>_submitData(),
                    
                    ), 
                  
                   FlatButton(child: Text('Add transaction'),
                   onPressed: _submitData
                   )],
              ),
            ),
          );
  }
}