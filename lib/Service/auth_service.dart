import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to handle user signup
 Future<String?> signup({
  required String name,
  required String email,
  required String phone,
  required String password,
  required String role,
}) async {
  try {
    // Create user in Firebase Authentication
    UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    // Save additional user data in Firestore
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'name': name.trim(),
      'email': email.trim(),
      'phone': phone.trim(), // Ensure this matches the field in SupplierDetails
      'role': role, 
      'lastLogin': null,
    });

    return 'Success';
  } catch (e) {
    return 'Signup failed: ${e.toString()}';
  }
}

  // Function to handle user login
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in the user using Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Update the user's last login time in Firestore
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .update({'lastLogin': FieldValue.serverTimestamp()});

      // Fetch the user's role from Firestore to determine access level
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      return userDoc['role']; // Return the user's role (Admin/Supplier)
    } catch (e) {
      return e.toString(); // Error: return the exception message
    }
  }

  // For user log out
  signOut() async {
    _auth.signOut();
  }
}
