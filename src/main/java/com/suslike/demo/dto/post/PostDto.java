package com.suslike.demo.dto.post;

import com.suslike.demo.dto.user.UserDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PostDto {
    private Long id;
    private String image;
    private String content;
    private UserDto owner;
    private String postedTime;
    private Integer likesNum;
}
