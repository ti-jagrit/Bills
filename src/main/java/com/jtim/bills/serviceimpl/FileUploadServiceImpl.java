package com.jtim.bills.serviceimpl;


import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.jtim.bills.service.FileUploadService;

import java.io.File;


@Service
public class FileUploadServiceImpl implements FileUploadService {

    
    @Override
    public boolean uploadImage(MultipartFile image, String dir) {
        File uploadDir = new File(UPLOAD_DIR+"/"+dir);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // Create directory if it doesn't exist
        }

        String uploadPath = uploadDir.getAbsolutePath() +"/"+image.getOriginalFilename();
        File uploadFile = new File(uploadPath);

        try {
            image.transferTo(uploadFile); // Save the file
            return true;
        } catch (Exception e) {
            System.out.println("Error:"+e.getMessage());
        }
        return false;
    }
}

