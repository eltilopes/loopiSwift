//
//  RestConfig.swift
//  Loopi
//
//  Created by Loopi on 13/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

class RestConfig{
    
    public var TOKEN = "token"
    public var LOGIN = "login"
    public var TEM_CONVITE = "tem_convite"
    public var USER = "user"
    public var ACCESS_TOKEN = "access_token"
    public var USUARIO = "USUARIO"
    public var PROFISSIONAL = "PROFISSIONAL"
    public var SERVICO_CARD = "SERVICO_CARD"
    public var LOCALIZACAO = "LOCALIZACAO"
    public var MESSAGE = "message"
    public var CODIGO_NAO_CONFERE = "Codigo nao confere"
    public var COD_CODIGO_NAO_CONFERE = 60
    public var ERROR = "error"
    public var ERRORS = "errors"
    public var ERROR_DESCRIPTION = "error_description"
    public var INVALID_ACCESS_TOKEN = "Invalid access token"
    //public var API_URL = "https://loopi.online/loopi"
    public var API_URL = "http://192.168.0.13:8080/allinoneserver"
    public var BUSCAR_CEP_URL = "https://api.postmon.com.br/v1/cep/"
    public var URL_LISTAR_SERVICO = "/servico/listar"
    public var URL_SOLICITAR_CONVITE = "/convite/solicitar"
    public var URL_SOLICITAR_SERVICO = "/servico/solicitar"
    public var URL_LISTAR_CATEGORIA = "/categoria/listar"
    public var URL_LISTAR_SUB_CATEGORIA = "/subcategoria/listar"
    public var URL_LISTAR_FAVORITO = "/profissional/favoritos"
    public var URL_SALVAR_FAVORITO = "/profissional/favorito"
    public var URL_REMOVER_FAVORITO = "/profissional/desfavoritar"
    public var URL_OAUTH_TOKEN = "/oauth/token"
    public var URL_LOGOUT = "/usuario/logout"
    public var URL_EDITAR_USUARIO = "/usuario/editar"
    public var URL_RESGATAR_SENHA = "/usuario/resgatarSenha"
    public var URL_ALTERAR_SENHA = "/usuario/alterarSenha"
    public var GET_METHOD = "GET"
    public var POST_METHOD = "POST"
    public var DELETE_METHOD = "DELETE"
    public var HTTP_HEADER_FIELD_CONTENT_TYPE = "Content-Type"
    public var HTTP_HEADER_FIELD_ACCEPT = "Accept"
    public var HTTP_HEADER_FIELD_AUTHORIZATION = "Authorization"
    public var HTTP_HEADER_VALUE_APPLICATION_JSON = "application/json"
    public var HTTP_HEADER_VALUE_APPLICATION_FORM = "application/x-www-form-urlencoded"
    public var HTTP = "http"
    public var HTTPS = "https"
    
}

