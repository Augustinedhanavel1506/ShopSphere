@echo off
setlocal

set "JAVA_HOME=C:\Program Files\Java\jdk-21.0.10"
set "MAVEN_HOME=%~dp0.mvn\wrapper\dist\apache-maven-3.9.16"

"%MAVEN_HOME%\bin\mvn.cmd" %*
