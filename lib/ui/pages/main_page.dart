import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hike_navigator/cubit/page_cubit.dart';
import 'package:hike_navigator/ui/pages/add_destination_page.dart';
import 'package:hike_navigator/ui/pages/home_page.dart';
import 'package:hike_navigator/ui/pages/my_destination_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/navigation_item.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget content(int index) {
      switch (index) {
        case 0:
          return const HomePage();
        case 1:
          return const MyDestinationPage();
        default:
          return const HomePage();
      }
    }

    Widget navigation(int currentIndex) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 90,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(
                20,
              ),
              topRight: Radius.circular(
                20,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationItem(
                imageUrl: 'assets/images/home.png',
                index: 0,
                currentIndex: currentIndex,
              ),
              NavigationItem(
                imageUrl: 'assets/images/destination.png',
                index: 1,
                currentIndex: currentIndex,
              ),
              NavigationItem(
                imageUrl: 'assets/images/profile.png',
                index: 2,
                currentIndex: currentIndex,
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Stack(
            children: [
              content(state),
              navigation(state),
            ],
          ),
          floatingActionButton: state == 0
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 90),
                  child: SizedBox(
                    width: 65,
                    height: 65,
                    child: FittedBox(
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddDestinationPage()),
                          );
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              17.5,
                            ),
                          ),
                        ),
                        backgroundColor: primaryColor,
                        child: const Icon(
                          Icons.add,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        );
      },
    );
  }
}
