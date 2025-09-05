package com.app.awktest.config;

import io.micrometer.core.instrument.MeterRegistry;
import org.springframework.context.annotation.Configuration;

@Configuration
public class MetricsConfig {
    public MetricsConfig(MeterRegistry registry) {
        registry.config().commonTags("application", "spring-traffic-demo");
    }
}
