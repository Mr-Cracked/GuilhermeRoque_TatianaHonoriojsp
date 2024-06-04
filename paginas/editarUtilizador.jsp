<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%@ include file="Encriptar.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<%

if (session.getAttribute("tipo_utilizador") != null && Integer.parseInt(session.getAttribute("tipo_utilizador").toString()) == 3) {
    boolean existepass = false;
    String senha_encriptada = "";
    if (request.getParameter("pass") != null && !request.getParameter("pass").isEmpty()) {
        existepass = true;
        
    }

    int nivel = 0;
    String email = "";
    String telemovel = "";
    String morada = "";
    String nome = "";
    int id_utilizador = 0;

    if (request != null) {
        if (request.getParameter("nivelacesso") != null && request.getParameter("id_utilizador") != null)  {
            nivel = Integer.parseInt(request.getParameter("nivelacesso"));
            id_utilizador = Integer.parseInt(request.getParameter("id_utilizador"));
        }
         email = request.getParameter("email");
         telemovel = request.getParameter("telemovel");
         morada = request.getParameter("morada");
         nome = request.getParameter("nome");
         
        if (request.getParameter("pass") != null && !request.getParameter("pass").isEmpty()) {
            existepass = true;
            senha_encriptada = Encriptar(request.getParameter("pass"));
        }

        PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM utilizador WHERE nome = ?");
        pstmt.setString(1, nome);

        ResultSet resultado = pstmt.executeQuery();
        int linhasafetadas = 0;
        while(resultado.next()){
            linhasafetadas= linhasafetadas + 1;
        }
        if(linhasafetadas > 1)
        {
            out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
            out.println("<div class=\"alert alert-dismissible alert-danger\">");
            out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
            out.println("<strong></strong> <a href=\"utilizadores.jsp\" class=\"alert-link\">UTILIZADOR JÁ EXISTE COM ESSE NOME</a></div>");
        }else{
            
            int result = 0;
            if (existepass) {
                
                pstmt = conn.prepareStatement("UPDATE utilizador SET nome=?, pass=?, email=?, telemovel=?, morada=?, tipo_utilizador=? WHERE id_utilizador=?");
                pstmt.setString(1, nome);
                pstmt.setString(2, senha_encriptada);
                pstmt.setString(3, email);
                pstmt.setString(4, telemovel);
                pstmt.setString(5, morada);
                pstmt.setInt(6, nivel);
                pstmt.setInt(7, id_utilizador);
                result = pstmt.executeUpdate();
            }else {

                pstmt = conn.prepareStatement("UPDATE utilizador SET nome=?, email=?, telemovel=?, morada=?, tipo_utilizador=? WHERE id_utilizador=?");
                pstmt.setString(1, nome);
                pstmt.setString(2, email);
                pstmt.setString(3, telemovel);
                pstmt.setString(4, morada);
                pstmt.setInt(5, nivel);
                pstmt.setInt(6, id_utilizador);
                result = pstmt.executeUpdate();
            }
                
                
                if (result > 0) {
                    out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                    out.println("<div class=\"alert alert-dismissible alert-success\">");
                    out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                    out.println("<strong></strong> <a href=\"utilizadores.jsp\" class=\"alert-link\">Sucesso!!!</a></div>");
                } else {
                    out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                    out.println("<div class=\"alert alert-dismissible alert-danger\">");
                    out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                    out.println("<strong></strong> <a href=\"editarUtilizadorformulario.jsp\" class=\"alert-link\">Erro ao editar!!!</a></div>");
                }
        }
        


    }else{
        response.sendRedirect("Erro.jsp");
    }


} else {
    response.sendRedirect("Erro.jsp");
}
%>
