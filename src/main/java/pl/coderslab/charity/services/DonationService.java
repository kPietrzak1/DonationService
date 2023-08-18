package pl.coderslab.charity.services;

import org.springframework.stereotype.Service;
import pl.coderslab.charity.model.Donation;
import pl.coderslab.charity.repository.DonationRepository;

@Service
public class DonationService {


    private final DonationRepository donationRepository;

    public DonationService(DonationRepository donationRepository) {
        this.donationRepository = donationRepository;
    }

    public Donation save(Donation donation) {
        return donationRepository.save(donation);
    }

    public Long getSumOfAllBags(){
        return donationRepository.sumOfAllBags();
    }

    public Long getOfAll(){
        return donationRepository.count();
    }

}

