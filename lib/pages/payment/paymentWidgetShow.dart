import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homealone/model/payment/TransactionShowModel.dart';
import 'package:intl/intl.dart';

class PaymentWidgetShow{

  Column columnShowRent(Payment pay) {
    return Column(
      children: [
        SizedBox(
          height: 6,
        ),
        Text(
            "ค่าเช่าประจำเดือน ${DateFormat('MMMM-yyyy', 'th').format(pay.installment)}"),
        SizedBox(
          height: 8,
        ),
        Text("จำนวนเงิน ${pay.payHouseAmount} บาท"),
        SizedBox(
          height: 8,
        ),
        Text(
          "วันที่ชำระ ${DateFormat('dd-MMMM-yyyy', 'th').format(DateTime.parse(pay.payHouseDate.toString()))}",
          style: TextStyle(),
        ),
        Text(
          "หมดเขตชำระ ${DateFormat('dd-MMMM-yyyy', 'th').format(pay.payHouseEnd)}",
          style: TextStyle(color: Colors.red),
        ),
        SizedBox(
          height: 6,
        ),
        Expanded(
          child: (pay.payHouseImg != null)
              ? Image.network(
            pay.payHouseImg,
            // width: 150,
            // height: ,
            fit: BoxFit.fitHeight,
          )
              : Container(),
        )
      ],
    );
  }

  Column columnShowWater(Payment pay) {
    return Column(
      children: [
        SizedBox(
          height: 6,
        ),
        Text(
            "ค่าเช่าประจำเดือน ${DateFormat('MMMM-yyyy', 'th').format(pay.payWaterInmonth)}"),
        SizedBox(
          height: 8,
        ),
        Text("จำนวนเงิน ${pay.payWaterAmount} บาท"),
        SizedBox(
          height: 8,
        ),
        Text(
          "วันที่ชำระ ${DateFormat('dd-MMMM-yyyy', 'th').format(DateTime.parse(pay.payWaterDate.toString()))}",
          style: TextStyle(),
        ),
        Text(
          "หมดเขตชำระ ${DateFormat('dd-MMMM-yyyy', 'th').format(pay.payWaterEnd)}",
          style: TextStyle(color: Colors.red),
        ),
        SizedBox(
          height: 6,
        ),
        Expanded(
          child: (pay.payWaterImg != null)
              ? Image.network(
            pay.payWaterImg,
            // width: 150,
            // height: ,
            fit: BoxFit.fitHeight,
          )
              : Container(),
        )
      ],
    );
  }

  Column columnShowElec(Payment pay) {
    return Column(
      children: [
        SizedBox(
          height: 6,
        ),
        Text(
            "ค่าเช่าประจำเดือน ${DateFormat('MMMM-yyyy', 'th').format(pay.payElecInmonth)}"),
        SizedBox(
          height: 8,
        ),
        Text("จำนวนเงิน ${pay.payElecAmount} บาท"),
        SizedBox(
          height: 8,
        ),
        Text(
          "วันที่ชำระ ${DateFormat('dd-MMMM-yyyy', 'th').format(DateTime.parse(pay.payElecDate.toString()))}",
          style: TextStyle(),
        ),
        Text(
          "หมดเขตชำระ ${DateFormat('dd-MMMM-yyyy', 'th').format(pay.payElecEnd)}",
          style: TextStyle(color: Colors.red),
        ),
        SizedBox(
          height: 6,
        ),
        Expanded(
          child: (pay.payElecImg != null)
              ? Image.network(
            pay.payElecImg,
            // width: 150,
            // height: ,
            fit: BoxFit.fitHeight,
          )
              : Container(),
        )
      ],
    );
  }
}