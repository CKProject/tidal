import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:tidal/music_info.dart';

const titleList = [
  'So Yeah',
  'Song for Prog',
  'Chef',
  'Cry (feat. PGF)',
];

const artistList = [
  'Anvil',
  'Snow White',
  'Pansy',
  'Double Bubble',
];

const musicTypeList = [
  'HIFI',
  'MASTER',
  'MASTER',
  'HIFI',
];

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController controller = PageController(initialPage: 0);
  PaletteGenerator? paletteGenerator;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _updatePaletteGenerator(0);
    controller.addListener(() {
      if (controller.page != null) {
        _updatePaletteGenerator(pageIndex);
      }
    });
  }

  Future<void> _updatePaletteGenerator(int index) async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      CachedNetworkImageProvider('https://picsum.photos/40$index'),
      maximumColorCount: 20,
    );
    setState(() {
      pageIndex = controller.page!.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  paletteGenerator == null
                      ? Colors.black
                      : paletteGenerator!.mutedColor!.color,
                  Colors.black,
                ],
                stops: const [0.4, 1.0],
              ),
            ),
            duration: const Duration(milliseconds: 400),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller,
                    itemCount: titleList.length,
                    itemBuilder: (context, index) {
                      return MusicInfo(
                        index: index,
                        title: titleList[index],
                        artist: artistList[index],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'asset/icons/shuffle.svg',
                        width: 20,
                      ),
                      Row(
                        children: const [
                          Icon(
                            CupertinoIcons.backward_end_fill,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Icon(
                            CupertinoIcons.play_arrow_solid,
                            color: Colors.white,
                            size: 50,
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Icon(
                            CupertinoIcons.forward_end_fill,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                      Icon(
                        CupertinoIcons.repeat,
                        color: Colors.white.withOpacity(0.8),
                        size: 24,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset('asset/icons/connect.svg'),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: musicTypeList[pageIndex] == 'HIFI'
                              ? const Color(0xFF0B2E2F)
                              : const Color(0xFF4D3F32),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          musicTypeList[pageIndex],
                          style: GoogleFonts.prompt(
                            color: musicTypeList[pageIndex] == 'HIFI'
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.more_horiz,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
