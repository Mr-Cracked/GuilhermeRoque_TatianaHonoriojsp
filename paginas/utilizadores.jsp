<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="cabecalho.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../basedados/basedados.h" %>



<%
if (session.getAttribute("tipo_utilizador") != null && Integer.parseInt(session.getAttribute("tipo_utilizador").toString()) == 3) {

String searchName = request.getParameter("search_name") != null ? request.getParameter("search_name") : "";


Statement stmt = null;
ResultSet result = null;

stmt = conn.createStatement();

String sql = "SELECT * FROM utilizador";
if (!searchName.isEmpty()) {
    searchName = searchName.replace("'", "''");
    sql += " WHERE nome LIKE '%" + searchName + "%'";
}

result = stmt.executeQuery(sql);
%>        
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil</title>
    <link rel="stylesheet" href="bootstrap.css">
</head>
<body>
    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="card shadow-lg p-3 mb-5 bg-white rounded" style="margin-top: 20px;">
            <div class="card-body">

                <form method="POST" action="" class="mb-4">
                    <div class="input-group">
                        <input type="text" name="search_name" class="form-control" placeholder="Pesquisar Utilizador" value="<%= searchName %>">
                        <div class="input-group-append">
                            <button type="submit" class="btn btn-primary">Search</button>
                        </div>
                    </div>
                </form>

                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th scope="col">Nível de Acesso</th> 
                            <th scope="col">Nome</th>
                            <th scope="col">Password</th>
                            <th scope="col">Morada</th>
                            <th scope="col">Email</th>
                            <th scope="col">Telemóvel</th> 
                            <th scope="col">Editar</th>
                            <th scope="col">Eliminar</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        while (result.next()) {
                        %>
                            <tr class="table-active">
                                <th scope="row"><%= result.getInt("tipo_utilizador") %></th>
                                <td><%= result.getString("nome") %></td>
                                <td><%= result.getString("password") %></td>
                                <td><%= result.getString("morada") %></td>
                                <td><%= result.getString("email") %></td>
                                <td><%= result.getString("telemovel") %></td>
                                <td><a href="editarUtilizadorformulario.jsp?id=<%= result.getInt("id_utilizador") %>">Editar</a></td>
                                <td><a href="eliminarUtilizador.jsp?id=<%= result.getInt("id_utilizador") %>">Eliminar</a></td>
                            </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            
                <div style="display: flex; justify-content: center;">
                    <a type="button" class="btn btn-primary" href="adicionarUtilizadorformulario.jsp">Adicionar</a>
                </div>
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
