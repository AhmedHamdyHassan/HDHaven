import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/common/components/app_drawer.dart';
import 'package:wallpaper_app/common/components/wallpaper_widget.dart';
import 'package:wallpaper_app/utils/app_colors.dart';
import 'package:wallpaper_app/views/home/provider/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeProvider>().initData();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: AppColors.transparentColor,
        foregroundColor: AppColors.whiteColor,
        title: const Text('Home'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.firstGradientColor,
              AppColors.secondGradientColor,
            ],
          ),
        ),
        child: Consumer<HomeProvider>(
          builder: (context, value, child) {
            if (value.showLoadingIndecatorOnCenter) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.whiteColor),
              );
            } else {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextField(
                          controller: value.searchController,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            suffixIcon: InkWell(
                              onTap: () => value.clearSearchResults(),
                              child: const Icon(
                                Icons.clear,
                              ),
                            ),
                          ),
                          onSubmitted: (submittedData) => value.onSubmitData(),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          controller: value.wallpaperScrollController,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.8,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: value.wallpapers.length,
                          itemBuilder: (context, index) {
                            return WallpaperWidget(
                              onTab: () => value.setSelectedWallpaper(
                                  context, value.wallpapers[index]),
                              imageUrl: value.wallpapers[index].srcModel!.tiny!,
                            );
                          },
                        ),
                      ),
                      Visibility(
                        visible: value.isLoading,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: CircularProgressIndicator(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
