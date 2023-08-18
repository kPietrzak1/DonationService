<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="th" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="pl">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>

    <title>Document</title>

    <link rel="stylesheet" href="<c:url value="resources/css/style_user.css"/>"/>
</head>
<body>

<jsp:include page="header_user.jsp"/>

<div class="notifications">

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="success">${success}</div>
    </c:if>
</div>

<section class="form--steps">

    <div class="form--steps-instructions">

        <div class="form--steps-container">

            <h3>Ważne Informacje!</h3>

            <p data-step="1" class="active">
                Uzupełnij szczegóły dotyczące Twoich rzeczy. Dzięki temu będziemy wiedzieć komu najlepiej je przekazać.
            </p>

            <p data-step="2">
                Uzupełnij szczegóły dotyczące Twoich rzeczy. Dzięki temu będziemy wiedzieć komu najlepiej je przekazać.
            </p>

            <p data-step="3">
                Wybierz jedną, do której trafi Twoja przesyłka.
            </p>

            <p data-step="4">
                Podaj adres oraz termin odbioru rzeczy.
            </p>
        </div>
    </div>

    <div class="form--steps-container">

        <div class="form--steps-counter">Krok <span>1</span>/4</div>


        <form action="/submit-donation" method="post">

            <div data-step="1" class="active">

                <h3>Zaznacz co chcesz oddać:</h3>


                <c:forEach items="${categories}" var="category">

                    <div class="form-group form-group--checkbox">

                        <label>

                            <input type="checkbox" name="categoryIds[]" value="${category.id}"/>
                            <span class="checkbox"></span>
                            <span class="description">${category.name}</span>

                        </label>
                    </div>

                </c:forEach>

                <div class="form-group form-group--buttons">

                    <button type="button" class="btn next-step">Dalej</button>

                </div>
            </div>


            <div data-step="2">
                <h3>Podaj liczbę 60l worków, w które spakowałeś/aś rzeczy:</h3>

                <div class="form-group form-group--inline">
                    <label>
                        Liczba 60l worków:

                        <input type="number" name="quantity" step="1" min="1"/>

                    </label>
                </div>

                <div class="form-group form-group--buttons">

                    <button type="button" class="btn prev-step">Wstecz</button>
                    <button type="button" class="btn next-step">Dalej</button>

                </div>
            </div>

            <div data-step="3">
                <h3>Wybierz organizacje, której chcesz pomóc:</h3>

                <c:forEach var="institution" items="${institutions}">
                    <div class="form-group form-group--checkbox">
                        <label>
                            <input type="radio" name="institutionId" value="${institution.id}"/>

                            <span class="checkbox radio"></span>
                            <span class="description">

                    <div class="title">${institution.name}</div>
                    <div class="subtitle">Cel i misja: ${institution.description}</div>
                </span>
                        </label>
                    </div>
                </c:forEach>

                <div class="form-group form-group--buttons">
                    <button type="button" class="btn prev-step">Wstecz</button>
                    <button type="button" class="btn next-step">Dalej</button>
                </div>
            </div>

            <div data-step="4">

                <h3>Podaj adres oraz termin odbioru rzecz przez kuriera:</h3>

                <div class="form-section form-section--columns">
                    <div class="form-section--column">
                        <h4>Adres odbioru</h4>

                        <div class="form-group form-group--inline">
                            <label> Ulica <input type="text" name="street" value="${donation.street}"/> </label>
                        </div>

                        <div class="form-group form-group--inline">
                            <label> Miasto <input type="text" name="city" value="${donation.city}"/> </label>
                        </div>

                        <div class="form-group form-group--inline">
                            <label> Kod pocztowy <input type="text" name="zipCode" value="${donation.zipCode}"/>
                            </label>
                        </div>
                    </div>

                    <div class="form-section--column">
                        <h4>Termin odbioru</h4>

                        <div class="form-group form-group--inline">
                            <label> Data <input type="date" name="pickUpDate" value="${donation.pickUpDate}"/>
                            </label>
                        </div>

                        <div class="form-group form-group--inline">
                            <label> Godzina <input type="time" name="pickUpTime" value="${donation.pickUpTime}"/>
                            </label>
                        </div>

                        <div class="form-group form-group--inline">

                            <label>
                                Uwagi dla kuriera

                                <textarea name="pickUpComment" rows="5">${donation.pickUpComment}</textarea>
                            </label>
                        </div>
                    </div>
                </div>

                <div class="form-group form-group--buttons">
                    <button type="button" class="btn prev-step">Wstecz</button>
                    <button type="submit" class="btn next-step">Dalej</button>
                </div>
            </div>

            <div data-step="5">
                <h3>Podsumowanie Twojej darowizny</h3>

                <div class="summary">
                    <div class="form-section">
                        <h4>Oddajesz:</h4>
                        <ul>
                            <li data-summary="category"></li>
                            <li data-summary="description"></li>
                            <li data-summary="name"></li>
                        </ul>
                    </div>

                    <div class="form-section form-section--columns">
                        <div class="form-section--column">
                            <h4>Adres odbioru:</h4>
                            <ul>
                                <li data-summary="street">Prosta 51</li>
                                <li data-summary="city">Warszawa</li>
                                <li data-summary="zipCode">99-098</li>
                            </ul>
                        </div>

                        <div class="form-section--column">
                            <h4>Termin odbioru:</h4>
                            <ul>
                                <li data-summary="pickUpDate">13/12/2018</li>
                                <li data-summary="pickUpTime">15:40</li>
                                <li data-summary="pickUpComment">Brak uwag</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="form-group form-group--buttons">
                    <button type="button" class="btn prev-step">Wstecz</button>
                    <button type="submit" class="btn">Potwierdzam</button>
                </div>
            </div>
        </form>
    </div>
</section>


<jsp:include page="footer_user.jsp"/>
<script src="/resources/js/app.js"></script>

</body>
</html>