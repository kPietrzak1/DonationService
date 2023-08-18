package pl.coderslab.charity.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pl.coderslab.charity.model.Donation;
import pl.coderslab.charity.repository.CategoryRepository;
import pl.coderslab.charity.repository.DonationRepository;
import pl.coderslab.charity.repository.InstitutionRepository;
import pl.coderslab.charity.services.CategoryService;
import pl.coderslab.charity.services.DonationService;
import pl.coderslab.charity.services.InstitutionService;

import javax.validation.Valid;
import java.util.List;

@Controller
public class DonationController {
    private final CategoryRepository categoryRepository;
    private final InstitutionRepository institutionRepository;
    private final DonationRepository donationRepository;

    @Autowired
    private DonationService donationService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private InstitutionService institutionService;

    public DonationController(CategoryRepository categoryRepository,
                              InstitutionRepository institutionRepository,
                              DonationRepository donationRepository) {
        this.categoryRepository = categoryRepository;
        this.institutionRepository = institutionRepository;
        this.donationRepository = donationRepository;
    }

    @GetMapping("/stats")
    public String showStats(Model model) {
        Long totalBags = donationRepository.sumOfAllBags();
        Long totalDonations = donationRepository.count();

        model.addAttribute("totalBags", totalBags);
        model.addAttribute("totalDonations", totalDonations);

        return "index";
    }

    @GetMapping("/donation")
    public String showDonationForm(Model model) {
        model.addAttribute("categories", categoryRepository.findAll());
        model.addAttribute("institutions", institutionRepository.findAll());
        model.addAttribute("donation", new Donation());
        return "form";
    }


    @PostMapping("/donation")
    public String processDonationForm(@Valid @ModelAttribute("donation") Donation donation, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("categories", categoryRepository.findAll());
            model.addAttribute("institutions", institutionRepository.findAll());
            return "form";
        }
        donationRepository.save(donation);
        return "redirect:/form";
    }

    @PostMapping("/donation/save")
    public String saveDonation(@ModelAttribute("donation") Donation donation) {
        donationRepository.save(donation);
        return "redirect:/donation/summary";
    }

    @GetMapping("/donation/summary")
    public String donationSummary(Model model) {
        Donation lastDonation = donationRepository.findTopByOrderByIdDesc();
        model.addAttribute("donation", lastDonation);
        return "donationSummary";
    }


    @GetMapping("/form")
    public String showForm(Model model) {
        model.addAttribute("categories", categoryService.getAllCategories());
        model.addAttribute("institutions", institutionService.getAllInstitutions());
        model.addAttribute("donation", new Donation());
        return "form";
    }

    @PostMapping
    public String processForm(@ModelAttribute("donation") Donation donation) {
        donationService.save(donation);
        return "redirect:/donation/confirmation";
    }

    @GetMapping("/confirmation")
    public String showConfirmation() {
        return "form-confirmation";
    }

    @PostMapping("/submit-donation")
    public String submitDonation(@ModelAttribute Donation donation,
                                 @RequestParam("categoryIds[]") List<Long> categoryIds,
                                 @RequestParam Long institutionId,
                                 Model model) {

        donation.setCategories(categoryService.getAllCategoriesByIds(categoryIds));
        donation.setInstitution(institutionService.getInstitutionById(institutionId));

        donationService.save(donation);

        return "form-confirmation";
    }

}
