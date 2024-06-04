<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="cabecalho.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../basedados/basedados.h" %>
<%
if (session.getAttribute("tipo_utilizador") != null && Integer.parseInt(session.getAttribute("tipo_utilizador").toString()) == 3) {


    Statement stmt = null;
    ResultSet rs = null;

    stmt = conn.createStatement();

    String sql = "SELECT * FROM utilizador WHERE id_utilizador ='" + request.getParameter("id") + "'";
    rs = stmt.executeQuery(sql);

    rs.next();
    
    String nome = rs.getString("nome");
    String morada = rs.getString("morada");
    String email = rs.getString("email");
    Integer telemovel = rs.getInt("telemovel");
    Integer tipoUser = rs.getInt("tipo_utilizador");
    Integer id_utilizador = rs.getInt("id_utilizador");
    
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
                            <%
                           String[][] niveisAcesso = {
                                {"-1", "Eliminado"},
                                {"0", "Por aceitar"},
                                {"1", "Aluno"},
                                {"2", "Docente"},
                                {"3", "Administrador"}
                            };

                            for (String[] nivel : niveisAcesso) {
                                int valor = Integer.parseInt(nivel[0]);
                                String descricao = nivel[1];
                                String selected = (valor == tipoUser) ? "selected" : "";
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
                        <input type="text" class="form-control" name="pass" value="">
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
