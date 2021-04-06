import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swe_loan_calculator/controller/TotalVisualisationController.dart' as totalvisualisationcontroller;
import 'package:swe_loan_calculator/controller/LoanController.dart' as loancontroller;
import 'package:swe_loan_calculator/view/LoanCalSliderView.dart' as loancalsliderview;

///boundary class that shows the total component of the loan visualisation
class TotalVisualisationView extends State<totalvisualisationcontroller.TotalVisualisationController> {
  ///datamap used to store the values to be displayed by the piechart.
  Map<String, double> dataMap = {
    "Loan Amount ": loancontroller.LoanController.calculateTotalLoanAmount(loancalsliderview.LoanCalSliderView.getPrincipalValue(), loancalsliderview.LoanCalSliderView.getLoan()),
    "Down Payment ": loancontroller.LoanController.calculateDownPayment(loancalsliderview.LoanCalSliderView.getPrincipalValue(), loancalsliderview.LoanCalSliderView.getLoan()),};
  ///method used to build the widget to visualise the monthly payment component of the loan visualisation.
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Total Payment Breakdown',style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),),
        Container(
            decoration: BoxDecoration(border: Border.all()),
            padding: EdgeInsets.all(20),
            child:
            Container(
                child: PieChart(
                    dataMap: dataMap,
                    chartType: ChartType.ring,
                    chartRadius: 130,
                    animationDuration: Duration(milliseconds: 500),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValuesOutside: true,
                    ),
                    legendOptions: LegendOptions(
                      legendTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
                    ),
                    centerText:'\$' + loancalsliderview.LoanCalSliderView.getPrincipalValue().toStringAsFixed(2)
                )
            )
        ),
      ],
    );

  }
}