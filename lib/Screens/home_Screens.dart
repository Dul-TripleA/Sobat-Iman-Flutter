import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quranapp/Screens/global.dart';
import 'package:flutter_quranapp/tabs/hijbTab.dart';
import 'package:flutter_quranapp/tabs/pageTab.dart';
import 'package:flutter_quranapp/tabs/paraTab.dart';
import 'package:flutter_quranapp/tabs/surahTab.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavBar(),
      body: DefaultTabController(
        length: 4,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverToBoxAdapter(child: _greeting()),
                      SliverAppBar(
                        pinned: true,
                        elevation: 0,
                        shape: Border(
                            bottom: BorderSide(
                                width: 3,
                                color:
                                    const Color(0xFFAAAAAA).withOpacity(.2))),
                        backgroundColor: bg,
                        automaticallyImplyLeading: false,
                        bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(0),
                            child: _tab()),
                      )
                    ],
                body: const TabBarView(
                    children: [SurahTab(), ParaTab(), PageTab(), HijbTab()]))),
      ),
    );
  }

  TabBar _tab() {
    return TabBar(
      unselectedLabelColor: text,
      labelColor: Colors.white,
      indicatorColor: primary,
      indicatorWeight: 3,
      tabs: [
        _tabBar(label: "Surah"),
        _tabBar(label: "Para"),
        _tabBar(label: "Page"),
        _tabBar(label: "Hijb"),
      ],
    );
  }

  Tab _tabBar({required String label}) => Tab(
          child: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ));

  Column _greeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Text(
          "Assalamualaikum",
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w600, color: text),
        ),
        Text(
          "Sobat Iman",
          style: GoogleFonts.poppins(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(
          height: 16,
        ),
        _LastRead()
      ],
    );
  }

  Stack _LastRead() {
    return Stack(
      children: [
        Container(
          height: 131,
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
            child: SvgPicture.asset("assets/svgs/quran.svg")),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/svgs/lastRead-Icon.svg"),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      "Last Read",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Al-Fatihah",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              Text(
                "Ayat : 1",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }

  AppBar _appBar() => AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bg,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
                onPressed: (() => {}),
                icon: SvgPicture.asset(
                  'assets/svgs/menu.svg',
                  color: Colors.white,
                )),
            SizedBox(width: 24),
            Text('Sobat Iman',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            Spacer(),
            IconButton(
                onPressed: (() => {}),
                icon: SvgPicture.asset('assets/svgs/search.svg'))
          ],
        ),
      );

  BottomNavigationBar _bottomNavBar() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: navBottom,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          _bottomNavBarItem(icon: "assets/svgs/quran-Icon.svg", label: "Quran"),
          _bottomNavBarItem(
              icon: "assets/svgs/prayTime-Icon.svg", label: "Sholat"),
          _bottomNavBarItem(icon: "assets/svgs/pray-Icon.svg", label: "Doa"),
          _bottomNavBarItem(
              icon: "assets/svgs/bookmark-Icon.svg", label: "Bokkmark"),
        ],
      );

  BottomNavigationBarItem _bottomNavBarItem(
          {required String icon, required String label}) =>
      BottomNavigationBarItem(
          icon: SvgPicture.asset(icon, color: text),
          activeIcon: SvgPicture.asset(
            icon,
            color: primary,
          ),
          label: label);
}
