<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pl">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Document</title>
    <link rel="stylesheet" href="<c:url value="resources/css/style_user.css"/>"/>
  </head>
  <body>
  <jsp:include page="header.jsp" />

    <section class="login-page">
      <h2>Załóż konto</h2>
      <form action="/register" method="post">
        <div class="form-group">
          <input type="email" name="email" placeholder="Email" required />
        </div>
        <div class="form-group">
          <input type="password" name="password" placeholder="Hasło" required />
        </div>
        <div class="form-group">
          <input type="password" name="password2" placeholder="Powtórz hasło" required />
        </div>

        <div class="form-group form-group--buttons">
          <a href="/login" class="btn btn--without-border">Zaloguj się</a>
          <button class="btn" type="submit">Załóż konto</button>
        </div>
        <c:if test="${not empty param.registrationSuccess}">
          <p class="success">Pomyślnie zarejestrowano! Możesz się teraz zalogować.</p>
        </c:if>
      </form>
    </section>


    <jsp:include page="footer_user.jsp" />
  </body>
</html>
