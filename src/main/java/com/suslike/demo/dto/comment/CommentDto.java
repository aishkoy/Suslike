package com.suslike.demo.dto.comment;

import com.suslike.demo.dto.user.UserDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CommentDto {
    private Long id;
    private Long postId;
    private UserDto commenter;
    private String content;
    private LocalDateTime commentedTime;
}
