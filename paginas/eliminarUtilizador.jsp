<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<%
// Obter os dados do formulário
if (session.getAttribute("tipo_utilizador") != null && Integer.parseInt(session.getAttribute("tipo_utilizador").toString()) == 3) {
    

    
    int id_utilizador = 0;

    if (request != null) {
        if (request.getParameter("id_utilizador") != null)  {
            id_utilizador = Integer.parseInt(request.getParameter("id_utilizador"));
        }
        

    }else{
        response.sendRedirect("Erro.jsp");
    }

        int result = 0;
        //PreparedStatement pstmt = conn.createStatement();
        
            // Atualizar utilizador 
            PreparedStatement pstmt = conn.prepareStatement("UPDATE utilizador SET tipo_utilizador=? WHERE id_utilizador=?");
            pstmt.setInt(1, -1);
            pstmt.setInt(2, id_utilizador);
            result = pstmt.executeUpdate();
            
            // Verificar se a atualização foi bem-sucedida
            if (result > 0) {
                out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                out.println("<div class=\"alert alert-dismissible alert-success\">");
                out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                out.println("<strong></strong> <a href=\"utilizadores.jsp\" class=\"alert-link\">Sucesso!!!</a></div>");
            } else {
                out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                out.println("<div class=\"alert alert-dismissible alert-danger\">");
                out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                out.println("<strong></strong> <a href=\"editarUtilizadorformulario.jsp\" class=\"alert-link\">Erro ao Eliminar!!!</a></div>");
            }
} else {
    response.sendRedirect("Erro.jsp");
}
%>
