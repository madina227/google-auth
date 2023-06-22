import 'package:auth_google/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Text("Hello ${state.firstName} ${state.lastName}",
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 26));
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<AuthBloc>().add(SignOutWithGoogleEvent(
                  onError: () {},
                  onSuccess: () {
                    Navigator.of(context).pop();
                  }));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Sign out", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.red)),
            ),
          )
        ],
      ),
    );
  }
}
