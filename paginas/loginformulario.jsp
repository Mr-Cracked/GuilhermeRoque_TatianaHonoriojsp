<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="cabecalho.jsp" %> 
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulário de Login</title>
    <link rel="stylesheet" href="bootstrap.css">
</head>
<body>
    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="card shadow-lg p-3 mb-5 bg-white rounded" style="max-width: 400px;">
            <div class="card-body">
                <h4 class="card-title text-center">Login</h4>
                <form id="form2" name="form2" method="post" action="login.jsp">
                    <div class="form-group">
                        <label for="username">Nome de Utilizador:</label>
                        <input type="text" class="form-control" name="username" placeholder="Insira o seu utilizador" required>
                    </div>
                    <br>

                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" class="form-control" name="pass" placeholder="Insira a sua password" required>
                    </div>
                    <br>
                    <input type="submit" name="Submit" value="Entrar" class="btn btn-primary"/><br>
                </form>
            </div>
        </div>
    </div>
</body>
</html>