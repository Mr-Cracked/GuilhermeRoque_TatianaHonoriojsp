<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="cabecalho.jsp" />
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulário de Registo</title>
    <link rel="stylesheet" href="bootstrap.css">
</head>
<body>
    <?php include 'cabecalho.php'?>
    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="card shadow-lg p-3 mb-5 bg-white rounded" style="max-width: 400px;">
            <div class="card-body">
                <h4 class="card-title text-center">Registar</h4>
                Insira as suas informações
                <br>
                <form id="form1" name="form1" method="post" action="registar.jsp">
                    <div class="form-group">
                        <label for="username">Nome de Utilizador:</label>
                        <input type="text" class="form-control" name="username" placeholder="Insira o seu utilizador">
                    </div>
                    <br>

                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" class="form-control" name="password" placeholder="Insira a sua password">
                    </div>
                    <br>

                    <div class="form-group">
                        <label for="username">Morada:</label>
                        <input type="text" class="form-control" name="morada" placeholder="Insira a sua morada">
                    </div>
                    <br>
                    
                    <div class="form-group">
                        <label for="username">Email:</label>
                        <input type="email" class="form-control" name="email" placeholder="Insira o seu Email">
                    </div>
                    <br>

                    <div class="form-group">
                        <label for="username">Telemóvel:</label>
                        <input type="number" class="form-control" name="telemovel" placeholder="Insira o nº de telemóvel">
                    </div>
                    <br>
                    <input type="submit" name="Submit" value="registar" class="btn btn-primary"/><br>
                </form>
            </div>
        </div>
    </div>
</form>
</body>
</html>
