<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>

<%
    if (session.getAttribute("tipo_utilizador") != null && (Integer) session.getAttribute("tipo_utilizador") == 3) {
        PreparedStatement pstmt = null;
        String id = request.getParameter("id");

        if (id != null) {
            String sql = "UPDATE utilizador SET tipo_utilizador = -1 WHERE id_utilizador = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));
            int result = pstmt.executeUpdate();

            if (result > 0) {
                %>
                <link rel="stylesheet" href="bootstrap.css">
                <div class="alert alert-dismissible alert-success">
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    <strong>Alerta!</strong> <a href="utilizadores.jsp" class="alert-link">Sucesso!!!</a>
                </div>
                <%
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
            %>
            <link rel="stylesheet" href="bootstrap.css">
            <div class="alert alert-dismissible alert-warning">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <strong></strong> <a href="utilizadores.jsp" class="alert-link">Erro!!!</a>
            </div>
            <%
        }
    } else {
        response.sendRedirect("Erro.jsp");
    }
%>
