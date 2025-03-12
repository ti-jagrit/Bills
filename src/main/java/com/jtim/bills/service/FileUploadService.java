package com.jtim.bills.service;

import org.springframework.web.multipart.MultipartFile;

public interface FileUploadService {
	public boolean uploadImage(MultipartFile image, String dir);
	public static final String UPLOAD_DIR = System.getProperty("user.dir") + "/uploads";

			

}
