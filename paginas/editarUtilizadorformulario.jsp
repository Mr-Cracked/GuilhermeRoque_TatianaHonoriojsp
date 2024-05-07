<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="cabecalho.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../basedados/basedados.h" %>
<%
if (session.getAttribute("tipo_utilizador") != null && Integer.parseInt(session.getAttribute("tipo_utilizador").toString()) == 3) {
    Statement stmt = null;
    ResultSet result = null;

    String nome = "";
    String morada = "";
    String email = "";
    String telemovel = "";
    Integer tipoUtilizador = 0;
    Integer id_utilizador = 0;

    String ID = request.getParameter("id_utilizador");
    if (ID != null) {
        stmt = conn.createStatement();
        result = stmt.executeQuery("SELECT * FROM utilizador WHERE id_utilizador='" + ID + "'");
    } else {
        response.sendRedirect("Erro.jsp");
    }

    if (result != null && result.next()) {
        nome = result.getString("nome");
        morada = result.getString("morada");
        email = result.getString("email");
        telemovel = result.getString("telemovel");
        tipoUtilizador = result.getInt("tipo_utilizador");
        id_utilizador = result.getInt("id_utilizador");
    } else {
        response.sendRedirect("Erro.jsp");
    }
%>

<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Utilizador</title>
    <link rel="stylesheet" href="bootstrap.css">
</head>
<body>

    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="card shadow-lg p-3 mb-5 bg-white rounded w-75">
            <div class="card-body">
                <h4 class="card-title text-center">Editar Utilizador</h4>
                <br>
                <form id="form1" name="form1" method="post" action="editarUtilizador.jsp">
                    <div class="form-group">
                        <label for="nivelacesso">Nível de Acesso:</label>
                        <select class="form-control" name="nivelacesso">
                            <%-- Opções do nível de acesso --%>
                            <%
                            Map<Integer, String> opcoesNivelAcesso = new LinkedHashMap<>();
                            opcoesNivelAcesso.put(-1, "Eliminado");
                            opcoesNivelAcesso.put(0, "Por aceitar");
                            opcoesNivelAcesso.put(1, "Aluno");
                            opcoesNivelAcesso.put(2, "Docente");
                            opcoesNivelAcesso.put(3, "Administrador");

                            for (Map.Entry<Integer, String> entry : opcoesNivelAcesso.entrySet()) {
                                Integer valor = entry.getKey();
                                String descricao = entry.getValue();
                                String selected = (valor == tipoUtilizador) ? "selected" : "";
                            %>
                            <option value="<%= valor %>" <%= selected %>><%= descricao %></option>
                            <%
                            }
                            %>
                        </select>
                    </div>
                    <br>
                    <div class="form-group">
                        <label for="id_utilizador">ID:</label>
                        <input type="text" class="form-control" name="id_utilizador" value="<%= id_utilizador %>" readonly>
                    </div>
                    <br>
                    <div class="form-group">
                        <label for="nome">Nome de Utilizador:</label>
                        <input type="text" class="form-control" name="nome" value="<%= nome %>" required>
                    </div>
                    <br>
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="text" class="form-control" name="password" value="">
                    </div>
                    <br>
                    <div class="form-group">
                        <label for="morada">Morada:</label>
                        <input type="text" class="form-control" name="morada" value="<%= morada %>" required>
                    </div>
                    <br>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" name="email" value="<%= email %>" required>
                    </div>
                    <br>
                    <div class="form-group">
                        <label for="telemovel">Telemóvel:</label>
                        <input type="tel" class="form-control" name="telemovel" value="<%= telemovel %>" required>
                    </div>
                    <br>
                    <input type="submit" name="Submit" value="Guardar" class="btn btn-primary"/>
                    <a href="utilizadores.jsp" class="btn btn-danger">Cancelar</a>
                    <br>
                </form>
            </div>
        </div>
    </div>

</body>
</html>

<%
} else {
    response.sendRedirect("Erro.jsp");
}
%>
