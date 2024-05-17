<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="cabecalho.jsp" %>
<%@ include file="../basedados/basedados.h" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    if ((int)session.getAttribute("tipo_utilizador") == 3) {
%>
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
            stmt = conn.createStatement();
            String sql = "SELECT * FROM curso WHERE id_curso='" + request.getParameter("id") + "'";
            rs = stmt.executeQuery(sql);
            rs.next();
            String idCurso = rs.getString("id_curso");
    %>

    <div class="container d-flex justify-content-center align-items-center" style="height: 110vh;">
        <div class="card shadow-lg p-3 mb-5 bg-white rounded w-75 align-items-center ">
            <div class="card-body w-100">
                <h4 class="card-title text-center">Editar Curso</h4>
                <br>
                <form id="form1" name="form1" method="post" action="editarCurso.jsp">
                    <div class="form-group">
                        <label for="id_curso">ID:</label>
                        <input type="text" class="form-control" name="id_curso" value="<%= rs.getString("id_curso") %>" required readonly>
                    </div>
                    <br>

                    <div class="form-group">
                        <label for="nome">Nome:</label>
                        <input type="text" class="form-control" name="nome" value="<%= rs.getString("nome") %>" required>
                    </div>
                    <br>

                    <div class="form-group">
                        <label for="vagas">Vagas:</label>
                        <input type="number" class="form-control" name="vagas" value="<%= rs.getString("vagas") %>" required>
                    </div>
                    <br>

                    <div class="form-group">
                        <label for="descricao">Descrição:</label>
                        <input type="text" class="form-control" name="descricao" value="<%= rs.getString("descricao") %>" required>
                    </div>
                    <br>
                    
                    <div class="form-group">
                        <label for="data_inic">Data de ínicio:</label>
                        <input type="date" class="form-control" name="data_inic" value="<%= rs.getString("data_inicio") %>" required>
                    </div>
                    <br>
                    <div class="form-group">
                        <label for="data_fim">Data de fim:</label>
                        <input type="date" class="form-control" name="data_fim" value="<%= rs.getString("data_fim") %>" required>
                    </div>
                    <br>
                    <div class="form-group">
                        <label for="metodo">Método de Seleção:</label>
                        <input type="text" class="form-control" name="metodo" value="<%= rs.getString("metodo_selecao") %>" required>
                    </div>
                    <br>
                    <div id="docentesSelectContainer">
                        <%
                            sql = "SELECT u.id_utilizador, u.nome " +
                                                 "FROM utilizador u " +
                                                 "INNER JOIN leciona l ON u.id_utilizador = l.id_utilizador " +
                                                 "WHERE l.id_curso = '" + idCurso + "'";
                            ResultSet Result = stmt.executeQuery(sql);
                            while (Result.next()) {
                        %>
                            <div class='form-check'>
                                <input class='form-check-input' type='checkbox' name='docentes[]' value='<%= Result.getString("id_utilizador") %>' id='docente<%= Result.getString("id_utilizador") %>' checked>
                                <label class='form-check-label' for='docente<%= Result.getString("id_utilizador") %>'><%= Result.getString("nome") %></label>
                            </div>
                        <%
                            }
                            Result.close();

                            sql = "SELECT u.id_utilizador, u.nome " +
                                          "FROM utilizador u " +
                                          "WHERE NOT EXISTS (SELECT 1 FROM leciona l WHERE l.id_curso = '" + idCurso + "' AND u.id_utilizador = l.id_utilizador) " +
                                          "AND u.tipo_utilizador = 2";
                            Result = stmt.executeQuery(sql);
                            while (Result.next()) {
                        %>
                            <div class='form-check'>
                                <input class='form-check-input' type='checkbox' name='docentes[]' value='<%= Result.getString("id_utilizador") %>' id='docente<%= Result.getString("id_utilizador") %>'>
                                <label class='form-check-label' for='docente<%= Result.getString("id_utilizador") %>'><%= Result.getString("nome") %></label>
                            </div>
                        <%
                            }
                            Result.close();
                        %>
                    </div>
                    <br>
                    <input type="submit" name="Submit" value="Guardar" class="btn btn-primary"/>
                    <a type="button" class="btn btn-danger" href="cursos.jsp">Cancelar</a>
                </form>
            </div>
        </div>
    </div>
    <%
    %>
</body>
</html>
<%
    } else {
        response.sendRedirect("Erro.jsp");
    }
%>
