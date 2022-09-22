import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:prayer_flutter/constants/assets_constants.dart';
import 'package:prayer_flutter/constants/colors_contants.dart';
import 'package:prayer_flutter/constants/prayer_images.dart';
import 'package:prayer_flutter/domain/repos/date_time_repo.dart';
import 'package:prayer_flutter/golabal_providers.dart';
import 'package:prayer_flutter/presentation/controllers/home_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final HomeController _controller;
  @override
  void didChangeDependencies() {
    _controller = HomeController(ref: ref);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final prayers = ref.watch(prayersProviderProvider(ref.watch(dateProvider)));
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'اوقات الصلاة',
                  style: TextStyle(
                      fontFamily: 'cario', fontSize: 40, fontWeight: FontWeight.bold, color: ColorsConstants.textColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: _controller.onBackwardClick,
                        child: const Icon(Icons.arrow_back_ios_rounded, color: ColorsConstants.textColor)),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      ref.read(dateTimeRepoProvider).getDayDate(ref.watch(dateProvider)),
                      style: const TextStyle(
                          fontFamily: 'cario',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorsConstants.textColor),
                    ).animate().fade(),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: _controller.onForwardClick,
                        child: const Icon(Icons.arrow_back_ios_new_outlined, color: ColorsConstants.textColor)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsConstants.location,
                      width: 40,
                    ),
                    const Text(
                      "الدمام",
                      style: TextStyle(
                          fontFamily: 'cario',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorsConstants.textColor),
                    ),
                  ],
                ),
              ],
            ),
            backgroundColor: ColorsConstants.backgroundColor,
            toolbarHeight: 200,
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )),
          ),
          backgroundColor: ColorsConstants.secondaryColor,
          body: prayers.when(
            data: (prayersData) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                      prayersData.prayers.length,
                      (index) => Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              height: MediaQuery.of(context).size.width * 0.15,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15)],
                                  color: ColorsConstants.primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    prayerImages[index],
                                    height: MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  Text(
                                    prayersData.prayers[index].title,
                                    style: const TextStyle(
                                        fontFamily: 'cario', fontSize: 25, color: ColorsConstants.textColor),
                                  ),
                                  Text(
                                    ref.read(dateTimeRepoProvider).getTimeFormatted(prayersData.prayers[index].time),
                                    style: const TextStyle(
                                        fontFamily: 'cario', fontSize: 25, color: ColorsConstants.textColor),
                                  ),
                                ],
                              )),
                            ).animate().scale(),
                          )),
                ),
              );
            },
            error: ((error, stackTrace) {
              return const SizedBox.shrink();
            }),
            loading: (() {
              return Center(
                child: Lottie.asset(AssetsConstants.loading, width: MediaQuery.of(context).size.width * 0.6),
              );
            }),
          )),
    );
  }
}
