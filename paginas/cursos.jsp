<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%@ include file="cabecalho.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil</title>
    <link rel="stylesheet" href="bootstrap.css">
</head>
<body>
    <%
        Statement stmt = null;
        ResultSet rs = null;
        if (session.getAttribute("tipo_utilizador") != null && (int)session.getAttribute("tipo_utilizador") == 3) {
            
    %>
    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="card shadow-lg p-3 mb-5 bg-white rounded" style="margin-top: 20px;">
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
                            <%
                            if ((int)session.getAttribute("tipo_utilizador") == 3) {
                            %>
                                <th scope="col">Editar</th>
                                <th scope="col">Eliminar</th>
                                <th scope="col">Inscrições</th>
                            <%
                            } else {
                            %>
                                <th scope="col">Inscrição</th>
                            <%
                            }
                            %>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if ((int)session.getAttribute("tipo_utilizador") == 3) {
                                stmt = conn.createStatement();
                                rs = stmt.executeQuery("SELECT * FROM curso");
                                while (rs.next()) {
                                    %>
                                    <tr class="table-active">
                                        <th scope="row"><%= rs.getString("id_curso") %></th>
                                        <td><%= rs.getString("nome") %></td>
                                        <td><%= rs.getString("vagas") %></td>
                                        <td><%= rs.getString("vagas_preenchidas") %></td>
                                        <td><%= rs.getString("data_inicio") %></td>
                                        <td><%= rs.getString("data_fim") %></td>
                                        <td><a href="editarCursoformulario.jsp?id=<%= rs.getString("id_curso") %>">Editar</a></td>
                                        <td><a href="eliminarCursoformulario.jsp?id=<%= rs.getString("id_curso") %>">Eliminar</a></td>
                                        <td><a href="inscricoesCurso.jsp?id=<%= rs.getString("id_curso") %>">Inscrições</a></td>
                                    </tr>
                                    <%
                                }
                        %>
                    </tbody>
                </table>
                <%
                if ((int)session.getAttribute("tipo_utilizador") == 3) {
                %>
                    <a type="button" class="btn btn-primary" href="adicionarCursoformulario.jsp">Adicionar</a>
                <%
                }
                %>
            </div>
        </div>
    </div>
    <%
        } else {
    %>
    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="card shadow-lg p-3 mb-5 bg-white rounded" style="margin-top: 20px;">
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
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery("SELECT * FROM curso");
                            while (rs.next()) {
                        %>
                                <tr class="table-active">
                                    <th scope="row"><%= rs.getString("id_curso") %></th>
                                    <td><%= rs.getString("nome") %></td>
                                    <td><%= rs.getString("vagas") %></td>
                                    <td><%= rs.getString("vagas_preenchidas") %></td>
                                    <td><%= rs.getString("data_inicio") %></td>
                                    <td><%= rs.getString("data_fim") %></td>
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
