<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="cabecalho.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../basedados/basedados.h" %>
<%
if (session.getAttribute("tipo_utilizador") != null && Integer.parseInt(session.getAttribute("tipo_utilizador").toString()) == 3) {


    Statement stmt = null;
    ResultSet rs = null;

    stmt = conn.createStatement();


     String sql = "SELECT c.nome AS nome_curso, i.descricao AS descricao, i.id_curso, i.id_utilizador, u.nome AS nome_utilizador " +
                     "FROM inscricao i " +
                     "INNER JOIN curso c ON i.id_curso = c.id_curso " +
                     "INNER JOIN utilizador u ON i.id_utilizador = u.id_utilizador " +
                     "WHERE i.id_utilizador ='" + request.getParameter("id") + "' AND i.id_curso ='" + request.getParameter("id_curso")+ "'";

    rs = stmt.executeQuery(sql);

    if (rs.next()) {
            String nome_curso = rs.getString("nome_curso");
            String descricao = rs.getString("descricao");
            int id_curso = rs.getInt("id_curso");
            int id_utilizador = rs.getInt("id_utilizador");
            String nome_utilizador = rs.getString("nome_utilizador");
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
    <div class="container d-flex justify-content-center align-items-center mt-5" style="height: 80vh;">
        <div class="card shadow-lg p-3 mb-5 bg-white rounded w-75 align-items-center">
            <div class="card-body w-100">
                <h4 class="card-title text-center">Editar Inscrição</h4>
                <br>
                <form id="form1" name="form1" method="post" action="editarinscricao.jsp">
                    <div class="form-group">
                        <label for="id_curso">ID:</label>
                        <input type="text" class="form-control" name="id_curso" value="<%= id_curso %>" required readonly>
                    </div>
                    <br>

                    <div class="form-group">
                        <label for="nome">Nome do Curso:</label>
                        <input type="text" class="form-control" name="nome_curso" value="<%= nome_curso %>" required readonly>
                    </div>
                    <br>

                    <div class="form-group">
                        <label for="vagas">Id do Utilizador:</label>
                        <input type="text" class="form-control" name="id_utilizador" value="<%= id_utilizador %>" required readonly>
                    </div>
                    <br>

                    <div class="form-group">
                        <label for="vagas">Nome do utilizador:</label>
                        <input type="text" class="form-control" name="nome_utilizador" value="<%= nome_utilizador %>" required readonly>
                    </div>
                    <br>

                    <div class="form-group">
                        <label for="descricao">Descrição:</label>
                        <textarea type="text" class="form-control" name="descricao" required><%= descricao %></textarea>
                    </div>
                    <br>
                    <input type="submit" name="Submit" value="Guardar" class="btn btn-primary"/>
                    <a type="button" class="btn btn-danger" href="cursos.jsp">Cancelar</a>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
<%
        } else {
%>
<div class="alert alert-danger" role="alert">
    Não foi possível encontrar a inscrição.
</div>
<%
        }

} else {
    response.sendRedirect("Erro.jsp");
}
%>
