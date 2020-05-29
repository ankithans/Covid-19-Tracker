import 'package:covid19_tracker_application/ui/screens/precautions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Learn extends StatefulWidget {
  @override
  _LearnState createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildImage(String assetName) {
    return Align(
      child: SvgPicture.asset('assets/svg/$assetName.svg', width: 150.0),
      alignment: Alignment.bottomRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 15.0);
    var pageDecoration = PageDecoration(
      titleTextStyle:
          GoogleFonts.montserrat(fontSize: 26.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
    );
    var de = PageDecoration(
      titleTextStyle:
          GoogleFonts.montserrat(fontSize: 20.0, fontWeight: FontWeight.w500),
      pageColor: Colors.white,
    );
    return Scaffold(
      body: IntroductionScreen(
        key: introKey,
        pages: [
          PageViewModel(
            title:
                "Hot and humid climates do not make it easier for COVID-19 to spread.",
            body: '',
            image: _buildImage('streamline-gtf-hot-climates'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "COVID-19 is not transmitted by mosquitoes.",
            body: "",
            image: _buildImage('streamline-gtf-mosquito'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Cold weather does not kill COVID-19 or other diseases.",
            body: "",
            image: _buildImage('streamline-gtf-cold-weather'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Hot baths cannot prevent people from getting COVID-19.",
            body: "",
            image: _buildImage('streamline-gtf-bath'),
            // footer: RaisedButton(
            //   onPressed: () {
            //     introKey.currentState?.animateScroll(0);
            //   },
            //   // child: const Text(
            //   //   'FooButton',
            //   //   style: TextStyle(color: Colors.white),
            //   // ),
            //   color: Colors.lightBlue,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(8.0),
            //   ),
            // ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Hand dryers do not kill the new coronavirus.",
            body: '',
            image: _buildImage('streamline-gtf-hand-dryer'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Ultraviolet (UV) lamps do not kill the new coronavirus.",
            body: "",
            image: _buildImage('streamline-gtf-uv-lamp'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title:
                "Spraying alcohol or chlorine on your body does not kill the new coronavirus.",
            body: "",
            image: _buildImage('streamline-gtf-spray'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title:
                "Eating garlic does not prevent people from getting COVID-19.",
            body: "",
            image: _buildImage('streamline-gtf-garlic-2'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title:
                "Rinsing the nose with saline does not prevent people from getting COVID-19.",
            body: "",
            image: _buildImage('streamline-gtf-pneumonia-vaccine'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title:
                "Thermal scanners cannot detect if people are infected with COVID-19 when they do not have a fever.",
            body: "",
            image: _buildImage('streamline-gtf-thermal-scanner'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "The new coronavirus affects people of all ages.",
            body: "",
            image: _buildImage('streamline-gtf-elderly'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Antibiotics do not prevent or treat COVID-19.",
            body: "",
            image: _buildImage('streamline-gtf-antibiotics'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title:
                "Currently, there's no medicine that's recommended for preventing or treating the new coronavirus.",
            body: "",
            image: _buildImage('streamline-gtf-medicines'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Beaware of Online Scams",
            bodyWidget: Precautions(),
            // image: _buildImage('streamline-gtf-medicines'),
            decoration: de,
          ),
        ],

        onDone: () => {},

        // onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        // showSkipButton: true,
        skipFlex: 8,
        nextFlex: 15,

        // skip: const Text('Skip'),
        done: const Icon(
          Icons.arrow_forward,
          color: Colors.grey,
        ),
        // onSkip: () {},
        // showSkipButton: true,
        dotsFlex: 0,

        next: const Icon(Icons.arrow_forward),
        dotsDecorator: DotsDecorator(
          size: Size(7.0, 8.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 9.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
      ),
    );
  }
}
