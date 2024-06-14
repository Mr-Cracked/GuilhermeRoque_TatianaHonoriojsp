<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%@ include file="cabecalho.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<% if (session.getAttribute("tipo_utilizador") != null && Integer.parseInt(session.getAttribute("tipo_utilizador").toString()) == 3) { %>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulário de Registo</title>
    <link rel="stylesheet" href="bootstrap.css">
</head>
<body>
    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="card shadow-lg p-3 mb-5 bg-white rounded w-75 align-items-center ">
            <div class="card-body w-100 ">
                <h4 class="card-title text-center">Criar Inscrição</h4>
                <form id="form1" name="form1" method="post" action="inscricao.jsp">
                    <div class="form-group">
                        <label for="nome">Curso:</label>
                        <select class="form-control" name="curso" required>
                            <option value="" disabled selected>Selecione um curso</option>
                            <%
                                Statement stmt = conn.createStatement();
                                String sqlCursos = "SELECT id_curso, nome FROM curso";
                                ResultSet resultCursos = stmt.executeQuery(sqlCursos);
                                while (resultCursos.next()) {
                                    out.println("<option value='" + resultCursos.getInt("id_curso") + "'>" + resultCursos.getString("nome") + "</option>");
                                }
                            %>
                        </select>
                    </div>
                    <br>
                    <div class="form-group">
                        <label for="aluno">Aluno:</label>
                        <select class="form-control" name="aluno" required>
                            <option value="" disabled selected>Selecione um aluno</option>
                            <%
                                stmt = conn.createStatement();
                                String sqlAlunos = "SELECT id_utilizador, nome FROM utilizador WHERE tipo_utilizador = 1";
                                ResultSet resultAlunos = stmt.executeQuery(sqlAlunos);
                                while (resultAlunos.next()) {
                                    out.println("<option value='" + resultAlunos.getInt("id_utilizador") + "'>" + resultAlunos.getString("nome") + "</option>");
                                }
                            %>
                        </select>
                    </div>
                    <br>
                    <div class="form-group">
                        <label for="descricao">Descrição:</label>
                        <input type="text" class="form-control" name="descricao" placeholder="Insira uma descrição" required>
                    </div>
                    <br>
                    <input type="submit" name="Submit" value="Registar" class="btn btn-primary"/><br>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
<% } else {
    response.sendRedirect("Erro.jsp");
} %>
