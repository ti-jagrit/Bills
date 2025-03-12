package com.jtim.bills.serviceimpl;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Service;
import org.apache.tomcat.util.codec.binary.Base64;
import com.jtim.bills.service.PaymentService;

@Service
public class PaymentServiceimpl implements PaymentService {

	@SuppressWarnings("deprecation")
	@Override
	public String generateEsewaSignature(String secrect, String message) {
		String hash = "";
		try {
			Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
			SecretKeySpec secret_key = new SecretKeySpec(secrect.getBytes(), "HmacSHA256");
			sha256_HMAC.init(secret_key);
			hash = Base64.encodeBase64String(sha256_HMAC.doFinal(message.getBytes()));
		} catch (Exception e) {
			e.printStackTrace();

		}
		return hash;
	}

}
