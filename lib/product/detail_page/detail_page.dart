import 'package:akademi_bootcamp/core/components/app_bar/custom_app_bar.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
//seninkiler

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DetailPage(),
    );
  }
}

class DetailPage extends StatelessWidget {
  void onPressed() {
    // onPressed atanacak
  }

  @override
  Widget build(BuildContext context) {
    String location = 'Küçük Çiftlik Park';
    String buyText = 'Bilet Satın Al';
    String date = '02.03.2023';
    String time = '21.00';

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff323232),
        appBar: CustomAppBar(
          context: context,
          left: AppBarWidgets.BACK,
          right: AppBarWidgets.FAVOURITE,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height - 550),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 25),
                        Icon(
                          Icons.calendar_month,
                          color: AppColors.vanillaShake,
                        ),
                        SizedBox(width: 10),
                        Text(
                          date,
                          style: TextStyle(
                            color: AppColors.vanillaShake,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.access_time,
                          color: AppColors.vanillaShake,
                        ),
                        SizedBox(width: 10),
                        Text(
                          time,
                          style: TextStyle(
                            color: AppColors.vanillaShake,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 77),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      Icon(
                        Icons.location_on,
                        size: 30,
                        color: AppColors.vanillaShake,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text(
                          location,
                          style: TextStyle(
                            color: AppColors.vanillaShake,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 40),
              height: 50,
              width: 340,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color?>(
                    AppColors.vanillaShake,
                  ),
                ),
                onPressed: onPressed,
                child: Text(
                  buyText,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
