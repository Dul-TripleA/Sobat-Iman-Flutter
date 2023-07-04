import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quranapp/Screens/detail_Screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_quranapp/Screens/global.dart';
import 'package:flutter_quranapp/models/surah.dart';
// import 'package:the_holy_quran/screens/detail_screen.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});

  Future<List<Surah>> _getSurahList() async {
    String data = await rootBundle.loadString('assets/data/List-Surah.json');
    return surahFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
        future: _getSurahList(),
        initialData: [],
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return ListView.separated(
              itemBuilder: (context, index) => _surahItem(
                  context: context, surah: snapshot.data!.elementAt(index)),
              separatorBuilder: (context, index) =>
                  Divider(color: const Color(0xFF7B80AD).withOpacity(.35)),
              itemCount: snapshot.data!.length);
        }));
  }

  Widget _surahItem({required Surah surah, required BuildContext context}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailSurah(
              noSurah: surah.nomor,
            ),
          ));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: SizedBox(
                      height: 36,
                      width: 36,
                      child: Center(
                          child: Text(
                        "${surah.nomor}",
                        style: GoogleFonts.poppins(color: Colors.white),
                      )),
                    ),
                  ),
                  SvgPicture.asset("assets/svgs/noSurah.svg"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.namaLatin,
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Text(
                          "${surah.jumlahAyat} Ayat",
                          style: GoogleFonts.poppins(color: text),
                        ),
                      ),
                      Container(
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: text),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text(surah.tempatTurun.name,
                            style: GoogleFonts.poppins(color: text)),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Text(
                surah.nama,
                style: GoogleFonts.amiri(
                    color: primary, fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
}
