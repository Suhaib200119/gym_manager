import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_manager/core/colorsManager.dart';
import 'package:gym_manager/feature/providers/Shared_Provider.dart';
import 'package:gym_manager/feature/view/screens_trainer/Attendance_absence_Screen_Trainer/Attendance_AbsenceScreen_Trainer.dart';
import 'package:gym_manager/feature/view/screens_trainer/Profile_Screen_Trainer/ProfileScreen_Trainer.dart';
import 'package:gym_manager/feature/view/screens_trainer/Rating_Screen_Trainer/RatingScreen_Trainer.dart';
import 'package:provider/provider.dart';
import 'package:gym_manager/feature/view/Notification_Screen/NotificationScreen.dart';
import 'package:gym_manager/feature/view/Settings_Screen/SettingsScreen.dart';

class LayoutScreen_Trainer extends StatelessWidget {
  List<Widget> screens=[
    NotificationScreen(),
    Attendance_AbsenceScreen_Trainer(),
    RatingScreen(),
    ProfileScreenTrainer(),
    SettingsScreen(),
  ];
  List<String> names=[
    "الإشعارات",
    "سجل الحضور والغياب",
    "التقييمات",
    "الملف الشخصي",
    "الإعدادات"
  ];

  @override
  Widget build(BuildContext context) {
    var shared_Provider = Provider.of<Shared_Provider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
        title: Text("${names[shared_Provider.indexBottomNavigationBar_Trainer]}",
          style: GoogleFonts.cairo(textStyle: TextStyle(
            color: ColorsManager.primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,),
          ),
        ),
        actions: [
          Image.asset("Assets/images/GymLogo.png",width: 25,height: 25,),
          SizedBox(width: 10,),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black87,//لون العنصر الموجود في الناف بار
        color: ColorsManager.blackColor,// لون النافي بار نفسه
        animationCurve: Curves.decelerate,// طريقة تحرك العنصر الموجود في الناف بار
        buttonBackgroundColor: ColorsManager.primaryColor,//لون البوتون الموجود في العنصر الموجود في الناف بار
        items: const <Widget>[
          Icon(Icons.notifications, size: 30,color: Colors.white,),
          Icon(Icons.check_circle_sharp, size: 30,color: Colors.white,),
          Icon(Icons.star, size: 30,color: Colors.white,),
          Icon(Icons.person_pin, size: 30,color: Colors.white,),
          Icon(Icons.settings, size: 30,color: Colors.white,),

        ],// العناصر الموجودة في الناف بار
        onTap: (index) {
          shared_Provider.changeIndexBottomNavigationBar_Trainer(index);
          
        },// استرجاع الاندكس الخاص في عنصر الناف البار الذي تم الضغط عليه
        index: shared_Provider.indexBottomNavigationBar_Trainer,
      ),
      body: screens[shared_Provider.indexBottomNavigationBar_Trainer],
    );
  }
}
