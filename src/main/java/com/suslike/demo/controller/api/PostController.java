package com.suslike.demo.controller.api;

import com.suslike.demo.AuthAdapter;
import com.suslike.demo.dto.post.PostDto;
import com.suslike.demo.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController("restPost")
@RequiredArgsConstructor
@RequestMapping("api/post")
public class PostController {
    private final PostService service;
    private final AuthAdapter adapter;


    @GetMapping("/{postImage}")
    public ResponseEntity<InputStreamResource> getPostImage(@PathVariable String postImage){
       return service.getPostImage(postImage);
    }

    @GetMapping("/get/{id}")
    public ResponseEntity<PostDto> getPostsById(@PathVariable Long id){
        return ResponseEntity.ok(service.getPostById(id));
    }
    
    @DeleteMapping("{id}")
    public ResponseEntity<Void> deletePost(@PathVariable Long id){
        service.deletePost(id);
        return ResponseEntity.noContent().build();
    }
}
