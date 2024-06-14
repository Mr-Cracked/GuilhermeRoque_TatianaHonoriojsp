<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
    if (session.getAttribute("tipo_utilizador") != null && (int)session.getAttribute("tipo_utilizador") == 3) {
        String id_curso = request.getParameter("curso");
        String id_utilizador = request.getParameter("aluno");
        String descricao = request.getParameter("descricao");

        String sqlCheck = "SELECT * FROM inscricao WHERE id_curso = ? AND id_utilizador = ?";
        PreparedStatement pstmtCheck = conn.prepareStatement(sqlCheck);
        pstmtCheck.setString(1, id_curso);
        pstmtCheck.setString(2, id_utilizador);
        
        ResultSet rs = pstmtCheck.executeQuery();
        
        if (rs.next()) {
            out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
            out.println("<div class=\"alert alert-dismissible alert-danger\">");
            out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
            out.println("<strong>Erro!</strong> <a href=\"adicionarInscricaoFormulario.jsp\" class=\"alert-link\">JÁ EXISTE ESTA INSCRIÇÃO</a></div>");
        } else {
            String sqlInsert = "INSERT INTO inscricao (id_curso, id_utilizador, descricao) VALUES (?, ?, ?)";
            PreparedStatement pstmtInsert = conn.prepareStatement(sqlInsert);
            pstmtInsert.setString(1, id_curso);
            pstmtInsert.setString(2, id_utilizador);
            pstmtInsert.setString(3, descricao);

            int resultInsert = pstmtInsert.executeUpdate();

            if (resultInsert > 0) {
                out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                out.println("<div class=\"alert alert-dismissible alert-success\">");
                out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                out.println("<strong></strong> <a href=\"gerirInscricoes.jsp\" class=\"alert-link\">Sucesso!!!</a></div>");
            } else {
                out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                out.println("<div class=\"alert alert-dismissible alert-danger\">");
                out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                out.println("<strong></strong> <a href=\"adicionarInscricaoFormulario.jsp\" class=\"alert-link\">ERRO!!!</a></div>");
            }
        }
    } else {
        response.sendRedirect("Erro.jsp");
    }
%>
