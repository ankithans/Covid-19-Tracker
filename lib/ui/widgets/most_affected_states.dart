import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MostAffectedStates extends StatelessWidget {
  final totalData;

  const MostAffectedStates({Key key, this.totalData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'Confirmed: ' +
                        totalData['statewise'][index]['confirmed'].toString(),
                    style: GoogleFonts.montserrat(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
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
