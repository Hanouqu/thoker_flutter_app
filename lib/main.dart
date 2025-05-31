import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/profile': (context) => ProfilePage(),
        '/passwordChanged': (context) => PasswordChangedScreen(),
        '/TransferFundsPage': (context) => TransferFundsPage(),
        '/PayBillsPage': (context) => PayBillsPage(),
        '/Homepage': (context) => Homepage(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 233, 237),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/thoker.jpg'),
              width: 300,
              height: 300,
            ),
            SizedBox(height: 40),
            // Sign In Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Sign In',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 170, 117, 111),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
            SizedBox(height: 10),
            // Sign Up Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text('Sign Up',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 170, 117, 111),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// PROFILE
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = 'رندا';
  String _email = 'randad@example.com';
  String _phone = '0123456789';
  String _bankAccount = '123456789';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? _name;
      _email = prefs.getString('email') ?? _email;
      _phone = prefs.getString('phone') ?? _phone;
      _bankAccount = prefs.getString('bankAccount') ?? _bankAccount;
    });
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear user data
    Navigator.pushReplacementNamed(
        context, '/'); // Navigate to SplashScreen after logout
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        backgroundColor: Color.fromARGB(255, 170, 117, 111),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              } // Add logout button
              ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 243, 233, 237),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('images/cat.jpg'),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text(_email, style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text(_phone, style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text(_bankAccount, style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        name: _name,
                        email: _email,
                        phone: _phone,
                        bankAccount: _bankAccount,
                      ),
                    ),
                  ).then((_) {
                    // Reload data after returning
                    _loadProfileData();
                  });
                },
                child: Text('Edit Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Edit Profile
class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String bankAccount;

  EditProfilePage(
      {required this.name,
      required this.email,
      required this.phone,
      required this.bankAccount});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _bankController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
    _bankController = TextEditingController(text: widget.bankAccount);
  }

  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('bankAccount', _bankController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile Page'),
        backgroundColor: Color.fromARGB(255, 170, 117, 111),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _bankController,
              decoration: InputDecoration(labelText: "Bank Account"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveProfileData(); // حفظ البيانات
                Navigator.pop(context);
              },
              child: Text("Save"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 170, 117, 111),
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//forget password hanooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _errorMessage;

  void _resetPassword() {
    if (_newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        _errorMessage = "Please fill in both fields.";
      });
    } else if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = "Passwords do not match.";
      });
    } else {
      // Proceed with password reset logic
      setState(() {
        _errorMessage = null; // Clear any error message
      });
      Navigator.pushNamed(context, '/passwordChanged');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        backgroundColor: Color.fromARGB(255, 170, 117, 111),
      ),
      backgroundColor: Color.fromARGB(255, 243, 233, 237),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: "New Password",

                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                errorText: _errorMessage, // Show error message if any
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: "Confirm Password",
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                errorText: _errorMessage, // Show error message if any
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetPassword,
              child:
                  Text("Reset Password", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 170, 117, 111),
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordChangedScreen extends StatefulWidget {
  @override
  _PasswordChangedScreenState createState() => _PasswordChangedScreenState();
}

class _PasswordChangedScreenState extends State<PasswordChangedScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to the login page after a delay
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
          context, '/login'); // Change '/login' to your login route
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Password Changed"),
        backgroundColor: Color.fromARGB(255, 170, 117, 111),
      ),
      backgroundColor: Color.fromARGB(255, 243, 233, 237),
      body: Center(
        child: Text(
          "Your password has been changed successfully!",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

//sign in hanoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
// Sign In Screen
class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    void _signIn() {
      // Add your sign-in logic here
      // If sign-in is successful
      Navigator.pushReplacementNamed(context, '/Homepage');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        backgroundColor: Color.fromARGB(255, 170, 117, 111),
      ),
      backgroundColor: Color.fromARGB(255, 243, 233, 237),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen()),
                  );
                },
                child: const Text(
                  "Forgot your password?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 170, 117, 111),
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              child: Text("Sign In", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 170, 117, 111),
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, '/signup'); // Navigate to SignUpScreen
              },
              child: const Text(
                "New User? Sign Up",
                style: TextStyle(
                  color: Color.fromARGB(255, 170, 117, 111),
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Sign Up Screen
class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: Color.fromARGB(255, 170, 117, 111),
      ),
      backgroundColor: Color.fromARGB(255, 243, 233, 237),
      body: SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _signUp() {
    // Sign-up logic here
    // If sign-up is successful
    Navigator.pushReplacementNamed(context, '/Homepage');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildTextField(_nameController, "Name", Icons.person),
            _buildTextField(_emailController, "Email", Icons.email),
            _buildTextField(_phoneController, "Phone Number", Icons.phone),
            _buildTextField(_idController, "ID Number", Icons.perm_identity),
            _buildTextField(_passwordController, "Password", Icons.lock,
                obscureText: true),
            _buildTextField(
                _confirmPasswordController, "Confirm Password", Icons.lock,
                obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: Text("Sign Up", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 170, 117, 111),
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, IconData icon,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(),
        ),
        obscureText: obscureText,
      ),
    );
  }
}

// HOMEPAGE
class Homepage extends StatelessWidget {
  Future<String> _getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? 'اسم المستخدم'; // قيمة افتراضية
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 170, 117, 111), // لون رأس الدراور
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40, // حجم الأفتار
                    backgroundImage:
                        AssetImage('images/cat.jpg'), // رابط صورة الأفتار
                  ),
                  SizedBox(height: 10), // مساحة بين الأفتار والاسم
                  Text(
                    'ID:0223899',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile Page'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log out'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                );
              },
            ),

// اكتب ليتليس زيادة
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: const Color.fromARGB(255, 170, 117, 111),
      ),
      body: Container(
        color: Color.fromARGB(255, 243, 233, 237),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  Text('Account Balance',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 170, 117, 111))),
                  SizedBox(height: 8),
                  Text('\$25,000.00', style: TextStyle(fontSize: 32)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Services',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionButton(
                  icon: Icons.transfer_within_a_station,
                  label: 'Transfer',
                  onPressed: () {
                    Navigator.pushNamed(context, '/TransferFundsPage');
                  },
                ),
                ActionButton(
                  icon: Icons.payment,
                  label: 'Pay Bills',
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/PayBillsPage'); // ربط الزر بصفحة الدفع
                  },
                ),
                ActionButton(icon: Icons.receipt, label: 'Monthly Savings'),
                ActionButton(icon: Icons.money, label: 'Splitting Expenses'),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Recent Transactions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView(
                children: [
                  TransactionItem(title: 'Health', amount: '+\$1,000.00'),
                  TransactionItem(title: 'Bill', amount: '-\$200.00'),
                  TransactionItem(title: 'Transfer', amount: '-\$150.00'),
                  TransactionItem(title: 'Food', amount: '-\$50.00'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed; // Add onPressed parameter

  const ActionButton(
      {super.key, required this.icon, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPressed, // Use onPressed here
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(icon,
                size: 30, color: const Color.fromARGB(255, 170, 117, 111)),
          ),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String title;
  final String amount;

  const TransactionItem({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Text(amount),
    );
  }
}

//Transfer
class TransferFundsPage extends StatefulWidget {
  @override
  _TransferFundsPageState createState() => _TransferFundsPageState();
}

class _TransferFundsPageState extends State<TransferFundsPage> {
  final TextEditingController _amountController = TextEditingController();
  String _statusMessage = '';
  String? _selectedRecipient; // Variable to hold selected recipient

  // List of recipients
  final List<String> _recipients = [
    'Elaf',
    'Hanan',
    'Randa',
    'Razan',
  ];

  void _transferFunds() {
    final String amount = _amountController.text;

    // Simple validation
    if (_selectedRecipient == null || amount.isEmpty) {
      setState(() {
        _statusMessage = 'Please fill in all fields.';
      });
      return;
    }

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Transfer'),
          content: Text('Transfer \$${amount} to $_selectedRecipient?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                setState(() {
                  _statusMessage =
                      'Transfer of \$${amount} to $_selectedRecipient successful!';
                });
                Navigator.of(context).pop();
                _amountController.clear();
                _selectedRecipient = null; // Reset selected recipient
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer Funds'),
        backgroundColor: Color.fromARGB(255, 170, 117, 111),
      ),
      body: Container(
        color: Color.fromARGB(255, 243, 233, 237),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown for selecting recipient
            DropdownButton<String>(
              hint: Text('Select Recipient'),
              value: _selectedRecipient,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRecipient = newValue;
                });
              },
              items:
                  _recipients.map<DropdownMenuItem<String>>((String recipient) {
                return DropdownMenuItem<String>(
                  value: recipient,
                  child: Text(recipient),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Purpose of the transfer',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.padding),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Center(
              // Centering the button
              child: ElevatedButton(
                onPressed: _transferFunds,
                child: Text(
                  'Transfer',
                  style:
                      TextStyle(color: Colors.white), // Set text color to white
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 170, 117, 111),
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _statusMessage,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

//Pay Bills Page
class PayBillsPage extends StatefulWidget {
  @override
  _PayBillsPageState createState() => _PayBillsPageState(); //function
}

class _PayBillsPageState extends State<PayBillsPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _billNumberController = TextEditingController();
  String _statusMessage = '';
  String? _selectedBillType;

  double _totalExpenses = 0.0;
  List<String> _paymentDetails = []; // List to hold payment details

  // List of bill types
  final List<String> _billTypes = [
    'Electricity',
    'Water',
    'Internet',
    'Rent',
  ];

  void _payBill() {
    final String amount = _amountController.text;
    final String billNumber = _billNumberController.text;

    // Simple validation
    if (_selectedBillType == null || amount.isEmpty || billNumber.isEmpty) {
      setState(() {
        _statusMessage = 'Please fill in all fields.';
      });
      return;
    }

    // Add the entered amount to the total expenses and store the details
    setState(() {
      double? parsedAmount = double.tryParse(amount);

      if (parsedAmount != null) {
        _totalExpenses += parsedAmount;
        _paymentDetails.add('$_selectedBillType: \$${parsedAmount}');
        _statusMessage =
            'Payment of \$${parsedAmount} for $_selectedBillType successful!';
      } else {
        _statusMessage = 'Invalid input: "$amount" is not a valid number!';
      }
    });

    // Clear the input fields after payment
    _amountController.clear();
    _billNumberController.clear();
    _selectedBillType = null; // Reset selected bill type
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Bills'),
        backgroundColor: Color.fromARGB(255, 170, 117, 111),
      ),
      body: Container(
        color: Color.fromARGB(255, 243, 233, 237),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown for selecting bill type
            DropdownButton<String>(
              hint: Text('Select Bill Type'),
              value: _selectedBillType,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedBillType = newValue;
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: 'Electricity',
                  child: Text('Electricity'),
                ),
                DropdownMenuItem<String>(
                  value: 'Water',
                  child: Text('Water'),
                ),
                DropdownMenuItem<String>(
                  value: 'Internet',
                  child: Text('Internet'),
                ),
                DropdownMenuItem<String>(
                  value: 'Rent',
                  child: Text('Rent'),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _billNumberController,
              decoration: InputDecoration(
                labelText: 'Bill Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.receipt),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _payBill,
                child: Text(
                  'Pay',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 170, 117, 111),
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _statusMessage,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 20),

            // Display total monthly expenses and payment details
            Text(
              'Total Monthly Expenses: \$${_totalExpenses}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Payment Details:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _paymentDetails.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_paymentDetails[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}