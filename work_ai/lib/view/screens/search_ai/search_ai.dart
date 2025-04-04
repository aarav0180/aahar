import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_ai/view/widgets/custom_widgets/search/search_chip.dart';
import 'package:work_ai/view/widgets/custom_widgets/searchAi/recentChats/recent_chats.dart';
import 'package:work_ai/view/widgets/header/header.dart';
import '../../../core/configs/text_configs/text_config.dart';
import '../../../core/data/auth/auth_storage.dart';
import '../../../core/utils/theme/app_colors.dart';
import '../../../providers/theme/theme_provider.dart';
import '../../widgets/custom_widgets/app_background/background.dart';
import '../../widgets/custom_widgets/floating_buttons/new_chat.dart';
import '../../widgets/custom_widgets/search/search_widget.dart';
import '../../widgets/custom_widgets/searchAi/chatDrawer/chat_drawer.dart';
import '../auth/login/login_screen.dart';

class SearchAi extends StatefulWidget {
  const SearchAi({super.key});

  @override
  State<SearchAi> createState() => _SearchAiState();
}

class _SearchAiState extends State<SearchAi> {

  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String getGreeting() {
    int hour = DateTime.now().hour;
    if (hour < 12 && hour > 5) {
      return "🌤️ Good Morning";
    } else if (hour < 18 && hour > 12) {
      return "🌞 Good Afternoon";
    } else {
      return "🌙 Good Evening";
    }
  }

  void _logout(BuildContext context) async {
    await AuthStorage.clearUser();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  final Map<String, List<String>> chatMessages = {
    "Today": ["Chat 1", "Chat 2"],
    "Yesterday": ["Chat 3", "Chat 4"],
    "Previous 7 Days": ["Chat 5", "Chat 6", "Chat 7"],
  };

  List<String> text = ["開発状況についてまとめているドキュメントはどこですか？", "必要な採用要件について教えてください。"];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDark;

    return Scaffold(
      key: _scaffoldKey,
      drawer: ChatDrawer(chatMessages: chatMessages, context: context,),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16, right: 16),
        child: NewChatButton(
          onPressed: () {
            // Handle new chat action
            //print("New Chat Clicked!");
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: BackgroundWidget(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                HomeHeader(title: "Toru", upperTitle: "Hello!", onButtonPressed: () => _scaffoldKey.currentState?.openDrawer()),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "${getGreeting()}!",
                    style: AppTextStyles.mediumBold.copyWith(color: isDarkMode ? AppColors.textDark : AppColors.textLight, fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                SearchInput(searchController: _searchController, hintText: "なんでも質問してください！"),
                const SizedBox(height: 8),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: text.length, // Example count
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: searchChip(text[index], context, isDarkMode),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                buildRecentChats(context),
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
      ),
    );
  }
}
