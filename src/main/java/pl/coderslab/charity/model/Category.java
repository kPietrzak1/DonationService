package pl.coderslab.charity.model;

import lombok.*;

import javax.persistence.*;

@Entity
@Data
    public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;

}
