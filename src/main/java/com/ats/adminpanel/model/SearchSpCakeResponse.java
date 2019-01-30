package com.ats.adminpanel.model;
import com.ats.adminpanel.model.manspbill.SpecialCake;

public class SearchSpCakeResponse {
ErrorMessage errorMessage;
SpecialCake specialCake;
public ErrorMessage getErrorMessage() {
	return errorMessage;
}
public void setErrorMessage(ErrorMessage errorMessage) {
	this.errorMessage = errorMessage;
}
public SpecialCake getSpecialCake() {
	return specialCake;
}
public void setSpecialCake(SpecialCake specialCake) {
	this.specialCake = specialCake;
}
@Override
public String toString() {
	return "SearchSpCakeResponse [errorMessage=" + errorMessage + ", specialCake=" + specialCake + "]";
}

}
