<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    Integer tipoUtilizador = (Integer) session.getAttribute("tipo_utilizador");

    if (tipoUtilizador != null && tipoUtilizador == 3) {
        String id = request.getParameter("id");
        String idCurso = request.getParameter("id_curso");

        if (id != null && idCurso != null) {
            Statement stmt = null;

            stmt = conn.createStatement();

            String sql = "UPDATE inscricao SET estado = 1 WHERE id_utilizador = '" + id + "' AND id_curso = '" + idCurso + "'";
            int result = stmt.executeUpdate(sql);

            if (result > 0) {
                sql = "UPDATE curso SET vagas_preenchidas = vagas_preenchidas + 1 WHERE id_curso = '" + idCurso + "'";
                result = stmt.executeUpdate(sql);

                if (result > 0) {
                    out.print("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                    out.print("<div class=\"alert alert-dismissible alert-success\">");
                    out.print("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                    out.print("<strong>Alerta!</strong> <a href=\"cursos.jsp\" class=\"alert-link\">Sucesso!!!</a></div>");
                } else {
                    out.print("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                    out.print("<div class=\"alert alert-dismissible alert-danger\">");
                    out.print("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                    out.print("<strong></strong> <a href=\"cursos.jsp\" class=\"alert-link\">Erro ao Aceitar!!!</a></div>");
                }
            } else {
                out.print("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
                out.print("<div class=\"alert alert-dismissible alert-danger\">");
                out.print("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
                out.print("<strong></strong> <a href=\"cursos.jsp\" class=\"alert-link\">Erro ao Aceitar!!!</a></div>");
            }
        } else {
            out.print("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
            out.print("<div class=\"alert alert-dismissible alert-danger\">");
            out.print("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
            out.print("<strong></strong> <a href=\"cursos.jsp\" class=\"alert-link\">Erro ao Aceitar!!!</a></div>");
        }
    } else {
        response.sendRedirect("Erro.jsp");
    }
%>
</body>
</html>
