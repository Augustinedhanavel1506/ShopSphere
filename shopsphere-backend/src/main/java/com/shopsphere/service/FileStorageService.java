package com.shopsphere.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Set;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.shopsphere.exception.InvalidFileException;

import jakarta.annotation.PostConstruct;

@Service
public class FileStorageService {

    private static final Set<String> ALLOWED_CONTENT_TYPES = Set.of(
            "image/png", "image/jpeg", "image/webp", "image/gif");

    @Value("${app.upload.dir}")
    private String uploadDir;

    private Path uploadPath;

    @PostConstruct
    public void init() throws IOException {
        uploadPath = Paths.get(uploadDir).toAbsolutePath().normalize();
        Files.createDirectories(uploadPath);
    }

    public String store(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new InvalidFileException("No file was uploaded");
        }
        if (!ALLOWED_CONTENT_TYPES.contains(file.getContentType())) {
            throw new InvalidFileException("Only PNG, JPEG, WEBP, and GIF images are allowed");
        }

        String extension = extractExtension(file.getOriginalFilename());
        String filename = UUID.randomUUID() + extension;

        try {
            Files.copy(file.getInputStream(), uploadPath.resolve(filename));
        } catch (IOException e) {
            throw new InvalidFileException("Failed to store file: " + e.getMessage());
        }

        return filename;
    }

    private String extractExtension(String originalFilename) {
        if (originalFilename == null) {
            return "";
        }
        int dotIndex = originalFilename.lastIndexOf('.');
        return dotIndex >= 0 ? originalFilename.substring(dotIndex).toLowerCase() : "";
    }
}
