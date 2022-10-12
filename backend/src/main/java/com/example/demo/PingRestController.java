package com.example.demo;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;
import java.util.HashMap;

@RestController
public class PingRestController {

  @RequestMapping(method = RequestMethod.GET, path = "/api/ping")
  public ResponseEntity<String> getPing() {
    return ResponseEntity.ok("pong");
  }

  @RequestMapping(method = RequestMethod.GET, path = "/api/welcome")
  public ResponseEntity<Map<String, String>> wishMe() {
    Map<String, String> resp = new HashMap<>();
    resp.put("welcome", "ashok");
    return ResponseEntity.ok(resp);
  }

}