import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: 40,),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Change Password'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete Account'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}
