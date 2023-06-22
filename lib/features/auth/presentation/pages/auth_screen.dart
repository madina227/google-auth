import 'package:auth_google/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_google/features/auth/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: GestureDetector(
            onTap: () {
              context.read<AuthBloc>().add(SignInWithGoogleEvent(
                  onError: () {},
                  onSuccess: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen()));
                  }));
            },
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset('assets/icons/google.svg'),
                  const Text(
                    'Sign in with Google',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
