package com.suslike.demo.model;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor(access = AccessLevel.PRIVATE)
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public class UserModel {
    private String email;
    private String gender;
    private String name;
    private String surname;
    private String username;
    private String password;
    private String avatar;
    private String aboutMe;
    private Boolean enabled;
}
