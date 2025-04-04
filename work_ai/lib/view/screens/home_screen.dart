import 'package:flutter/material.dart';
import 'package:work_ai/view/widgets/custom_widgets/app_list/app_list.dart';
import 'package:work_ai/view/widgets/custom_widgets/home/home_widget/suggestion_widget.dart';
import 'package:work_ai/view/widgets/custom_widgets/home/meeting/call_list.dart';
import '../../core/data/auth/auth_storage.dart';
import '../widgets/custom_widgets/app_background/background.dart';
import '../widgets/custom_widgets/search/search_widget.dart';
import '../widgets/header/header.dart';
import 'auth/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _searchController = TextEditingController();

  void _logout(BuildContext context) async {
    await AuthStorage.clearUser();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const HomeHeader(title: "Toru", upperTitle: "Hello!"),
              const SizedBox(height: 10),
              SearchInput(searchController: _searchController, hintText: "なんでも質問してください！"),
              const SizedBox(height: 20),
              SlidingIconsList(),
              const SizedBox(height: 20),
              const SuggestionWidget(),
              const SizedBox(height: 20),
              const VideoCallList(),
              //const Text('Main Content Goes Here', style: AppTextStyles.bodyStyle),
              const SizedBox(height: 80),
              Center(
                child: ElevatedButton(
                  onPressed: () => _logout(context),
                  child: const Text("Logout"),
                ),
              ),
            ],
          ),
        ),
      ),

    );

  }
}



