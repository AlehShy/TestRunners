@ECHO OFF
::========================================
::SET GITHUB_ACCOUNT=AlehShy
::SET WS_DIR=Workspace
::SET repo_name=Single_Title_validation
::SET APP_VERSION=1.6
::SET MAIN_CLASS=core.SeleniumSingle
::SET ARGS_01="http://www.git-scm.com|Git"
::SET ARGS_02=
::========================================
::========================================
SET GITHUB_ACCOUNT=%1
SET WS_DIR=%2
SET REPO_NAME=%3
SET APP_VERSION=%4
SET MAIN_CLASS=%5
SET ARGS_01=%6
::========================================
IF "%JAVA_HOME%" == "" GOTO EXIT_JAVA
ECHO Java installed
IF "%M2%" == "" GOTO EXIT_MVN
ECHO Maven installed
CALL git --version > nul 2>&1
IF NOT %ERRORLEVEL% == 0 GOTO EXIT_GIT
ECHO Git installed
GOTO NEXT
:NEXT
CD C:\%WS_DIR%
IF NOT EXIST C:\%WS_DIR% GOTO NO_WORKSPACE
IF EXIST C:\%WS_DIR%\%repo_name% RMDIR /S /Q C:\%WS_DIR%\%repo_name%
git clone git@github.com:%GITHUB_ACCOUNT%/%REPO_NAME%.git
CD %repo_name%
SLEEP 2
CALL mvn package -Dbuild.version="%APP_VERSION%" -Dmain.class="%MAIN_CLASS%"
ECHO.
ECHO Executing Java programm ...
java -jar C:\%WS_DIR%\%REPO_NAME%\target\%REPO_NAME%-%APP_VERSION%-jar-with-dependencies.jar %ARGS_01%
GOTO END
:EXIT_JAVA
ECHO No Java installed
GOTO END
:EXIT_MVN
ECHO No Maven installed
GOTO END
:EXIT_GIT
ECHO No Git installed
GOTO END
:NO_WORKSPACE
ECHO %WS_DIR% is not exists
GOTO END
:END
CD\