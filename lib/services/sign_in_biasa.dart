import 'package:firebase_auth/firebase_auth.dart';

late String email_biasa;
late String password;
// Proses Pendaftaran (sign up)
Future<UserCredential?> signUpWithEmail(String email, String password,
    {String? profilImage}) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (profilImage != null) {
      // ignore: deprecated_member_use
      await userCredential.user!.updateProfile(photoURL: profilImage);
      await userCredential.user!.reload();
    }
    return userCredential;
  } catch (e) {
    print('Error during sign up: $e');
    return null;
  }
}

// Proses Masuk (Sign In)
Future<UserCredential?> signInWithEmail(String email, String password) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email_biasa,
      password: password,
    );
    return userCredential;
  } catch (e) {
    print('Error during sign in: $e');
    return null;
  }
}

//Logika Untuk Sign out
Future<void> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    print('Error during sign out : $e');
  }
}
