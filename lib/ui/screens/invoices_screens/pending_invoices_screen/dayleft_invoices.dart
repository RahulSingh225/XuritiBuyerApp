import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/theme/constants.dart';

class DayLeftInvoices extends StatefulWidget {
  const DayLeftInvoices({Key? key}) : super(key: key);

  @override
  State<DayLeftInvoices> createState() => _DayLeftInvoicesState();
}

class _DayLeftInvoicesState extends State<DayLeftInvoices> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return ExpansionTile(
        tilePadding: const EdgeInsets.only(
          left: 20,
          top: 25,
        ),
        trailing: Container(
          width: w10p * .001,
          height: h1p * .001,
          decoration: BoxDecoration(border: Border.all(color: Colours.white)),
        ),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colours.offWhite,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("#4321",style: TextStyles.textStyle6,),
                          SvgPicture.asset("assets/images/home_images/rightArrow.svg"),
                        ],
                      ),
                      const Text(
                        "Company Name",
                        style: TextStyles.textStyle59,
                      ),
                      const Text(
                        "You Save",
                        style: TextStyles.textStyle60,
                      ),
                      const Text(
                        "??? 545",
                        style: TextStyles.textStyle68,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "30 days left",
                        style: TextStyles.textStyle57,
                      ),
                      const Text(
                        "??? 1,42,345",
                        style: TextStyles.textStyle58,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, paynow);
                          },
                          child: SvgPicture.asset("assets/images/button.svg")),
                    ],
                  )
                ]),
          ),
        ),
        children: [
          Card(
            elevation: .5,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 25,
              ),
              child: Container(
                //decoration: BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Invoice Date",
                            style: TextStyles.textStyle62,
                          ),
                          Text(
                            "12.Jun.2022",
                            style: TextStyles.textStyle63,
                          ),
                          Text(
                            "Company Name",
                            style: TextStyles.textStyle64,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      SvgPicture.asset("assets/images/arrow.svg"),
                      const SizedBox(
                        width: 60,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Due Date",
                            style: TextStyles.textStyle62,
                          ),
                          Text(
                            "28.Jun.2022",
                            style: TextStyles.textStyle63,
                          ),
                          Text(
                            "Company Name",
                            style: TextStyles.textStyle64,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 25,
            ),
            child: Card(
              elevation: .5,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Invoice Amount",
                                style: TextStyles.textStyle62,
                              ),
                              Text(
                                "??? 1,42,345",
                                style: TextStyles.textStyle65,
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 145,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Pay Now",
                                style: TextStyles.textStyle62,
                              ),
                              Text(
                                "??? 1,41,800",
                                style: TextStyles.textStyle66,
                              ),
                            ],
                          ),
                        ],
                      ),
                      // SizedBox(height: h1p *6,),
                      Row(
                        children: const [
                          Text(
                            "You Save",
                            style: TextStyles.textStyle60,
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Text(
                            "??? 545",
                            style: TextStyles.textStyle68,
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, savemoreDetails);
                            },
                            child: Image.asset("assets/images/viewetails.png")),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
