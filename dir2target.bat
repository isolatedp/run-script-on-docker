@ECHO OFF

SET script_dir=%~dp0
SET config_file=%script_dir%config.ini

REM Set config info
ECHO Step: Set config info

SET use_docker=""
SET container_name=""
SET mapping_dir=""
SET python_path=""
SET data_dir=""
SET data_dirname=""
for /f "usebackq tokens=1,2 delims== " %%G in ("%config_file%") do (
  if "%%G"=="use_docker" SET use_docker=%%H
  if "%%G"=="container_name" SET container_name=%%H
  if "%%G"=="mapping_dir" SET mapping_dir=%%H
  if "%%G"=="python" SET python_path=%%H
  if "%%G"=="data_dir" SET data_dir=%%H
  if "%%G"=="data_dirname" SET data_dirname=%%H
)

REM Check use Docker
ECHO Step: Check use Docker

if /i "%use_docker%"=="true" (
  REM Use Docker Python
  ECHO Step: Run script use docker env

  REM docker exec -it "%container_name%" python -c "print('SAY HELLO')"
  docker exec -it "%container_name%" mkdir -p /%mapping_dir%
  docker cp "%script_dir%scripts.py" "%container_name%:/%mapping_dir%/scripts.py"
  docker cp "%data_dir%" "%container_name%:/%mapping_dir%/%data_dirname%/"
  docker exec -it "%container_name%" python /"%mapping_dir%"/scripts.py
  docker exec -it "%container_name%" rm -rf /"%mapping_dir%"
 ) else (
  REM Use Local Python
  ECHO Step: Run script use local env
  REM "%python_path%" python -c "print('SAY HELLO')"
  "%python_path%" python scripts.py
 )

PAUSE