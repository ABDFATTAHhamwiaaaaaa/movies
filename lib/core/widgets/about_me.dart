import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutMeIcon extends StatelessWidget {
  const AboutMeIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          showAdaptiveDialog(
              context: context,
              builder: (context) {
                return const AboutMeDialog();
              });
        },
        child: SvgPicture.asset('assets/about.svg'),
      ),
    );
  }
}

class AboutMeDialog extends StatelessWidget {
  const AboutMeDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * .6,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Expanded(flex: 1, child: Image.asset('assets/splash.png')),
                  const Expanded(
                    flex: 2,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'MOVIZONE PROJECT',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'App Version:',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '1.0.0',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Develpoer:',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Abd Alfattah Hamwi',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Github:',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse('https://github.com/dev-OmarKaialy'));
                    },
                    child: const Text(
                      'dev.Abdfattahhamwi',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff12cdd9),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff12cdd9),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Telegram Channel:',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse('https://t.me/AFH_Hamwi'));
                    },
                    child: const Text(
                      '@AFH_Hamwi',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff12cdd9),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff12cdd9),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close')),
            ],
          ),
        ),
      ),
    );
  }
}
