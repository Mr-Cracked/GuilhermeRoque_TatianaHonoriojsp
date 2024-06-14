<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../basedados/basedados.h" %>

<%
    if (session.getAttribute("tipo_utilizador") != null && Integer.parseInt(session.getAttribute("tipo_utilizador").toString()) ==3) {
        
        String id_curso = request.getParameter("id_curso");
        String descricao = request.getParameter("descricao");
        String id_utilizador = request.getParameter("id_utilizador");
        PreparedStatement stmt = null;
        
        String sql = "UPDATE inscricao SET descricao = ? WHERE id_utilizador = ? AND id_curso = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, descricao);
        stmt.setString(2, id_utilizador);
        stmt.setString(3, id_curso);

        int result = stmt.executeUpdate();


        if(result==1){
            out.println("<link rel='stylesheet' href='bootstrap.css'>");
            out.println("<div class='alert alert-dismissible alert-success'>");
            out.println("<button type='button' class='btn-close' data-bs-dismiss='alert'></button>");
            out.println("<strong></strong> <a href='gerirInscricoes.jsp' class='alert-link'>Sucesso!!!</a></div>");
        }else{
            out.println("<link rel='stylesheet' href='bootstrap.css'>");
            out.println("<div class='alert alert-dismissible alert-danger'>");
            out.println("<button type='button' class='btn-close' data-bs-dismiss='alert'></button>");
            out.println("<strong></strong> <a href='gerirInscricoes.jsp' class='alert-link'>Erro ao editar!!!</a></div>");
        }
        

    } else {
        response.sendRedirect("Erro.jsp");
    }
%>