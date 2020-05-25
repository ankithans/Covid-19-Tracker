import 'package:covid19_tracker_application/ui/widgets/learn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Precautions extends StatefulWidget {
  @override
  _PrecautionsState createState() => _PrecautionsState();
}

class _PrecautionsState extends State<Precautions> {
  List<Image> images = [
    Image.asset(
      'assets/pec/photo.png',
      height: 40,
    ),
    Image.asset(
      'assets/pec/cart.png',
      height: 40,
    ),
    Image.asset(
      'assets/pec/president.png',
      height: 40,
    ),
    Image.asset(
      'assets/pec/time-and-date.png',
      height: 40,
    ),
    Image.asset(
      'assets/pec/money.png',
      height: 40,
    ),
  ];

  List<Text> title = [
    Text(
      'Stealing your\npersonal data',
      textAlign: TextAlign.left,
      style: GoogleFonts.montserrat(
        color: Color(0xFF325384), fontSize: 16, fontWeight: FontWeight.w500,
        // fontWeight: FontWeight.w500,
      ),
    ),
    Text(
      'Fake offers of goods\nand services',
      textAlign: TextAlign.left,
      style: GoogleFonts.montserrat(
        color: Color(0xFF325384),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    Text(
      'Impersonation of\nauthorities',
      textAlign: TextAlign.left,
      style: GoogleFonts.montserrat(
        color: Color(0xFF325384),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    Text(
      'Fraudulent\nmedical offers',
      textAlign: TextAlign.left,
      style: GoogleFonts.montserrat(
        color: Color(0xFF325384),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    Text(
      'Fake requests for\ncharitable donations',
      textAlign: TextAlign.left,
      style: GoogleFonts.montserrat(
        color: Color(0xFF325384),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  ];
  List<Text> subtitle = [
    Text(
      'Scammers who ask for too much information, such as your address, bank account details or even PIN number to “fix” your insurance policy or conduct fake contact tracing',
      textAlign: TextAlign.left,
      style: GoogleFonts.montserrat(
        color: Colors.black54,
        fontSize: 12,
        // fontWeight: FontWeight.w500,
      ),
    ),
    Text(
      'Massive discounts on masks or subscriptions to online entertainment services from unknown third parties',
      textAlign: TextAlign.left,
      style: GoogleFonts.montserrat(
        color: Colors.black54,
        fontSize: 12,
        // fontWeight: FontWeight.w500,
      ),
    ),
    Text(
      'Impersonation of government organisations like MyGov.in or MoHFW offering COVID-19 information ',
      textAlign: TextAlign.left,
      style: GoogleFonts.montserrat(
        color: Colors.black54,
        fontSize: 12,
        // fontWeight: FontWeight.w500,
      ),
    ),
    Text(
      'Offers of cures, test kits, hand sanitiser or face masks that never arrive',
      textAlign: TextAlign.left,
      style: GoogleFonts.montserrat(
        color: Colors.black54,
        fontSize: 12,
        // fontWeight: FontWeight.w500,
      ),
    ),
    Text(
      'Donations to support COVID-19 relief from non-profits, hospitals, or other organizations should be carefully checked',
      textAlign: TextAlign.left,
      style: GoogleFonts.montserrat(
        color: Colors.black54,
        fontSize: 12,
        // fontWeight: FontWeight.w500,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      color: Colors.white,
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: .64,
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[50],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  images[index],
                  SizedBox(
                    height: 10,
                  ),
                  title[index],
                  SizedBox(
                    height: 10,
                  ),
                  subtitle[index],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
