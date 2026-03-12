package attence_system_backend.attence_system_backend.repository;


import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import attence_system_backend.attence_system_backend.models.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long>{
   Optional<User> findByEmail(String email);
}
