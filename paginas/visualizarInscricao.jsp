<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="cabecalho.jsp" %>
<%@ include file="../basedados/basedados.h" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscrição</title>
    <link rel="stylesheet" href="bootstrap.css">
</head>
<body>
    <%
        
        Integer tipoUtilizador = (Integer) session.getAttribute("tipo_utilizador");
        if (session.getAttribute("tipo_utilizador") != null && Integer.parseInt(session.getAttribute("tipo_utilizador").toString()) == 3) {
            Statement stmt = null;
            ResultSet rs = null;
                stmt = conn.createStatement();
                
                
                String sql = "SELECT c.nome AS nomeUti, u.nome AS nomeCurso, u.id_utilizador, c.id_curso, i.descricao AS descricao, i.estado " +
                             "FROM inscricao i " +
                             "INNER JOIN utilizador u ON u.id_utilizador=i.id_utilizador " +
                             "INNER JOIN curso c ON c.id_curso = i.id_curso " +
                             "WHERE i.id_curso = '" + request.getParameter("id_curso") + "' AND i.id_utilizador = '" + request.getParameter("id") + "'";
                rs = stmt.executeQuery(sql);
                
                if (rs.next()) {
                    String nomeCurso = rs.getString("nomeCurso");
                    String nomeUti = rs.getString("nomeUti");
                    String descricao = rs.getString("descricao");
                    String idCurso = rs.getString("id_curso");
    %>

    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="card shadow-lg p-3 mb-5 bg-white rounded w-75">
            <div class="card-body">
                <h4 class="card-title text-center">Inscrição</h4>
                <br>
                <%
                if(Integer.parseInt(rs.getString("estado").toString()) == 0){
                %>
                <form id="form1" name="form1" method="post" action="aceitarInscricao.jsp?id=<%= rs.getString("id_utilizador") %>&id_curso=<%= rs.getString("id_curso") %>">
                <%
                }else{
                    %>
                    <form id="form1" name="form1" method="post" action="RevocarInscricao.jsp?id=<%= rs.getString("id_utilizador") %>&id_curso=<%= rs.getString("id_curso") %>">
                    <%
                }
                %>
                    <div class="form-group">
                        <label for="curso">Curso:</label>
                        <input type="text" class="form-control" name="curso" value="<%= nomeCurso %>" readonly disabled>
                    </div>
                    <br>
                    <div class="form-group">
                        <label for="username">Nome de Utilizador:</label>
                        <input type="text" class="form-control" name="username" value="<%= nomeUti %>" readonly disabled>
                    </div>
                    <br>
                    <div class="form-group">
                        <label for="descricao">Descrição:</label>
                        <input type="text" class="form-control" name="descricao" value="<%= descricao %>" readonly disabled>
                    </div>
                    <br>
                    <%
                    if(Integer.parseInt(rs.getString("estado").toString()) == 0){
                    %>
                    <input type="submit" name="Submit" value="Aceitar" class="btn btn-primary"/>
                    <%
                    }else{
                        %>
                        <input type="submit" name="Submit" value="Revocar" class="btn btn-primary"/>
                        <%
                    }
                    %>
                    
                    <a class="btn btn-danger" href="eliminarInscricao.jsp?id=<%= rs.getString("id_utilizador") %>&id_curso=<%= idCurso %>">Eliminar</a>
                    <a class="btn btn-secondary" href="gerirInscricoes.jsp?id=<%= idCurso %>">Voltar</a>
                </form>
            </div>
        </div>
    </div>
    <%
                } else {
                    out.println("<p>Nenhum registro encontrado.</p>");
                }
        } else {
            response.sendRedirect("Erro.jsp");
        }
    %>
</body>
</html>
