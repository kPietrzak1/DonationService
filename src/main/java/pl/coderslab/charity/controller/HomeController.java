package pl.coderslab.charity.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import pl.coderslab.charity.model.Institution;
import pl.coderslab.charity.repository.DonationRepository;
import pl.coderslab.charity.repository.InstitutionRepository;

import java.util.List;

@Controller
public class HomeController {

    private final DonationRepository donationRepository;
    private final InstitutionRepository institutionRepository;

    public HomeController(DonationRepository donationRepository, InstitutionRepository institutionRepository) {
        this.donationRepository = donationRepository;
        this.institutionRepository = institutionRepository;
    }

    @RequestMapping("/")
    public String homeAction(Model model){
        Long totalBags = donationRepository.sumOfAllBags();
        Long totalDonations = donationRepository.count();

        List<Institution> institutions = institutionRepository.findAll();

        model.addAttribute("totalBags", totalBags);
        model.addAttribute("institutions", institutions);
        model.addAttribute("totalDonations", totalDonations);

        return "index";
    }
}
