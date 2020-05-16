import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_display/number_display.dart';

class MostAffectedStates extends StatelessWidget {
  final totalData;

  const MostAffectedStates({Key key, this.totalData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final display = createDisplay();
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 7,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    totalData['statewise'][index]['state'],
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Confirmed: ',
                        style: GoogleFonts.montserrat(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        display(int.parse(
                                totalData['statewise'][index]['confirmed']))
                            .toString(),
                        style: GoogleFonts.montserrat(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
