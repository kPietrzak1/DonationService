<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="header--form-page">
    <nav class="container container--70">
        <ul class="nav--actions">
            <li class="logged-user">
                Witaj <%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>
                <ul class="dropdown">
                    <li><a href="#">Profil</a></li>
                    <li><a href="#">Moje zbiórki</a></li>
                    <li><a href="/">Wyloguj</a></li>
                </ul>
            </li>
        </ul>

        <ul>
            <li><a href="/index" class="btn btn--without-border active">Start</a></li>
            <li><a href="/index.#steps" class="btn btn--without-border">O co chodzi?</a></li>
            <li><a href="/index.#about-us" class="btn btn--without-border">O nas</a></li>
            <li><a href="/index.#help" class="btn btn--without-border">Fundacje i organizacje</a></li>
            <li><a href="/index.#contact" class="btn btn--without-border">Kontakt</a></li>
        </ul>
    </nav>

    <div class="slogan container container--90">
        <div class="slogan--item">
            <h1>
                Oddaj rzeczy, których już nie chcesz<br />
                <span class="uppercase">potrzebującym</span>
            </h1>

            <div class="slogan--steps">
                <div class="slogan--steps-title">Wystarczą 4 proste kroki:</div>
                <ul class="slogan--steps-boxes">
                    <li>
                        <div><em>1</em><span>Wybierz rzeczy</span></div>
                    </li>
                    <li>
                        <div><em>2</em><span>Spakuj je w worki</span></div>
                    </li>
                    <li>
                        <div><em>3</em><span>Wybierz fundację</span></div>
                    </li>
                    <li>
                        <div><em>4</em><span>Zamów kuriera</span></div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</header>
