<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../basedados/basedados.h" %>

<%
    if (session.getAttribute("tipo_utilizador") != null && (Integer) session.getAttribute("tipo_utilizador") == 3) {
        PreparedStatement pstmt = null;
        String id = request.getParameter("id");

        if (id != null) {
            String query = "SELECT id_curso, COUNT(id_curso) as inscricoes FROM inscricao WHERE id_utilizador = ? AND estado = 1 GROUP BY id_curso";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, Integer.parseInt(id));
            ResultSet rs = pstmt.executeQuery();

            String sql = "DELETE FROM utilizador WHERE id_utilizador = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));
            int result = pstmt.executeUpdate();

            if (result > 0) {

                

       
            while (rs.next()) {
                int id_curso = Integer.parseInt(rs.getString("id_curso"));
                int inscricoes = Integer.parseInt(rs.getString("inscricoes"));
                if (inscricoes == 0) {
                    inscricoes = 0;
                }
                String updateQuery = "UPDATE curso SET vagas_preenchidas = vagas_preenchidas - ? WHERE id_curso = ?";
                pstmt = conn.prepareStatement(updateQuery);
                pstmt.setInt(1, inscricoes);
                pstmt.setInt(2, id_curso);
                pstmt.executeUpdate();
            }
                
                    %>
                <link rel="stylesheet" href="bootstrap.css">
                <div class="alert alert-dismissible alert-success">
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    <strong>Alerta!</strong> <a href="utilizadores.jsp" class="alert-link">Sucesso!!!</a>
                </div>
                <%
                }else{
                    %>
                    <link rel="stylesheet" href="bootstrap.css">
                    <div class="alert alert-dismissible alert-warning">
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        <strong></strong> <a href="utilizadores.jsp" class="alert-link">Erro Parcial!!!</a>
                    </div>
                    <%
                }
                
            } else {
                %>
                <link rel="stylesheet" href="bootstrap.css">
                <div class="alert alert-dismissible alert-danger">
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    <strong>Erro!</strong> <a href="utilizadores.jsp" class="alert-link">Erro ao dar Delete!!!</a>
                </div>
                <%
            }
    } else {
        response.sendRedirect("Erro.jsp");
    }
%>
