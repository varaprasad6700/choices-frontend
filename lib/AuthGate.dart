import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SignInScreen(
            providerConfigs: [
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(
                clientId: "966555663103-m8ch0r60hphpdg3skphnmfu1jk55o8sg",
              )
            ],
          );
        }
        return ProfileScreen(
          auth: FirebaseAuth.instance,
          providerConfigs: const [
            EmailProviderConfiguration(),
            GoogleProviderConfiguration(
              clientId: "966555663103-m8ch0r60hphpdg3skphnmfu1jk55o8sg",
            ),
          ],
        );
      },
    );
  }
}
