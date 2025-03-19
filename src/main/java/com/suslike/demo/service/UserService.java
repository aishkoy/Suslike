package com.suslike.demo.service;

import com.suslike.demo.dao.UserDao;
import com.suslike.demo.dto.user.UserAddDto;
import com.suslike.demo.dto.user.UserDto;
import com.suslike.demo.dto.user.UserEditDto;
import com.suslike.demo.model.UserModel;
import com.suslike.demo.util.FileUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService {
    private final UserDao dao;
    private final PasswordEncoder passwordEncoder;

    public UserDto getUserByEmail(String email){
        UserModel userModel =  dao.getUserByEmail(email).orElseThrow(()->new NoSuchElementException("could not find user by email: "+email));
        return getUserDto(userModel);
    }

    public UserDto getUserByUsername(String username) {
        UserModel userModel = dao.getUserByUsername(username).orElseThrow(() -> new NoSuchElementException("Could not find user with username: " + username));
        return getUserDto(userModel);
    }

    private UserDto getUserDto(UserModel u){
        return UserDto.builder()
                .email(u.getEmail())
                .name(u.getName())
                .surname(u.getSurname())
                .gender(u.getGender())
                .username(u.getUsername())
                .avatar(u.getAvatar())
                .aboutMe(u.getAboutMe())
                .build();
    }
    
    
    public void editUser(UserEditDto edit, String email) {
        UserModel user = UserModel.builder()
                .email(email)
                .name(edit.getName())
                .surname(edit.getSurname())
                .username(edit.getUsername())
                .gender(edit.getGender())
                .aboutMe(edit.getAboutMe())
                .build();
        dao.editUser(user);
    }

    public Boolean userIsExist(String email) {
        return dao.getUserByEmail(email).isPresent();
    }

    public void addUser(UserAddDto dto) throws Exception {
        if (! userIsExist(dto.getEmail())) {
            dao.createUser(UserModel.builder()
                    .email(dto.getEmail())
                    .username(dto.getUsername())
                    .name(dto.getName())
                    .surname(dto.getSurname())
                    .avatar("defaultAvatar.jpg")
                    .gender(dto.getGender())
                    .password(passwordEncoder.encode(dto.getPassword()))
                    .build());
            try {
                dao.addAuthority(dto.getEmail(), "USER");
            } catch (IllegalArgumentException isae) {
                throw new Exception("Account type not found");
            }
        } else throw new IllegalArgumentException("User already exists!");

    }

    public ResponseEntity<InputStreamResource> downloadImage(String name) {
        return FileUtil.getOutputFile(name, "/images");
    }
    
    public List<UserDto> getAllFollowers(String username) {
        return dao.getAllFollowers(getEmail(username)).stream().map(this :: getUserDto).collect(Collectors.toList());
    }
    
    public List<UserDto> getAllFollowings(String username) {
        return dao.getAllFollowings(getEmail(username)).stream().map(this :: getUserDto).collect(Collectors.toList());
    }
    
    private String getEmail(String username) {
        return dao.getUserByUsername(username)
                .map(UserModel :: getEmail)
                .filter(e -> ! e.isEmpty())
                .orElseThrow(IllegalArgumentException :: new);
    }

    public List<UserDto> searchByUsernameOrEmail(String search) {
        return dao.searchByUsernameOrEmail(search).stream().map(this::getUserDto).collect(Collectors.toList());
    }
    
    public void addAvatar(MultipartFile avatar, String authUserName) {
        if (dao.getUserByEmail(authUserName).isEmpty()) throw new NoSuchElementException("User not found: " + authUserName);
        
        long maxFileSizeBytes = 3 * 1024 * 1024;
        if (avatar.getSize() > maxFileSizeBytes)
            throw new IllegalArgumentException("File size exceeds the maximum allowed size (3MB)");
        
        String fileName = FileUtil.saveUploadedFile(avatar, "img");
        
        dao.saveAvatar(fileName, authUserName);
        
        log.info("Avatar saved for user: {}", authUserName);
    }
    
    
}

