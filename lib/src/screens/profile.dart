import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // TODO: Load user profile data from backend and populate the text controllers
    _nameController.text = 'John Doe';
    _emailController.text = 'johndoe@example.com';
    _phoneController.text = '555-555-5555';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  void _saveChanges() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    if (_validateChanges(name, email, phone)) {
      // TODO: Make networking calls to update user profile on backend
      // ...
      setState(() {
        _isEditing = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid input. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  bool _validateChanges(String name, String email, String phone) {
    // TODO: Add custom validation rules as needed
    return name.isNotEmpty && email.isNotEmpty && phone.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      controller: _nameController,
      decoration: InputDecoration(labelText: 'Name'),
      enabled: _isEditing,
    );
    final emailField = TextFormField(
      controller: _emailController,
      decoration: InputDecoration(labelText: 'Email'),
      enabled: _isEditing,
    );
    final phoneField = TextFormField(
      controller: _phoneController,
      decoration: InputDecoration(labelText: 'Phone'),
      enabled: _isEditing,
    );

    final header = ListTile(
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(
          'https://example.com/profile_picture.jpg',
        ),
      ),
      title: Text(_nameController.text),
      subtitle: Text(_emailController.text),
      trailing: _isEditing
          ? IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveChanges,
            )
          : IconButton(
              icon: Icon(Icons.edit),
              onPressed: _startEditing,
            ),
    );

    final body = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            nameField,
            SizedBox(height: 16.0),
            emailField,
            SizedBox(height: 16.0),
            phoneField,
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Change Password'),
              onPressed: () {
                // TODO: Navigate to change password page
              },
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: body,
      bottomNavigationBar: _isEditing
          ? null
          : BottomAppBar(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ElevatedButton(
                  child: Text('Sign out'),
                  onPressed: () {
                    // TODO: Sign user out
                  },
                ),
              ),
            ),
    );
  }
}
