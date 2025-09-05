package  com.app.awktest.controller;

import com.app.awktest.config.CustomMetrics;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TrafficController {

    private final CustomMetrics customMetrics;

    public TrafficController(CustomMetrics customMetrics) {
        this.customMetrics = customMetrics;
    }

    @GetMapping("/hello")
    public String hello() {
        customMetrics.incrementApiHits(); // 요청 들어올 때마다 카운트 증가
        return "Hello Prometheus!";
    }
}
