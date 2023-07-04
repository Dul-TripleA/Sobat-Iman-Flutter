import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_quranapp/Screens/global.dart';
import 'package:flutter_quranapp/models/ayat.dart';
import 'package:flutter_quranapp/models/surah.dart';

class DetailSurah extends StatelessWidget {
  final int noSurah;
  const DetailSurah({super.key, required this.noSurah});

  Future<Surah> _getDetailSurah() async {
    var data = await Dio().get("https://equran.id/api/surat/$noSurah");
    return Surah.fromJson(json.decode(data.toString()));
  }

  Widget build(BuildContext context) {
    return FutureBuilder<Surah>(
        future: _getDetailSurah(),
        initialData: null,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: bg,
            );
          }
          Surah surah = snapshot.data!;
          return Scaffold(
            backgroundColor: bg,
            appBar: _appBar(context: context, surah: surah),
            body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverToBoxAdapter(
                        child: _detailSurah(surah: surah),
                      )
                    ],
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView.separated(
                    itemBuilder: (context, index) => _ayat(
                        ayat: surah.ayat!
                            .elementAt(index + (noSurah == 1 ? 1 : 0))),
                    itemCount: surah.jumlahAyat + (noSurah == 1 ? -1 : 0),
                    separatorBuilder: (context, index) => Container(),
                  ),
                )),
          );
        }));
  }

  Widget _ayat({required Ayat ayat}) => Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                  color: navBottom, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(27 / 2)),
                    child: Center(
                        child: Text(
                      '${ayat.nomor}',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    )),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.share_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Icon(
                    Icons.play_arrow_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Icon(
                    Icons.bookmark_outline,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              ayat.ar,
              style: GoogleFonts.amiri(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              ayat.idn,
              style: GoogleFonts.poppins(color: text, fontSize: 14),
            )
          ],
        ),
      );
  Widget _detailSurah({required Surah surah}) => Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 16),
        child: Stack(
          children: [
            Container(
              height: 260,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFDF98FA), Color(0xFF9055FF)],
                  )),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Opacity(
                  opacity: .2,
                  child: SvgPicture.asset(
                    "assets/svgs/quran.svg",
                    height: 150,
                  ),
                )),
            Container(
              padding: EdgeInsets.all(28),
              width: double.infinity,
              child: Column(children: [
                Text(
                  surah.namaLatin,
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                Text(
                  surah.arti,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
                Divider(
                  color: Colors.white.withOpacity(.45),
                  thickness: 2,
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        surah.tempatTurun.name,
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "${surah.jumlahAyat} Ayat",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: SvgPicture.asset("assets/svgs/bismillah.svg"),
                )
              ]),
            ),
          ],
        ),
      );

  AppBar _appBar({required BuildContext context, required Surah surah}) =>
      AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Row(children: [
          Text(
            surah.namaLatin,
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
              onPressed: (() => {}),
              icon: SvgPicture.asset('assets/svgs/search.svg')),
        ]),
      );
}
