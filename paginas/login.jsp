<%@ page import="java.sql.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.math.*" %>

<%@ include file="../basedados/basedados.h" %>

<% 
    if(session.getAttribute("tipo_utilizador") == null){

    String nome = request.getParameter("username");
    String password = request.getParameter("password"); // A senha ainda não está encriptada

    
   


    Statement stmt = conn.createStatement();
    String sql = "SELECT * FROM utilizador WHERE nome='" + nome + "' AND password='" + password + "'";
    ResultSet rs = stmt.executeQuery(sql);

    if (!rs.next()) {
%>
    <link rel="stylesheet" href="bootstrap.css">
    <div class="alert alert-dismissible alert-danger">
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        <strong>Erro!</strong> <a href="loginformulario.jsp" class="alert-link">Utilizador não existe</a>
    </div>
<%
    } else {
        int tipo_utilizador = rs.getInt("tipo_utilizador");

 
        if (tipo_utilizador > 0) {
            session.setAttribute("tipo_utilizador", tipo_utilizador);
            session.setAttribute("id_utilizador", rs.getInt("id_utilizador"));
            session.setAttribute("nome", rs.getString("nome"));
            session.setAttribute("email", rs.getString("email"));
            session.setAttribute("telemovel", rs.getString("telemovel"));
            session.setAttribute("morada", rs.getString("morada"));
            session.setAttribute("password", rs.getString("password"));


            response.sendRedirect("perfil.jsp");
        } else if (tipo_utilizador <= 0) {
%>
    <link rel="stylesheet" href="bootstrap.css">
    <div class="alert alert-dismissible alert-danger">
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        <strong>Erro!</strong> <a href="loginformulario.jsp" class="alert-link">Utilizador inválido</a>
    </div>
<%
        } else {
%>
    <link rel="stylesheet" href="bootstrap.css">
    <div class="alert alert-dismissible alert-danger">
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        <strong>Erro!</strong> <a href="loginformulario.jsp" class="alert-link">Credenciais incorretas</a>
    </div>
<%
        }
    }
}else{
    response.sendRedirect("Erro.jsp");
}
%>
