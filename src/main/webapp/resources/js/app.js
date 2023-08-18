document.addEventListener("DOMContentLoaded", function () {
    /**
     * Form Select
     */

    class FormSelect {

        constructor($el) {

            this.$el = $el;
            this.options = [...$el.children];
            this.init();

        }


        init() {

            this.createElements();
            this.addEvents();
            this.$el.parentElement.removeChild(this.$el);

        }


        createElements() {

            // Input for value

            this.valueInput = document.createElement("input");
            this.valueInput.type = "text";
            this.valueInput.name = this.$el.name;


            // Dropdown container

            this.dropdown = document.createElement("div");
            this.dropdown.classList.add("dropdown");


            // List container

            this.ul = document.createElement("ul");


            // All list options

            this.options.forEach((el, i) => {

                const li = document.createElement("li");
                li.dataset.value = el.value;
                li.innerText = el.innerText;


                if (i === 0) {
                    // First clickable option

                    this.current = document.createElement("div");
                    this.current.innerText = el.innerText;
                    this.dropdown.appendChild(this.current);
                    this.valueInput.value = el.value;
                    li.classList.add("selected");
                }
                this.ul.appendChild(li);

            });
            this.dropdown.appendChild(this.ul);
            this.dropdown.appendChild(this.valueInput);
            this.$el.parentElement.appendChild(this.dropdown);
        }


        addEvents() {

            this.dropdown.addEventListener("click", e => {

                const target = e.target;

                this.dropdown.classList.toggle("selecting");

                // Save new value only when clicked on li

                if (target.tagName === "LI") {
                    this.valueInput.value = target.dataset.value;
                    this.current.innerText = target.innerText;
                }
            });
        }
    }


    document.querySelectorAll(".form-group--dropdown select").forEach(el => {
        new FormSelect(el);
    });


    /**
     * Hide elements when clicked on document
     */

    document.addEventListener("click", function (e) {

        const target = e.target;
        const tagName = target.tagName;

        if (target.classList.contains("dropdown")) return false;

        if (tagName === "LI" && target.parentElement.parentElement.classList.contains("dropdown")) {
            return false;
        }


        if (tagName === "DIV" && target.parentElement.classList.contains("dropdown")) {
            return false;
        }

        document.querySelectorAll(".form-group--dropdown .dropdown").forEach(el => {
            el.classList.remove("selecting");
        });
    });


    /**
     * Switching between form steps
     */

    class FormSteps {

        constructor(form) {

            this.$form = form;
            this.$next = form.querySelectorAll(".next-step");
            this.$prev = form.querySelectorAll(".prev-step");
            this.$step = form.querySelector(".form--steps-counter span");

            this.currentStep = 1;

            this.$stepInstructions = form.querySelectorAll(".form--steps-instructions p");

            const $stepForms = form.querySelectorAll("form > div, [data-step]");

            this.slides = [...this.$stepInstructions, ...$stepForms];


            this.data = {
                institution: null, quantity: undefined

            };
            this.init();
        }


        /**

         * Init all methods

         */

        init() {
            this.events();
            this.updateForm();

        }


        /**
         * All events that are happening in form
         */

        events() {

            // Next step

            this.$next.forEach(btn => {
                btn.addEventListener("click", e => {
                    e.preventDefault();
                    console.log("Next button clicked. Current step:", this.currentStep);
                    this.moveStep(this.currentStep + 1);
                });
            });


            // Previous step

            this.$prev.forEach(btn => {
                btn.addEventListener("click", e => {
                    e.preventDefault();
                    console.log("Prev button clicked. Current step:", this.currentStep);
                    this.moveStep(this.currentStep - 1);
                });
            });


            // Form submit

            this.$form.querySelector("form").addEventListener("submit", e => this.submit(e));
            const inputFields = this.$form.querySelectorAll('[data-step] input:not([type="checkbox"]), [data-step] select, [data-step] input[type="radio"]');

            inputFields.forEach(input => {

                input.addEventListener('change', (e) => {
                    if (e.target.name === "institutionId" && e.target.checked) {
                        this.data.institution = e.target.nextElementSibling.nextElementSibling.querySelector('.title').innerText;
                        console.log("Przypisano wartość do this.data.institution:", this.data.institution);
                    } else {
                        this.data[e.target.name] = e.target.value;
                    }
                });
            });


            const checkboxes = this.$form.querySelectorAll('[name="categoryIds[]"]');

            checkboxes.forEach(checkbox => {

                checkbox.addEventListener('change', (e) => {
                    const selectedCategories = [];
                    checkboxes.forEach(cb => {
                        if (cb.checked) {
                            selectedCategories.push(cb.nextElementSibling.nextElementSibling.innerText.trim());
                        }
                    });
                    this.data.categories = selectedCategories.join(', ');
                });
            });
        }


        /**
         * Update form front-end
         * Show next or previous section etc.
         */

        updateForm() {

            this.$step.innerText = this.currentStep;
            console.log("Updating form. Current step:", this.currentStep);

            // TODO: Validation
            this.slides.forEach(slide => {
                slide.style.display = 'none';
                slide.classList.remove("active");

                if (slide.dataset.step == this.currentStep) {
                    slide.style.display = '';
                    slide.classList.add("active");
                }
            });


            this.$stepInstructions[0].parentElement.parentElement.hidden = this.currentStep >= 5;
            this.$step.parentElement.hidden = this.currentStep >= 5;

            if (this.currentStep === 5) {
                this.showSummary();
            }
        }

        moveStep(stepNumber) {
            this.currentStep = stepNumber;
            this.updateForm();
        }

        showSummary() {

            for (const [key, value] of Object.entries(this.data)) {
                const summaryElement = this.$form.querySelector(`[data-summary="${key}"]`);
                if (summaryElement) {
                    if (Array.isArray(value)) {
                        summaryElement.innerText = value.join(', ');
                    } else {
                        summaryElement.innerText = value;
                    }
                }
            }


            const category = this.$form.querySelector(`[data-summary="category"]`);
            if (this.data.categories) {
                category.innerText = `${this.data.categories}`;
            }

            const bagsSummary = this.$form.querySelector(`[data-summary="description"]`);
            bagsSummary.innerText = `60L worków sztuk : ${this.data.quantity} `;

            const institutionSummary = this.$form.querySelector(`[data-summary="name"]`);
            if (institutionSummary && this.data.institution) {
                institutionSummary.innerText = `Dla ${this.data.institution}`;
            }

            const pickUpCommentInput = this.$form.querySelector('[name="pickUpComment"]');
            if (pickUpCommentInput) {
                this.data.pickUpComment = pickUpCommentInput.value;
            }

            const pickUpCommentSummary = this.$form.querySelector('[data-summary="pickUpComment"]');
            if (pickUpCommentSummary && this.data.pickUpComment) {
                pickUpCommentSummary.innerText = this.data.pickUpComment;
            }
            console.log("Data after step 3:", this.data);
        }
    }

    const form = document.querySelector(".form--steps");
    if (form !== null) {
        new FormSteps(form);
    }
});