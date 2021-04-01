package com.ats.adminpanel.model.einv;

public class PayDetails {
	/// <summary>
    ///  "Payee Name"
    /// </summary>
    public String Nm ;
    /// <summary>
    /// "Bank account number of payee"
    /// </summary>
    public String AcctDet ;
    /// <summary>
    /// "Mode of Payment: Cash, Credit, Direct Transfer"
    /// </summary>
    public String Mode ;
    /// <summary>
    /// "Branch or IFSC code"
    /// </summary>
    public String FinInsBr ;
    /// <summary>
    /// "Credit Transfer"
    /// </summary>
    public String CrTrn ;
    /// <summary>
    /// "Payment Instruction"
    /// </summary>
    public String PayInstr ;
    /// <summary>
    /// "Terms of Payment"
    /// </summary>
    public String PayTerm ;
    /// <summary>
    /// "Direct Debit"
    /// </summary>
    public String DirDr ;
    /// <summary>
    /// "Credit Days"
    /// </summary>
    public int CrDay ;
    /// <summary>
    /// "The sum of amount which have been paid in advance."
    /// </summary>
    public double PaidAmt ;
    /// <summary>
    /// "Outstanding amount that is required to be paid."
    /// </summary>
    public double PaymtDue ;
	public String getNm() {
		return Nm;
	}
	public void setNm(String nm) {
		Nm = nm;
	}
	public String getAcctDet() {
		return AcctDet;
	}
	public void setAcctDet(String acctDet) {
		AcctDet = acctDet;
	}
	public String getMode() {
		return Mode;
	}
	public void setMode(String mode) {
		Mode = mode;
	}
	public String getFinInsBr() {
		return FinInsBr;
	}
	public void setFinInsBr(String finInsBr) {
		FinInsBr = finInsBr;
	}
	public String getCrTrn() {
		return CrTrn;
	}
	public void setCrTrn(String crTrn) {
		CrTrn = crTrn;
	}
	public String getPayInstr() {
		return PayInstr;
	}
	public void setPayInstr(String payInstr) {
		PayInstr = payInstr;
	}
	public String getPayTerm() {
		return PayTerm;
	}
	public void setPayTerm(String payTerm) {
		PayTerm = payTerm;
	}
	public String getDirDr() {
		return DirDr;
	}
	public void setDirDr(String dirDr) {
		DirDr = dirDr;
	}
	public int getCrDay() {
		return CrDay;
	}
	public void setCrDay(int crDay) {
		CrDay = crDay;
	}
	public double getPaidAmt() {
		return PaidAmt;
	}
	public void setPaidAmt(double paidAmt) {
		PaidAmt = paidAmt;
	}
	public double getPaymtDue() {
		return PaymtDue;
	}
	public void setPaymtDue(double paymtDue) {
		PaymtDue = paymtDue;
	}
	@Override
	public String toString() {
		return "PayDetails [Nm=" + Nm + ", AcctDet=" + AcctDet + ", Mode=" + Mode + ", FinInsBr=" + FinInsBr
				+ ", CrTrn=" + CrTrn + ", PayInstr=" + PayInstr + ", PayTerm=" + PayTerm + ", DirDr=" + DirDr
				+ ", CrDay=" + CrDay + ", PaidAmt=" + PaidAmt + ", PaymtDue=" + PaymtDue + "]";
	}
    
    
}
