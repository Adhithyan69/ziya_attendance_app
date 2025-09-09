import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/views/notification_screen.dart';
import '../constants/color_constants.dart';
import '../constants/text_constants.dart';
import '../providers/search_controller.dart';

class LeavesScreenAppBar extends StatelessWidget {
  const LeavesScreenAppBar({super.key});

  void showSearchHistoryDialog(BuildContext context) {
    final searchController =
    Provider.of<SearchSheetController>(context, listen: false);
    final TextEditingController textController = TextEditingController();
    final String? hintText = DateFormat(TextConstants.searchHintDateFormat).format(DateTime.now());

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: TextConstants.search,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: StatefulBuilder(
                builder: (context, setState) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        Expanded(
                          child: TextField(
                            controller: textController,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: hintText,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            final term = textController.text.trim();
                            if (term.isNotEmpty) {
                              searchController.addSearchTerm(term);
                              setState(() {});
                              Navigator.pop(context);
                            }
                          },
                          child: Card(
                            color: Colors.lightGreen.shade400,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 2),
                              child: Icon(Icons.send, color: AppColors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    searchController.searchHistory.isEmpty
                        ? const Text(TextConstants.noRecentSearches)
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0, bottom: 6),
                          child: Text(TextConstants.searchHistory,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                        ...searchController.searchHistory
                            .map(
                              (term) => ListTile(
                            title: Text("$term..."),
                            onTap: () {
                              textController.text = term;
                            },
                          ),
                        )
                            .toList(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(anim),
          child: child,
        );
      },
    );
  }

  Route _createSlideRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
      const NotificationScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Image.asset('lib/assets/ziya_logo.jpg', width: 40, height: 40),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => showSearchHistoryDialog(context),
                child: const Card(
                  color: AppColors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      children: [
                        Icon(Icons.search, size: 18, color: Colors.grey),
                        SizedBox(width: 8),
                        Text(
                          TextConstants.search,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(_createSlideRoute());
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: AppColors.buttonColor,
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    const Icon(Icons.notifications,
                        size: 25, color: AppColors.white),
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(TextConstants.profileImageUrl),
            ),
          ],
        ),
      ),
    );
  }
}
