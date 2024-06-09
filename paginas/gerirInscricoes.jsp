<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="cabecalho.jsp" %>
<%@ include file="../basedados/basedados.h" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<% if (session.getAttribute("tipo_utilizador") != null && (int)session.getAttribute("tipo_utilizador") == 3) { %>
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
                <form method="GET" action="">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" name="search" placeholder="Pesquisar Inscrições" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="submit">Pesquisar</button>
                        </div>
                    </div>
                </form>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Nome do Aluno</th>
                                <th scope="col">ID Curso</th>
                                <th scope="col">Nome do Curso</th>
                                <th scope="col">Descrição</th>
                                <th scope="col">Estado</th>
                                <th scope="col">Ação</th>
                                <th scope="col">Eliminar</th>
                                <th scope="col">Editar</th>
                                <th scope="col">Visualizar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                String search = request.getParameter("search");
                                String searchQuery = (search != null && !search.isEmpty()) ? "AND c.nome LIKE '%" + search + "%'" : "";
                                String sql = "";

                                if (request.getParameter("id") != null) {
                                    sql = "SELECT i.id_utilizador, u.nome AS nome_aluno, c.id_curso, c.nome AS nome_curso, i.descricao, i.estado " +
                                          "FROM inscricao i " +
                                          "INNER JOIN utilizador u ON i.id_utilizador = u.id_utilizador " +
                                          "INNER JOIN curso c ON i.id_curso = c.id_curso " +
                                          "WHERE i.id_curso = '" + request.getParameter("id") + "' " +
                                          searchQuery;
                                } else {
                                    sql = "SELECT i.id_utilizador, u.nome AS nome_aluno, c.id_curso, c.nome AS nome_curso, i.descricao, i.estado " +
                                          "FROM inscricao i " +
                                          "INNER JOIN utilizador u ON i.id_utilizador = u.id_utilizador " +
                                          "INNER JOIN curso c ON i.id_curso = c.id_curso " +
                                          searchQuery;
                                }

                                Statement stmt = conn.createStatement();
                                ResultSet rs = stmt.executeQuery(sql);

                                while (rs.next()) {
                            %>
                            <tr class="table-active">
                                <th scope="row"><%= rs.getString("id_utilizador") %></th>
                                <td><%= rs.getString("nome_aluno") %></td>
                                <td><%= rs.getString("id_curso") %></td>
                                <td><%= rs.getString("nome_curso") %></td>
                                <td><%= rs.getString("descricao") %></td>
                                <td><%= rs.getString("estado") %></td>
                                <%
                                if(Integer.parseInt(rs.getString("estado").toString()) == 0){
                                %>
                                <td><a href="aceitarInscricao.jsp?id=<%= rs.getInt("id_utilizador") %>&id_curso=<%= rs.getInt("id_curso") %>">Aceitar</a></td>
                                <%
                                }else{
                                    %>
                                    <td><a href="RevocarInscricao.jsp?id=<%= rs.getInt("id_utilizador") %>&id_curso=<%= rs.getInt("id_curso") %>">Revocar</a></td>
                                    <%
                                }
                                %>
                                <td><a href="eliminarInscricao.jsp?id=<%= rs.getInt("id_utilizador") %>&id_curso=<%= rs.getInt("id_curso") %>">Eliminar</a></td>
                                <td><a href="editarInscricaoformulario.jsp?id=<%= rs.getInt("id_utilizador") %>&id_curso=<%= rs.getInt("id_curso") %>">Editar</a></td>
                                <td><a href="visualizarInscricao.jsp?id=<%= rs.getInt("id_utilizador") %>&id_curso=<%= rs.getInt("id_curso") %>">Visualizar</a></td>
                            </tr>
                            <%
                                }
                                rs.close();
                                stmt.close();
                                conn.close();
                            %>
                        </tbody>
                    </table>
                <% } else {
                    response.sendRedirect("Erro.jsp");
                } %>
            </div>
        </div>
    </div>
</body>
</html>
