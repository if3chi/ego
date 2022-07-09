import 'package:flutter/material.dart';
import 'package:ego/util/constants.dart';
import 'package:ego/util/app_colors.dart';
import 'package:ego/util/ui_helpers.dart';
import 'package:ego/widgets/ego_text.dart';
import 'package:ego/services/app_info.dart';

class About extends StatelessWidget {
  const About({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => const AboutEgoDialog()),
        icon: const Icon(
          Icons.info_outline,
          color: kMediumGreyColor,
        ));
  }
}

class AboutEgoDialog extends StatefulWidget {
  const AboutEgoDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<AboutEgoDialog> createState() => _AboutEgoDialogState();
}

class _AboutEgoDialogState extends State<AboutEgoDialog> {
  @override
  void initState() {
    super.initState();
    setDetails();
  }

  String appName = '';
  String appVersion = '';
  String body = '';
  Function? visitUrlFn;

  void setDetails() async {
    var appInfo = await AppInfo.getDetails;
    setState(() {
      appName = appInfo.name.toUpperCase();
      appVersion = appInfo.version;
      body = appInfo.body;
      visitUrlFn = appInfo.openLink;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: screenWidthPercent(context),
                margin: EdgeInsets.symmetric(
                    horizontal: screenHeightPercent(context, percentage: 0.04)),
                padding: const EdgeInsets.only(
                    top: 32, right: 16, left: 16, bottom: 12),
                decoration: BoxDecoration(
                    color: kSwatch0,
                    border: Border.all(color: kMediumGreyColor),
                    borderRadius: BorderRadius.circular(24)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    vSpaceSmall,
                    EgoText.headline(appName,
                        align: TextAlign.center, color: kMediumGreyColor),
                    EgoText.caption(appVersion,
                        align: TextAlign.center, color: kMediumGreyColor),
                    vSpaceMedium,
                    EgoText.body(
                      body,
                      align: TextAlign.justify,
                    ),
                    vSpaceXLarge,
                    EgoText.subheading("Author", color: kMediumGreyColor),
                    EgoText.body('Ifechi'),
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await visitUrlFn!();
                        },
                        child: EgoText.action(
                          'View my Profile',
                          color: kSwatch4,
                        )),
                    vSpaceLarge,
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: EgoText.action('close'))
                  ],
                ),
              ),
              Positioned(
                  top: -28,
                  child: CircleAvatar(
                      minRadius: 16,
                      maxRadius: 28,
                      backgroundColor: kPrimaryColor,
                      child: appLogo))
            ]));
  }
}
