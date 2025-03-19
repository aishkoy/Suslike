package com.suslike.demo.controller.api;


import com.suslike.demo.AuthAdapter;
import com.suslike.demo.dto.user.UserDto;
import com.suslike.demo.dto.user.UserEditDto;
import com.suslike.demo.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("restUser")
@RequiredArgsConstructor
@RequestMapping("api/user")
public class UserController {
    private final UserService userService;
    private final AuthAdapter authAdapter;
    
    
    @PostMapping("")
    public HttpStatus editUser(UserEditDto edit) {
        userService.editUser(edit, authAdapter.getAuthUserName());
        return HttpStatus.OK;
    }

    @GetMapping("/follower/{userUsername}")
    public ResponseEntity<List<UserDto>> getAllFollowers(@PathVariable String userUsername){
        List<UserDto> followers = userService.getAllFollowers(userUsername);
        return ResponseEntity.ok(followers);
    }

    @GetMapping("/followings/{userUsername}")
    public ResponseEntity<List<UserDto>> getAllFollowings(@PathVariable String userUsername){

        List<UserDto> followings = userService.getAllFollowings(userUsername);
        return ResponseEntity.ok(followings);
    }
}