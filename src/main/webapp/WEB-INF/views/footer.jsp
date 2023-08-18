<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer>
    <div class="contact">
        <h2>Skontaktuj się z nami</h2>
        <h3>Formularz kontaktowy</h3>
        <form class="form--contact">
            <div class="form-group form-group--50"><label>
                <input type="text" name="name" placeholder="Imię"/>
            </label></div>
            <div class="form-group form-group--50"><label>
                <input type="text" name="surname" placeholder="Nazwisko"/>
            </label></div>

            <div class="form-group"><label>
                <textarea name="message" placeholder="Wiadomość" rows="1"></textarea>
            </label></div>

            <button class="btn" type="submit">Wyślij</button>
        </form>
    </div>
    <div class="bottom-line">
        <span class="bottom-line--copy">Copyright &copy; 2018</span>
        <div class="bottom-line--icons">
            <a href="#" class="btn btn--small"><img src="resources/images/icon-facebook.svg" alt="fb"/></a>
            <a href="#" class="btn btn--small"><img src="resources/images/icon-instagram.svg" alt="ig"/></a>
        </div>
    </div>
</footer>