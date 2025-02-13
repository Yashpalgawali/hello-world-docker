package com.in28minutes.rest.webservices.restfulwebservices;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldController {

    @GetMapping(path = "/")
    public String helloWorld() {
		// Implemented using String Templates
        return """
                { message: Hello World Java version 3 USING CANCHING V3}
               """;
    }
}
