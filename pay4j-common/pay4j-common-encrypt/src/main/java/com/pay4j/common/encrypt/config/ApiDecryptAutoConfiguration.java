package com.pay4j.common.encrypt.config;

import jakarta.servlet.DispatcherType;
import com.pay4j.common.encrypt.filter.CryptoFilter;
import com.pay4j.common.encrypt.properties.ApiDecryptProperties;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.web.servlet.FilterRegistration;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;

/**
 * api 解密自动配置
 *
 * @author wdhcr
 */
@AutoConfiguration
@EnableConfigurationProperties(ApiDecryptProperties.class)
@ConditionalOnProperty(value = "api-decrypt.enabled", havingValue = "true")
public class ApiDecryptAutoConfiguration {

    @Bean
    @FilterRegistration(
        name = "cryptoFilter",
        urlPatterns = "/*",
        order = FilterRegistrationBean.HIGHEST_PRECEDENCE,
        dispatcherTypes = DispatcherType.REQUEST
    )
    public CryptoFilter cryptoFilter(ApiDecryptProperties properties) {
        return new CryptoFilter(properties);
    }

}
