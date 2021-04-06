import 'dart:math';

/// controller class that makes all the loan calculation
class LoanController{
  ///method used to calculate total loan amount
  static double calculateTotalLoanAmount(double principalValue, int loanValue){
    return (loanValue/100)*principalValue;
  }
  ///method used to calculate down payment amount
  static double calculateDownPayment(double principalValue, int loanValue ){
    return ((100-loanValue)/100)*principalValue;
  }
  ///method used to calculate monthly payment amount.
  static double calculateMonthlyPayment(double principalValue,double interestRate,int loanTenure,
      int loanValue){
    double totalLoanAmount = calculateTotalLoanAmount(principalValue, loanValue);
    return (totalLoanAmount*(interestRate))/(1-1/pow(1+interestRate,loanTenure))/12;
  }
  ///method used to calculate monthly interest amount
  static double calculateMonthlyInterest(double principalValue, double interestRate, int loanValue){
    double totalLoanAmount = calculateTotalLoanAmount(principalValue, loanValue);
    return (totalLoanAmount*interestRate)/12;
  }
  ///method used to calculate monthly loan amount
  static double calculateMonthlyLoanAmount(double principalValue, double interestRate,
      int loanTenure, int loanValue){
    return calculateMonthlyPayment(principalValue, interestRate, loanTenure,loanValue)-
        calculateMonthlyInterest(principalValue, interestRate,loanValue);
  }
}