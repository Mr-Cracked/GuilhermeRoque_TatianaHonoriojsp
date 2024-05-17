<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%

    if (Integer.parseInt(session.getAttribute("tipo_utilizador").toString()) == 3) {
        String[] docentes = request.getParameterValues("docentes[]");
        out.println(docentes);
        String nome = request.getParameter("nome");
        int vagas = Integer.parseInt(request.getParameter("vagas"));
        String descricao = request.getParameter("descricao");
        String datainicStr = request.getParameter("datainic");
        String datafimStr = request.getParameter("datafim");

        // Convertendo as datas de String para java.sql.Date
        java.sql.Date datainic = java.sql.Date.valueOf(datainicStr);
        java.sql.Date datafim = java.sql.Date.valueOf(datafimStr);

        if (datafim.compareTo(datainic) <= 0) {
            %>
            <link rel="stylesheet" href="bootstrap.css">
            <div class="alert alert-dismissible alert-danger">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <strong>Erro!</strong> <a href="adicionarCursoformulario.jsp" class="alert-link">As datas têm de ser válidas!!!</a>
            </div>
            <%
        } else if (docentes == null) {
            %>
            <link rel="stylesheet" href="bootstrap.css">
            <div class="alert alert-dismissible alert-danger">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <strong>Erro!</strong> <a href="adicionarCursoformulario.jsp" class="alert-link">Insira docente(s)!!!</a>
            </div>
            <%
        } else {
            PreparedStatement pstmt = null;
            ResultSet rs = null;

                String sql = "SELECT * FROM curso WHERE nome = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, nome);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    %>
                    <link rel="stylesheet" href="bootstrap.css">
                    <div class="alert alert-dismissible alert-danger">
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        <strong>Erro!</strong> <a href="adicionarCursoformulario.jsp" class="alert-link">Curso já existe!!!</a>
                    </div>
                    <%
                } else {
                    pstmt = conn.prepareStatement("INSERT INTO curso (nome, descricao, vagas, data_inicio, data_fim) VALUES (?, ?, ?, ?, ?)");
                    pstmt.setString(1, nome);
                    pstmt.setString(2, descricao);
                    pstmt.setInt(3, vagas);
                    pstmt.setDate(4, datainic);
                    pstmt.setDate(5, datafim);

                    int res = pstmt.executeUpdate();

                    if (res > 0) {
                        rs = pstmt.getGeneratedKeys();
                        rs.next();
                        int cursoId = rs.getInt(1);

                        pstmt = conn.prepareStatement("INSERT INTO leciona(id_utilizador, id_curso) VALUES(?, ?)");
                        
                        for (String docente : docentes) {
                            pstmt.setInt(1, Integer.parseInt(docente));
                            pstmt.setInt(2, cursoId);
                            pstmt.executeUpdate();
                        }
                        %>
                        <link rel="stylesheet" href="bootstrap.css">
                        <div class="alert alert-dismissible alert-success">
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            <strong>Alerta!</strong> <a href="cursos.jsp" class="alert-link">Sucesso!!!</a>
                        </div>
                        <%
                    } else {
                        %>
                        <link rel="stylesheet" href="bootstrap.css">
                        <div class="alert alert-dismissible alert-danger">
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            <strong>Erro!</strong> <a href="adicionarCursoformulario.jsp" class="alert-link">Erro ao inserir!!!</a>
                        </div>
                    <%
                    }
                }
            }
    } else {
        response.sendRedirect("Erro.jsp");
    }
%>
