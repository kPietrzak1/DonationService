package pl.coderslab.charity.model;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Entity
@Data
public class Donation {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    private Integer quantity;
    @ManyToMany
    @JoinTable(name = "donation_category",
            joinColumns = @JoinColumn(name = "donation_id"),
            inverseJoinColumns = @JoinColumn(name = "category_id"))
    private List<Category> categories;

    @ManyToOne
    @JoinColumn(name = "institution_id")
    private pl.coderslab.charity.model.Institution institution;
    @NotEmpty
    private String street;
    @NotEmpty
    private String city;
    @Pattern(regexp = "[0-9]{5}")
    private String zipCode;
    @FutureOrPresent
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate pickUpDate;
    @NotNull
    private LocalTime pickUpTime;
    @Size(max = 250)
    private String pickUpComment;

}
