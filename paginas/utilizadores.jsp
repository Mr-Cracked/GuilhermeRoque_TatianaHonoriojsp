
<!DOCTYPE html>
<jsp:include page="cabecalho.jsp" />
<%@ include file="../basedados/basedados.h" %>
<%
    Statement stmt = conn.createStatement();
    ResultSet result = stmt.executeQuery("SELECT * FROM utilizador");
%>
<% if( session.getAttribute("tipo_utilizador") != null && Integer.parseInt(session.getAttribute("tipo_utilizador").toString()) == 3) {%>           
<html lang="pt">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil</title>
    <link rel="stylesheet" href="bootstrap.css">
</head>
<body>
    <div class="container d-flex justify-content-center align-items-center" style="height: 80vh;">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th scope="col">Nivel de Acesso</th> 
                    <th scope="col">Nome</th>
                    <th scope="col">Password</th>
                    <th scope="col">Morada</th>
                    <th scope="col">Email</th>
                    <th scope="col">Telemovel</th> 
                    <th scope="col">Editar</th>
                    <th scope="col">Eliminar</th>
                </tr>
            </thead>
            <tbody>
                <%
                
                while (result.next()) {
                %>
                <tr class="table-active">
                    <th scope="row"><%= result.getString("tipo_utilizador") %></th>
                    <td><%= result.getString("nome") %></td>
                    <td><%= result.getString("password") %></td>
                    <td><%= result.getString("morada") %></td>
                    <td><%= result.getString("email") %></td>
                    <td><%= result.getString("telemovel") %></td>
                    <td><a href="editarUtilizadorformulario.jsp?nome=<%= result.getString("nome") %>">Editar</a></td>
                    <td><a href="eliminarUtilizadorformulario.jsp?nome=<%= result.getString("nome") %>">Eliminar</a></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <div style="display: flex; justify-content: center;">
        <a type="button" class="btn btn-primary" href="adicionarUtilizadorformulario.jsp">Adicionar</a>
    </div>
</body>
</html>
<% } else { 
    response.sendRedirect("Erro.jsp");
} %>
