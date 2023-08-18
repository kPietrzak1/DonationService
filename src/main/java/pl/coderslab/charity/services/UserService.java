package pl.coderslab.charity.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.coderslab.charity.model.User;
import pl.coderslab.charity.repository.UserRepository;

import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public void registerUser(String email, String password) throws Exception {
        if (userRepository.findByEmail(email).isPresent()) {
            throw new Exception("Email already exists");
        }

        User user = new User();
        user.setEmail(email);
        user.setPassword(password);
        userRepository.save(user);
    }

    public User authenticateUser(String email, String password) {
        Optional<User> userOpt = userRepository.findByEmailAndPassword(email, password);

        return userOpt.orElse(null);
    }

}

