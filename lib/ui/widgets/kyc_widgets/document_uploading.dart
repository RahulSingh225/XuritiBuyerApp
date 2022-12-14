import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xuriti/models/helper/service_locator.dart';

import '../../../logic/view_models/kyc_manager.dart';
import '../../theme/constants.dart';

class DocumentUploading extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  const DocumentUploading({required this.maxWidth, required this.maxHeight});

  @override
  Widget build(BuildContext context) {
    double h1p = maxHeight * 0.01;
    double h10p = maxHeight * 0.1;
    double w10p = maxWidth * 0.1;
    double w1p = maxWidth * 0.01;
    return Padding(
      padding: EdgeInsets.only(left: w1p * 6, right: w1p * 6, top: h1p * 1),
      child: Row(
        children: [
          InkWell(
            onTap: () async {
              Map<String, dynamic> fileSelection =
              await getIt<KycManager>().getImage();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    fileSelection['msg'],
                    style: TextStyle(
                        color: fileSelection['status'] == true
                            ? Colors.green
                            : Colors.red),
                  )));
            },
            child: Container(
              height: h1p * 6,
              width: w1p * 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colours.disabledText,
              ),
              child: Center(
                child: SvgPicture.asset("assets/images/kycImages/camera.svg",
                    height: h1p * 4),
              ),
            ),
          ),
          SizedBox(
            width: w1p * 3,
          ),
          InkWell(
            onTap: () async {
              Map<String, dynamic> fileSelection =
                  await getIt<KycManager>().selectFile();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    fileSelection['msg'],
                    style: TextStyle(
                        color: fileSelection['status'] == true
                            ? Colors.green
                            : Colors.red),
                  )));
            },
            child: Container(
              height: h1p * 6,
              width: w10p * 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colours.disabledText,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: w1p * 5, vertical: h1p * 2),
                child: const Text(
                  "Upload Document",
                  style: TextStyles.textStyle121,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
