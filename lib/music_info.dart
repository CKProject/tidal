import 'dart:math';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicInfo extends StatelessWidget {
  const MusicInfo({
    Key? key,
    required this.index,
    required this.title,
    required this.artist,
  }) : super(key: key);

  final int index;
  final String title;
  final String artist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.chevron_down,
                    color: Colors.white,
                    size: 26,
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NOW PLAYING',
                        style: GoogleFonts.prompt(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        title,
                        style: GoogleFonts.heebo(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'asset/icons/playlist.svg',
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SvgPicture.asset(
                    'asset/icons/volume.svg',
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: CachedNetworkImage(
                imageUrl: 'https://picsum.photos/40$index',
                progressIndicatorBuilder: ((context, url, progress) {
                  return Container(
                    color: Colors.grey,
                  );
                }),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.heebo(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      artist,
                      style: GoogleFonts.heebo(
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: const Icon(
                      CupertinoIcons.heart,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ProgressBar(
            progress: const Duration(milliseconds: 0),
            buffered: const Duration(milliseconds: 2000),
            total: Duration(milliseconds: Random().nextInt(10) * 30000),
            progressBarColor: Theme.of(context).primaryColor,
            thumbColor: Colors.white,
            baseBarColor: Colors.white.withOpacity(0.2),
            bufferedBarColor: Colors.white.withOpacity(0.2),
            barHeight: 4,
            thumbRadius: 6,
            thumbGlowRadius: 15,
            timeLabelPadding: 4,
            timeLabelTextStyle: GoogleFonts.prompt(
              color: Colors.white.withOpacity(0.6),
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
