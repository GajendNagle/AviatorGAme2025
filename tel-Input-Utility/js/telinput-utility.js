var input = document.querySelector("#phone1");
const message = document.querySelector("#message");

const iti = window.intlTelInput(input, {
    initialCountry: "auto",
    separateDialCode: true,
    geoIpLookup: callback => {
        fetch('https://ipapi.co/json')
            .then(res => res.json())
            .then(data => callback(data.country_code))
            .catch(() => callback("us"));
    },
    utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@18.1.1/build/js/utils.js"
});

input.addEventListener("open:countrydropdown", () => {
    const countryList = document.querySelector(".iti__country-list");

    if (!document.querySelector(".iti__search-container")) {
        const searchWrapper = document.createElement("li");
        searchWrapper.className = "iti__search-container";
        searchWrapper.innerHTML = `<input type="text" id="countrySearchInput" class="iti__search-input" placeholder="Search country or code..." autocomplete="off">`;

        countryList.insertBefore(searchWrapper, countryList.firstChild);

        const searchInput = document.getElementById("countrySearchInput");
        searchInput.focus();

        searchInput.addEventListener("click", e => e.stopPropagation());
        searchInput.addEventListener("keydown", e => e.stopPropagation());

        searchInput.addEventListener("input", function () {
            const term = this.value.toLowerCase();
            const countries = countryList.querySelectorAll(".iti__country");

            let found = false;
            countries.forEach((country, i) => {
                const name = country.querySelector(".iti__country-name")?.textContent?.toLowerCase() || "";
                const dial = country.querySelector(".iti__dial-code")?.textContent?.toLowerCase() || "";

                const match = name.includes(term) || dial.includes(term);
                country.style.display = match ? "block" : "none";

                country.classList.remove("highlight");
                if (match && !found) {
                    country.classList.add("highlight");
                    country.scrollIntoView({ block: "nearest" });
                    found = true;
                }
            });
        });

        searchInput.addEventListener("keydown", function (e) {
            const visibleCountries = Array.from(countryList.querySelectorAll(".iti__country"))
                .filter(c => c.style.display !== "none");
            let index = visibleCountries.findIndex(c => c.classList.contains("highlight"));

            if (e.key === "ArrowDown") {
                e.preventDefault();
                if (index < visibleCountries.length - 1) {
                    visibleCountries[index]?.classList.remove("highlight");
                    visibleCountries[index + 1].classList.add("highlight");
                    visibleCountries[index + 1].scrollIntoView({ block: "nearest" });
                }
            } else if (e.key === "ArrowUp") {
                e.preventDefault();
                if (index > 0) {
                    visibleCountries[index]?.classList.remove("highlight");
                    visibleCountries[index - 1].classList.add("highlight");
                    visibleCountries[index - 1].scrollIntoView({ block: "nearest" });
                }
            } else if (e.key === "Enter" && index !== -1) {
                e.preventDefault();
                visibleCountries[index].click();
                input.focus();
            }
        });
    } else {
        const searchInput = document.getElementById("countrySearchInput");
        searchInput.value = "";
        searchInput.focus();

        const countries = countryList.querySelectorAll(".iti__country");
        countries.forEach(c => {
            c.style.display = "block";
            c.classList.remove("highlight");
        });
    }
});

input.addEventListener("blur", () => {

    const countryInfo = iti.getSelectedCountryData();
    const fullNumber = iti.getNumber();
    const numberWithoutCode = input.value.trim();

    if (numberWithoutCode) {
        if (iti.isValidNumber()) {
            const countryName = countryInfo.name.replace(/\s\([^\)]*\)/, "");
            // Fix to display only the English country name
            message.innerHTML = `
                            <span class="valid">✔ Valid number</span>
                          `;
            message.className = "validation-message valid";

            // Set hidden inputs with the corresponding values
            document.getElementById("countryCode").value = "+" + countryInfo.dialCode;
            document.getElementById("Country_input").value = countryName;

        } else {
            message.textContent = "✖ Invalid number";
            message.className = "validation-message invalid";
        }
    } else {
        message.textContent = "";
        message.className = "validation-message";
    }
});