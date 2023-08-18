package pl.coderslab.charity.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pl.coderslab.charity.model.Institution;
import pl.coderslab.charity.model.User;
import pl.coderslab.charity.services.CategoryService;
import pl.coderslab.charity.services.DonationService;
import pl.coderslab.charity.services.InstitutionService;
import pl.coderslab.charity.services.UserService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class UserController {

    private final UserService userService;
    private final DonationService donationService;
    private final InstitutionService institutionService;
    private final CategoryService categoryService;

    @Autowired
    public UserController(UserService userService, DonationService donationService, InstitutionService institutionService, CategoryService categoryService) {
        this.userService = userService;
        this.donationService = donationService;
        this.institutionService = institutionService;
        this.categoryService = categoryService;
    }

    @GetMapping("/register")
    public String showRegisterForm() {
        return "register";
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/register")
    public String register(@RequestParam String email, @RequestParam String password, @RequestParam String password2, Model model) {
        if (!password.equals(password2)) {
            model.addAttribute("error", "Passwords do not match.");
            return "register";
        }

        try {
            userService.registerUser(email, password);
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "register";
        }

        model.addAttribute("success", "Successfully registered. You can now log in.");
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, Model model, HttpSession session) {
        User user = userService.authenticateUser(email, password);
        Long totalBags = donationService.getSumOfAllBags();
        Long totalDonations = donationService.getOfAll();

        List<Institution> institutions = institutionService.getAllInstitutions();

        if (user == null) {
            model.addAttribute("error", "Invalid email or password.");
            return "login";
        }

        session.setAttribute("loggedInUser", user);

        model.addAttribute("totalBags", totalBags);
        model.addAttribute("institutions", institutions);
        model.addAttribute("totalDonations", totalDonations);
        model.addAttribute("categories", categoryService.getAllCategories());

        return "form";
    }
}
