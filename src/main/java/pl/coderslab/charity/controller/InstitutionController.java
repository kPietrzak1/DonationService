package pl.coderslab.charity.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import pl.coderslab.charity.services.InstitutionService;

@Controller
@RequestMapping("/institutions")
public class InstitutionController {

    @Autowired
    private InstitutionService institutionService;

    @GetMapping
    public String listInstitutions(Model model) {
        model.addAttribute("institutions", institutionService.getAllInstitutions());
        return "index";
    }
}
