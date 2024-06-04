<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="cabecalho.jsp" %>
<%
if (session.getAttribute("tipo_utilizador") != null && Integer.parseInt(session.getAttribute("tipo_utilizador").toString()) > 0) {
%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil</title>
    <link rel="stylesheet" href="bootstrap.css">
</head>
<body>

    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="card shadow-lg p-3 mb-5 bg-white rounded w-75">
            <div class="card-body">
                <h4 class="card-title text-center">Perfil</h4>
                As suas informações
                <br>
                <form id="form1" name="form1" method="post" action="editarPerfilformulario.jsp">
                    <div class="form-group">
                        <label for="username">ID de Utilizador:</label>
                        <input type="text" class="form-control" name="username" value="<%= session.getAttribute("id_utilizador") %>" readonly disabled>
                    </div>
                    <br>
                    <div class="form-group">
                        <label for="username">Nome de Utilizador:</label>
                        <input type="text" class="form-control" name="username" value="<%= session.getAttribute("nome") %>" readonly disabled>
                    </div>
                    <br>

                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="text" class="form-control" name="pass" value="" readonly disabled>
                    </div>
                    <br>

                    <div class="form-group">
                        <label for="morada">Morada:</label>
                        <input type="text" class="form-control" name="morada" value="<%= session.getAttribute("morada") %>" readonly disabled>
                    </div>
                    <br>
                    
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" name="email" value="<%= session.getAttribute("email") %>" readonly disabled>
                    </div>
                    <br>

                    <div class="form-group">
                        <label for="telemovel">Telemóvel:</label>
                        <input type="tel" class="form-control" name="telemovel" value="<%= session.getAttribute("telemovel") %>" readonly disabled>
                    </div>
                    <br>
                    <input type="submit" name="Submit" value="Editar" class="btn btn-primary"/><br>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
<%
} else {
    response.sendRedirect("Erro.jsp");
}
%>
