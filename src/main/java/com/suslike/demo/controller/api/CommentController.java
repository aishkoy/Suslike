package com.suslike.demo.controller.api;

import com.suslike.demo.AuthAdapter;
import com.suslike.demo.dto.comment.CommentCreateDto;
import com.suslike.demo.dto.comment.CommentDto;
import com.suslike.demo.dto.user.UserDto;
import com.suslike.demo.service.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("restComment")
@RequiredArgsConstructor
@RequestMapping("api/comment")
public class CommentController {
    private final CommentService service;
    private final AuthAdapter adapter;

    @GetMapping("/{postId}")
    public ResponseEntity<List<CommentDto>> getAllCommentsBYPostId(@PathVariable Long postId) {
        return ResponseEntity.ok(service.getCommentsByPostId(postId));
    }

    @GetMapping("/last/{commentId}")
    public ResponseEntity<CommentDto> getNewAddedComment(@PathVariable Long commentId) {
        return ResponseEntity.ok(service.getCommentsLastCommentsByPost(commentId));
    }

    @PostMapping()
    public ResponseEntity<Long> addComment(@RequestBody CommentCreateDto dto) {
        UserDto user = adapter.getAuthUser();
        Long id = service.addComment(dto, user.getEmail());
        return ResponseEntity.ok(id);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Long> addComment(@PathVariable Long id) {
        UserDto user = adapter.getAuthUser();
        service.deleteComment(id,user.getEmail());
        return ResponseEntity.ok(id);
    }
}
