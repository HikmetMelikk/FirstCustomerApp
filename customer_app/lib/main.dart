import 'package:customer_app/pages/add_customer_page.dart';
import 'package:customer_app/pages/delete_customer_page.dart';
import 'package:customer_app/pages/products_page.dart';
import 'package:customer_app/pages/update_customers_page.dart';
import 'package:customer_app/utilities/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/pages/customers_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const CustomerApp());
}

class CustomerApp extends StatelessWidget {
  const CustomerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Page HomePage',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirebaseInitialized = false;
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    setState(() {
      isFirebaseInitialized = true;
    });
    if (FirebaseAuth.instance.currentUser != null) {
      navigateToHomePage();
    }
    //navigateToHomePage();
  }

  void navigateToHomePage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomePage(title: 'CustomerApp HomePage'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isFirebaseInitialized
            ? ElevatedButton(
                onPressed: () async {
                  await signInWithGoogle();
                  navigateToHomePage();
                },
                child: const Text('Google Sign In'))
            : const CircularProgressIndicator(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              child: const MyHeroWidget(),
              onPressed: () {
                _goToProductsPage(context);
              },
            ),
            const SpaceBetweenTexts(),
            TextButton(
              child: const MyHeroWidget1(),
              onPressed: () {
                _goToCustomersPage(context);
              },
            ),
            const SpaceBetweenTexts(),
            TextButton(
              child: const MyHeroWidget2(),
              onPressed: () {
                _goToAddCustomerPage(context);
              },
            ),
            const SpaceBetweenTexts(),
            TextButton(
              child: const MyHeroWidget3(),
              onPressed: () {
                _goToUpdateCustomerPage(context);
              },
            ),
            const SpaceBetweenTexts(),
            TextButton(
              child: const MyHeroWidget4(),
              onPressed: () {
                _goToDeleteCustomerPage(context);
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(FirebaseAuth.instance.currentUser!.displayName!),
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    child: Text('HM'),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Products Page'),
              onTap: () {
                _goToProductsPage(context);
              },
            ),
            ListTile(
              title: const Text('Customers Page'),
              onTap: () {
                _goToCustomersPage(context);
              },
            ),
            ListTile(
              title: const Text('Add Customer Page'),
              onTap: () {
                _goToAddCustomerPage(context);
              },
            ),
            ListTile(
              title: const Text('Update Customer Page'),
              onTap: () {
                _goToUpdateCustomerPage(context);
              },
            ),
            ListTile(
              title: const Text('Delete Customers Page'),
              onTap: () {
                _goToDeleteCustomerPage(context);
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () async {
                await signOutWithGoogle();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _goToProductsPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const ProductsPage();
      },
    ));
  }

  void _goToCustomersPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const CustomersPage();
      },
    ));
  }

  void _goToAddCustomerPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const AddCustomerPage();
      },
    ));
  }

  void _goToUpdateCustomerPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const UpdateCustomerPage();
      },
    ));
  }

  void _goToDeleteCustomerPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const DeleteCustomerPage();
      },
    ));
  }
}

class MyHeroWidget4 extends StatelessWidget {
  const MyHeroWidget4({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'deletecustomer',
      child: Material(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          color: Colors.deepPurple[200],
          child: const Text(
            'Delete Customer Page',
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}

class MyHeroWidget3 extends StatelessWidget {
  const MyHeroWidget3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'updatecustomer',
      child: Material(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          color: Colors.teal[200],
          child: const Text('Update Customer Page',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
              )),
        ),
      ),
    );
  }
}

class MyHeroWidget2 extends StatelessWidget {
  const MyHeroWidget2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'addcustomer',
      child: Material(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          color: Colors.deepOrange[200],
          child: const Text(
            'Add Customer Page',
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}

class MyHeroWidget1 extends StatelessWidget {
  const MyHeroWidget1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'Customers Page',
      child: Material(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          color: Colors.cyanAccent[200],
          child: const Text(
            'Customers Page',
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}

class MyHeroWidget extends StatelessWidget {
  const MyHeroWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'products',
      child: Material(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          color: Colors.lime[200],
          child: const Text(
            'Products Page',
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}

class SpaceBetweenTexts extends StatelessWidget {
  const SpaceBetweenTexts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
    );
  }
}
