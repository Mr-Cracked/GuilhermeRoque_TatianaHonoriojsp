<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../basedados/basedados.h" %>
<%
if (session.getAttribute("tipo_utilizador") != null && (Integer) session.getAttribute("tipo_utilizador") == 3) {
    Integer id = Integer.parseInt(request.getParameter("id_curso").toString());
    String nome = request.getParameter("nome");
    String descricao = request.getParameter("descricao");
    Integer vagas = Integer.parseInt(request.getParameter("vagas").toString());
    String data_inicStr = request.getParameter("data_inic");
    String data_fimStr = request.getParameter("data_fim");
    String metodo = request.getParameter("metodo");

    java.sql.Date datainic = java.sql.Date.valueOf(data_inicStr);
    java.sql.Date datafim = java.sql.Date.valueOf(data_fimStr);

    String[] docentesStr = request.getParameterValues("docentes");
    int[] docentes = null;
    
    if (docentesStr != null) {
        docentes = new int[docentesStr.length];

        for (int i = 0; i < docentesStr.length; i++) {
            docentes[i] = Integer.parseInt(docentesStr[i]);
        }

        String sql = "UPDATE curso SET nome=?, descricao=?, vagas=?, data_inicio=?, data_fim=?, metodo_selecao=? WHERE id_curso=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, nome);
        pstmt.setString(2, descricao);
        pstmt.setInt(3, vagas);
        pstmt.setDate(4, datainic);
        pstmt.setDate(5, datafim);
        pstmt.setString(6, metodo);
        pstmt.setInt(7, id);
        int result = pstmt.executeUpdate();

        

        
        if (result > 0) {
            
            sql = "DELETE FROM leciona WHERE id_curso = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();

        
            for (int docente : docentes) {
                sql = "INSERT INTO leciona(id_utilizador, id_curso) VALUES(?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, docente);
                pstmt.setInt(2, id);
                pstmt.executeUpdate();
            }
            %>
            <link rel="stylesheet" href="bootstrap.css">
            <div class="alert alert-dismissible alert-success">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <strong></strong> <a href="cursos.jsp" class="alert-link">Sucesso!!!</a>
            </div>
            <%
        } else {
            %>
            <link rel="stylesheet" href="bootstrap.css">
            <div class="alert alert-dismissible alert-danger">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <strong></strong> <a href="cursos.jsp" class="alert-link">Erro ao editar!!!</a>
            </div>
            <%
        }

    }else{
        out.println("<link rel=\"stylesheet\" href=\"bootstrap.css\">");
        out.println("<div class=\"alert alert-dismissible alert-danger\">");
        out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>");
        out.println("<strong></strong> <a href=\"cursos.jsp\" class=\"alert-link\">INSIRA DOCENTES!!!</a>");
        out.println("</div>");
    }

    
} else {
    response.sendRedirect("Erro.jsp");
}
%>
