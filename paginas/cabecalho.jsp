<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Seu Título Aqui</title>
    <link rel="stylesheet" href="bootstrap.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg bg-primary" data-bs-theme="dark">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Menu</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-between" id="navbarNav">
                <ul class="navbar-nav nav nav-pills">
                    <% 
                    if (session.getAttribute("tipo_utilizador") != null && Integer.parseInt(session.getAttribute("tipo_utilizador").toString()) > 0) { 
                        
                        int tipoUtilizador = Integer.parseInt(session.getAttribute("tipo_utilizador").toString());
                        
                        switch (tipoUtilizador) { 
                            case 1:
                    %>
                                <li class="nav-item">
                                    <a class="nav-link" href="perfil.jsp">Perfil</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="cursos.jsp">Cursos</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="inscricoes.jsp">Inscrições</a>
                                </li>
                    <%      
                                break;
                            case 2:
                    %>
                                <li class="nav-item">
                                    <a class="nav-link" href="cursoformulario.jsp">Curso</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="perfil.jsp">Perfil</a>
                                </li>
                    <%      
                                break;
                            case 3:
                    %>
                                <li class="nav-item">
                                    <a class="nav-link" href="perfil.jsp">Perfil</a>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Gerir</a>
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item" href="cursos.jsp">Cursos</a>
                                        <a class="dropdown-item" href="utilizadores.jsp">Utilizadores</a>
                                    </div>
                                </li>
                    <%      
                                break;
                        }
                    }
                    %>
                    <li class="nav-item">
                        <a class="nav-link" href="informacoes.jsp">Informações</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <% 
                    
                    if (session.getAttribute("tipo_utilizador") == null) { 
                    %>
                        <li class="nav-item">
                            <a class="btn btn-secondary my-0 my-sm-0" href="registarformulario.jsp">Registar</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-secondary my-0 my-sm-0" href="loginformulario.jsp">Login</a>
                        </li>
                    <% 
                    } else { 
                    %>
                        <li class="nav-item">
                            <a class="btn btn-secondary my-0 my-sm-0" href="sair.jsp">Sair</a>
                        </li>
                    <% 
                    } 
                    %>
                </ul>
            </div>
        </div>
    </nav>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
