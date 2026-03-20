package attence_system_backend.attence_system_backend.config;

import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;



@Configuration
public class SecurityConfig {

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowedOrigins(List.of("*")); // allow all origins
        config.setAllowedMethods(List.of("GET","POST","PUT","DELETE","OPTIONS"));
        config.setAllowedHeaders(List.of("*"));
        config.setExposedHeaders(List.of("*"));
        config.setAllowCredentials(false);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);
        return source;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .cors(cors -> cors.configurationSource(corsConfigurationSource()))
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                // Permit all OPTIONS requests (preflight)
                .requestMatchers(org.springframework.http.HttpMethod.OPTIONS, "/**").permitAll()
                 .requestMatchers("/api/**").permitAll()
                // Permit all API endpoints
                .requestMatchers("/api/employees/**").permitAll()
                .requestMatchers("/api/leaves/**").permitAll()
                .requestMatchers("/api/attendance/**").permitAll()
                .requestMatchers("/uploads/**").permitAll()

                .anyRequest().authenticated()
            )
            .formLogin(form -> form.disable())
            .httpBasic(httpBasic -> httpBasic.disable());

        return http.build();
    }
}


// @Configuration
// public class SecurityConfig {

//     @Bean
//     public BCryptPasswordEncoder passwordEncoder() {
//         return new BCryptPasswordEncoder();
//     }

//    @Bean
//     public CorsConfigurationSource corsConfigurationSource() {
//         CorsConfiguration config = new CorsConfiguration();

//         config.setAllowedOrigins(List.of("*")); // use this (NOT patterns)
//         config.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
//         config.setAllowedHeaders(List.of("*"));
//         config.setExposedHeaders(List.of("*"));

//         config.setAllowCredentials(false);

//         UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
//         source.registerCorsConfiguration("/**", config);

//         return source;
//     }

//     @Bean
//     public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
//         http
//                 .cors(cors -> cors.configurationSource(corsConfigurationSource())) 

//                 .csrf(csrf -> csrf.disable())

//                 .authorizeHttpRequests(auth -> auth
//                         // VERY IMPORTANT (fix 403)
//                         .requestMatchers(org.springframework.http.HttpMethod.OPTIONS, "/**").permitAll()
                        
//                         .requestMatchers("/api/employees/**").permitAll()
//                         .requestMatchers("/api/attendance/**").permitAll()
//                         .requestMatchers("/uploads/**").permitAll()

//                         .anyRequest().authenticated())
                
//                 .formLogin(form -> form.disable())
//                 .httpBasic(httpBasic -> httpBasic.disable());

//         return http.build();
//     }

// }
