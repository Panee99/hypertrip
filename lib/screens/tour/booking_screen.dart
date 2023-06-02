import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/tour/tour_detail_response.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:room_finder_flutter/utils/utilities.dart';

class BookingScreen extends StatefulWidget {
  final TourDetailResponse tour;
  const BookingScreen({super.key, required this.tour});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime selectedDate = DateTime.now();
  int _adultQuantity = 0;
  int _childrenQuantity = 0;
  int _babyQuantity = 0;
  double _totalPrice = 0;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            label: 'Total price',
            icon: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total price',
                  style: primaryTextStyle(size: 12, color: grey),
                ),
                Text(
                  NumberFormat('#,###').format(_totalPrice.toInt()).toString() +
                      ' VND',
                  style: boldTextStyle(size: 15, color: rf_primaryColor),
                ),
                Text(
                  'Surcharges are included',
                  style: primaryTextStyle(size: 12, color: grey),
                )
              ],
            ),
          ),
          BottomNavigationBarItem(
            label: 'Button',
            icon: AppButton(
              color: rf_primaryColor,
              disabledColor: disableButtonColor,
              elevation: 0,
              child: Text('Continue', style: boldTextStyle(color: white)),
              width: context.width(),
              height: 36,
              onTap: _adultQuantity == 0 &&
                      _childrenQuantity == 0 &&
                      _babyQuantity == 0
                  ? null
                  : () {},
            ).paddingSymmetric(horizontal: 16, vertical: 0),
          ),
          // BottomNavigationBarItem(
          //   label: 'surcharges are included',
          //   icon: Column(
          //     children: [
          //       Text(
          //         'Total price',
          //         style: TextStyle(fontSize: 12, color: Colors.grey),
          //       ),
          //       Text(
          //         NumberFormat('#,###').format(_totalPrice.toInt()).toString(),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
      appBar: commonAppBarWidget(context,
          title: Utilities.capitalizeWords(widget.tour.title.validate()),
          showLeadingIcon: true),
      body: Column(children: [
        Container(
          width: context.width(),
          decoration: BoxDecoration(
              color: whiteColor, borderRadius: BorderRadius.circular(8)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected date',
                  style: boldTextStyle(size: 12),
                ),
                8.height,
                Text(
                  DateFormat('dd/MM/yyyy').format(selectedDate),
                  style: primaryTextStyle(size: 16),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: SvgPicture.asset(
                calendar,
                height: 24,
                color: rf_primaryColor,
              ),
            )
          ]).paddingAll(16),
        ),
        16.height,
        chooseAdultQuantity(context),
        16.height,
        chooseChildrenQuantity(context),
        16.height,
        chooseBabyQuantity(context)
      ]).paddingAll(16),
    );
  }

  Container chooseAdultQuantity(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Adult (10 years old and up)',
              style: primaryTextStyle(size: 12, color: grey),
            ),
            8.height,
            Text(
              NumberFormat('#,###')
                      .format(widget.tour.adultPrice!.toInt())
                      .toString()
                      .validate() +
                  ' VND',
              style: boldTextStyle(size: 16),
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_adultQuantity == 0) {
                      _adultQuantity = 0;
                    } else {
                      _adultQuantity--;
                      _totalPrice = _adultQuantity *
                              widget.tour.adultPrice!.toDouble() +
                          _childrenQuantity *
                              widget.tour.childrenPrice!.toDouble() +
                          _babyQuantity * widget.tour.infantPrice!.toDouble();
                    }
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: whiteSmoke),
                  child: Transform.scale(
                    scale: 0.4,
                    child: SvgPicture.asset(
                      minus,
                      height: 16,
                    ),
                  ),
                ),
              ),
              8.width,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 50,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller:
                      TextEditingController(text: _adultQuantity.toString()),
                  onChanged: (value) {
                    setState(() {
                      _adultQuantity = int.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),
              8.width,
              GestureDetector(
                onTap: () {
                  setState(() {
                    _adultQuantity++;
                    _totalPrice =
                        _adultQuantity * widget.tour.adultPrice!.toDouble() +
                            _childrenQuantity *
                                widget.tour.childrenPrice!.toDouble() +
                            _babyQuantity * widget.tour.infantPrice!.toDouble();
                  });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: whiteSmoke),
                  child: Transform.scale(
                    scale: 0.4,
                    child: SvgPicture.asset(
                      plus,
                      height: 16,
                      color: rf_primaryColor,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ).paddingAll(16),
    );
  }

  Container chooseChildrenQuantity(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Children (5 - 9 years old)',
              style: primaryTextStyle(size: 12, color: grey),
            ),
            8.height,
            Text(
              NumberFormat('#,###')
                      .format(widget.tour.childrenPrice!.toInt())
                      .toString()
                      .validate() +
                  ' VND',
              style: boldTextStyle(size: 16),
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_childrenQuantity == 0) {
                      _childrenQuantity = 0;
                    } else {
                      _childrenQuantity--;
                      _totalPrice = _adultQuantity *
                              widget.tour.adultPrice!.toDouble() +
                          _childrenQuantity *
                              widget.tour.childrenPrice!.toDouble() +
                          _babyQuantity * widget.tour.infantPrice!.toDouble();
                    }
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: whiteSmoke),
                  child: Transform.scale(
                    scale: 0.4,
                    child: SvgPicture.asset(
                      minus,
                      height: 16,
                    ),
                  ),
                ),
              ),
              8.width,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 50,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller:
                      TextEditingController(text: _childrenQuantity.toString()),
                  onChanged: (value) {
                    setState(() {
                      _childrenQuantity = int.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),
              8.width,
              GestureDetector(
                onTap: () {
                  setState(() {
                    _childrenQuantity++;
                    _totalPrice =
                        _adultQuantity * widget.tour.adultPrice!.toDouble() +
                            _childrenQuantity *
                                widget.tour.childrenPrice!.toDouble() +
                            _babyQuantity * widget.tour.infantPrice!.toDouble();
                  });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: whiteSmoke),
                  child: Transform.scale(
                    scale: 0.4,
                    child: SvgPicture.asset(
                      plus,
                      height: 16,
                      color: rf_primaryColor,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ).paddingAll(16),
    );
  }

  Container chooseBabyQuantity(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Baby (Under 5 years old)',
              style: primaryTextStyle(size: 12, color: grey),
            ),
            8.height,
            Text(
              NumberFormat('#,###')
                      .format(widget.tour.infantPrice!.toInt())
                      .toString()
                      .validate() +
                  ' VND',
              style: boldTextStyle(size: 16),
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_babyQuantity == 0) {
                      _babyQuantity = 0;
                    } else {
                      _babyQuantity--;
                      _totalPrice = _adultQuantity *
                              widget.tour.adultPrice!.toDouble() +
                          _childrenQuantity *
                              widget.tour.childrenPrice!.toDouble() +
                          _babyQuantity * widget.tour.infantPrice!.toDouble();
                    }
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: whiteSmoke),
                  child: Transform.scale(
                    scale: 0.4,
                    child: SvgPicture.asset(
                      minus,
                      height: 16,
                    ),
                  ),
                ),
              ),
              8.width,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 50,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller:
                      TextEditingController(text: _babyQuantity.toString()),
                  onChanged: (value) {
                    setState(() {
                      _babyQuantity = int.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),
              8.width,
              GestureDetector(
                onTap: () {
                  setState(() {
                    _babyQuantity++;
                    _totalPrice =
                        _adultQuantity * widget.tour.adultPrice!.toDouble() +
                            _childrenQuantity *
                                widget.tour.childrenPrice!.toDouble() +
                            _babyQuantity * widget.tour.infantPrice!.toDouble();
                  });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: whiteSmoke),
                  child: Transform.scale(
                    scale: 0.4,
                    child: SvgPicture.asset(
                      plus,
                      height: 16,
                      color: rf_primaryColor,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ).paddingAll(16),
    );
  }
}
