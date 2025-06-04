package www.silver.util;

import java.text.ParseException;
import java.util.Locale;
import org.springframework.format.Formatter;

public class PhoneFormatter implements Formatter<String>{

	@Override
	public String print(String userPhoneNum, Locale locale) {
		// TODO Auto-generated method stub
		if(userPhoneNum==null || userPhoneNum.length() != 11) {
			return userPhoneNum;
		}
		return userPhoneNum.substring(0, 3)+"-"+
			   userPhoneNum.substring(3, 7)+"-"+
			   userPhoneNum.substring(7);
	}

	@Override
	public String parse(String text, Locale locale) throws ParseException {
		// TODO Auto-generated method stub
		return text.replaceAll("-", "");
	}

}
