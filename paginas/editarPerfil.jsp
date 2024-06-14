<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
   
    if (session.getAttribute("tipo_utilizador") != null && (int)session.getAttribute("tipo_utilizador") > 0) {

        PreparedStatement stmt = null;

        boolean existepass = false;
        String pass = "";
        if (request.getParameter("pass") != null && !request.getParameter("pass").isEmpty()) {
            existepass = true;
            pass = request.getParameter("pass");
        }

        String email = request.getParameter("email");
        Integer telemovel = Integer.parseInt(request.getParameter("telemovel").toString());
        String morada = request.getParameter("morada");
        String nome = request.getParameter("username");

        Statement stmt_nomes = conn.createStatement();
        ResultSet result_nomes = stmt_nomes.executeQuery("SELECT * FROM utilizador WHERE nome='" + nome + "' AND id_utilizador !='" + request.getParameter("id_utilizador") + "'");

       

        if (result_nomes.next()) {
            out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
            out.println("<div class=\"alert alert-dismissible alert-danger\">");
            out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
            out.println("<strong>Erro!</strong> <a href=\"perfil.jsp\" class=\"alert-link\">Utilizador já existe</a></div>");
        }else{

            int result = 0;
            String sql = "";
            if (existepass) {
            sql = "UPDATE utilizador SET nome=?, pass=(?), email=?, telemovel=?, morada=? WHERE id_utilizador=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, nome);
            stmt.setString(2, pass);
            stmt.setString(3, email);
            stmt.setInt(4, telemovel);
            stmt.setString(5, morada);
            stmt.setInt(6, Integer.parseInt(session.getAttribute("id_utilizador").toString()));
            result = stmt.executeUpdate();
            } else {
                sql = "UPDATE utilizador SET nome=?, email=?, telemovel=?, morada=? WHERE id_utilizador=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, nome);
                stmt.setString(2, email);
                stmt.setInt(3, telemovel);
                stmt.setString(4, morada);
                stmt.setInt(5, Integer.parseInt(session.getAttribute("id_utilizador").toString()));
                result = stmt.executeUpdate();
            }

            
            

            if (result > 0) {
                
                session.setAttribute("email", email);
                session.setAttribute("telemovel", telemovel);
                session.setAttribute("morada", morada);
                session.setAttribute("nome", nome);

                
                out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                out.println("<div class=\"alert alert-dismissible alert-success\">");
                out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                out.println("<strong></strong> <a href=\"perfil.jsp\" class=\"alert-link\">Sucesso!!!</a>");
                out.println("</div>");
            } else {
            
                out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                out.println("<div class=\"alert alert-dismissible alert-danger\">");
                out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                out.println("<strong>Erro!</strong> <a href=\"editarPerfilformulario.jsp\" class=\"alert-link\">Erro ao editar!!!</a>");
                out.println("</div>");
            }
        }
            
    } else {
        
        response.sendRedirect("Erro.jsp");
    }
%>
