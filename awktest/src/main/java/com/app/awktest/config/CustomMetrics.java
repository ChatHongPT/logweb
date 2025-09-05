package com.app.awktest.config;

import io.micrometer.core.instrument.Counter;
import io.micrometer.core.instrument.MeterRegistry;
import org.springframework.stereotype.Component;

@Component
public class CustomMetrics {

    private final Counter apiHitCounter;

    public CustomMetrics(MeterRegistry registry) {
        this.apiHitCounter = Counter.builder("custom_api_hits_total")
                .description("Total API Hits")
                .register(registry);
    }

    public void incrementApiHits() {
        apiHitCounter.increment();
    }
}
