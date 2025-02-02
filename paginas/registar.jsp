<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%@ include file="Encriptar.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.security.*" %>
<%@ page import="java.math.*" %>

<%
if (session.getAttribute("tipo_utilizador") == null || Integer.parseInt(session.getAttribute("tipo_utilizador").toString()) == 3) {
    Statement stmt = null;
    ResultSet result = null;
    if(request.getParameter("username") == null){
        out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
        out.println("<div class=\"alert alert-dismissible alert-danger\">");
        out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
        out.println("<strong>Erro!</strong> <a href=\"index.jsp\" class=\"alert-link\">Não há dados suficientes</a></div>");
    }else{
        String nivel = request.getParameter("nivelacesso");
        String nome = request.getParameter("username");
        String pass = request.getParameter("pass"); 
        String email = request.getParameter("email");
        Integer telemovel = Integer.parseInt(request.getParameter("telemovel"));
        String morada = request.getParameter("morada");

        String pass_encriptada = Encriptar(pass);
        
        stmt = conn.createStatement();
        result = stmt.executeQuery("SELECT * FROM utilizador WHERE nome='" + nome + "'");

        
        if (result.next()) {
            if (session.getAttribute("tipo_utilizador") != null && Integer.parseInt(session.getAttribute("tipo_utilizador").toString()) == 3) {
                out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                out.println("<div class=\"alert alert-dismissible alert-danger\">");
                out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                out.println("<strong>Erro!</strong> <a href=\"adicionarUtilizadorformulario.jsp\" class=\"alert-link\">Utilizador já existe</a></div>");
            } else {
                out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                out.println("<div class=\"alert alert-dismissible alert-danger\">");
                out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                out.println("<strong>Erro!</strong> <a href=\"registarformulario.jsp\" class=\"alert-link\">Utilizador já existe</a></div>");
            }
        } else {
            if (nivel == null || nivel.isEmpty()) {

                int rowsAffected = stmt.executeUpdate("INSERT INTO utilizador (nome, pass, email, telemovel, morada) VALUES ('" + nome + "', '" + pass_encriptada + "', '" + email + "', '" + telemovel + "', '" + morada + "')");

                
                if (rowsAffected > 0) {
                    out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                    out.println("<div class=\"alert alert-dismissible alert-success\">");
                    out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                    out.println("<strong>Alerta!</strong> <a href=\"index.jsp\" class=\"alert-link\">Sucesso!!!</a></div>");
                } else {
                    out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                    out.println("<div class=\"alert alert-dismissible alert-danger\">");
                    out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                    out.println("<strong>Alerta!</strong> <a href=\"registarformulario.jsp\" class=\"alert-link\">ERRO!</a></div>");
                }
            } else {
                
                int rowsAffected = stmt.executeUpdate("INSERT INTO utilizador (tipo_utilizador, nome, pass, email, telemovel, morada) VALUES ('" + nivel + "', '" + nome + "', '" + pass_encriptada + "', '" + email + "', '" + telemovel + "', '" + morada + "')");

                
                if (rowsAffected > 0) {
                    out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                    out.println("<div class=\"alert alert-dismissible alert-success\">");
                    out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                    out.println("<strong>Alerta!</strong> <a href=\"utilizadores.jsp\" class=\"alert-link\">Sucesso!!!</a></div>");
                } else {
                    out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                    out.println("<div class=\"alert alert-dismissible alert-danger\">");
                    out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                    out.println("<strong>Alerta!</strong> <a href=\"registarformulario.jsp\" class=\"alert-link\">ERRO!</a></div>");
                }
            }
        }
    }
            
} else {
    response.sendRedirect("Erro.jsp");
}
%>
