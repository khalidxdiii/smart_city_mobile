// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';


class UserLayoutScreenModule extends StatelessWidget {
  const UserLayoutScreenModule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: GoogleFonts.almarai(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            
            leading: PopupMenuButton(
                onSelected: (value) {
                  
                  if (value == 0) {
                    FirebaseAuth.instance.signOut().then((value) {
                      // Sign-out successful.
                    }).catchError((error) {
                      debugPrint(error.ToString());
                    });

                   Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ),
                (route) => false);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'تم تسجيل الخروج بنجاح !',
                style: GoogleFonts.almarai(color: kDsecondaryColor),
              ),
              backgroundColor: kDprimaryColor,
            ));
                  }
                },
                itemBuilder: (context) => [
                  
                  const PopupMenuItem(
                    value: 0,
                    child: Text('تسجيل خروج'),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.home,
                  ),
                  label: cubit.titles[0],
                ),
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.camera_enhance,
                  ),
                  label: cubit.titles[1],
                ),
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.toc,
                  ),
                  label: cubit.titles[2],
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
