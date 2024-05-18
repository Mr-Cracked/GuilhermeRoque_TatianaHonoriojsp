<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="cabecalho.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../basedados/basedados.h" %>

<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil</title>
    <link rel="stylesheet" href="bootstrap.css">
</head>
<body>
<%
if (session.getAttribute("tipo_utilizador") != null && Integer.parseInt(session.getAttribute("tipo_utilizador").toString()) == 3) {
%>
    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="card shadow-lg p-3 mb-5 bg-white rounded " style="margin-top: 20px;">
            <div class="card-body">
                <form method="GET" action="">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" name="search" placeholder="Pesquisar Cursos" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="submit">Pesquisar</button>
                        </div>
                    </div>
                </form>
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Nome do curso</th>
                            <th scope="col">Vagas</th>
                            <th scope="col">Vagas Preenchidas</th>
                            <th scope="col">Data de Início</th>
                            <th scope="col">Data de Conclusão</th>
                            <th scope="col">Editar</th>
                            <th scope="col">Eliminar</th>
                            <th scope="col">Inscrições</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        Statement stmt = null;
                        ResultSet rs = null;

                        String search = request.getParameter("search") != null ? request.getParameter("search") : "";
                        String searchQuery = !search.isEmpty() ? "WHERE nome LIKE '%" + search + "%'" : "";

                            stmt = conn.createStatement();
                            String sql = "SELECT * FROM curso " + searchQuery;
                            rs = stmt.executeQuery(sql);

                            while (rs.next()) {
                        %>
                                <tr class="table-active">
                                    <th scope="row"><%= rs.getInt("id_curso") %></th>
                                    <td><%= rs.getString("nome") %></td>
                                    <td><%= rs.getInt("vagas") %></td>
                                    <td><%= rs.getInt("vagas_preenchidas") %></td>
                                    <td><%= rs.getDate("data_inicio") %></td>
                                    <td><%= rs.getDate("data_fim") %></td>
                                    <td><a href="editarCursoformulario.jsp?id=<%= rs.getInt("id_curso") %>">Editar</a></td>
                                    <td><a href="eliminarCurso.jsp?id=<%= rs.getInt("id_curso") %>">Eliminar</a></td>
                                    <td><a href="gerirInscricoes.jsp?id=<%= rs.getInt("id_curso") %>">Inscrições</a></td>
                                </tr>
                        <% } %>
                </tbody>
            </table>
                <a type="button" class="btn btn-primary" href="adicionarCursoformulario.jsp">Adicionar</a>
            </div>
        </div>
    </div>
<%
} else {
%>
    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="card shadow-lg p-3 mb-5 bg-white rounded " style="margin-top: 20px;">
            <div class="card-body">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Nome do curso</th>
                            <th scope="col">Vagas</th>
                            <th scope="col">Vagas Preenchidas</th>
                            <th scope="col">Data de Início</th>
                            <th scope="col">Data de Conclusão</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        Statement stmt = null;
                        ResultSet rs = null;

                        stmt = conn.createStatement();
                        String sql = "SELECT * FROM curso";
                        rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                        %>
                            <tr class="table-active">
                                <th scope="row"><%= rs.getInt("id_curso") %></th>
                                <td><%= rs.getString("nome") %></td>
                                <td><%= rs.getInt("vagas") %></td>
                                <td><%= rs.getInt("vagas_preenchidas") %></td>
                                <td><%= rs.getDate("data_inicio") %></td>
                                <td><%= rs.getDate("data_fim") %></td>
                            </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
<%
}
%>
</body>
</html>
