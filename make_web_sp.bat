@echo off
set next_sp_number=""
set last_sp_date=""
set Web_Next_sp_number_Last_sp_date_file_name=Web_Next_sp_number_Last_sp_date.txt

if exist %Web_Next_sp_number_Last_sp_date_file_name% for /f "tokens=1 delims= " %%i in (%Web_Next_sp_number_Last_sp_date_file_name%) do set next_sp_number=%%i

if exist %Web_Next_sp_number_Last_sp_date_file_name% for /f "tokens=2 delims= " %%i in (%Web_Next_sp_number_Last_sp_date_file_name%) do set last_sp_date=%%i


set current_date=%date:~0,4%%date:~5,2%%date:~8,2%
set sp_dir_name=web_sp%next_sp_number%-%current_date%
set sp_dir_name=%cd%\%sp_dir_name%

if not exist %sp_dir_name% md %sp_dir_name%

for /f "delims=" %%t in ('svn diff -r {%last_sp_date%} --summarize https://58.215.172.114:448/svn/SanGuo/trunk/mini-server/webmanager/wassabii_branch') do echo %%t >>b.txt

if exist b.txt (
	
setlocal enabledelayedexpansion

for /f "tokens=2 delims= " %%s in (b.txt) do (	
	set s=%%s
	set var=!s:/=;!
	set num=0
	set dir_name=%sp_dir_name%

	for %%s in ('!var!') do (set /a num+=1)

	if 9 equ !num! (
		for /f "tokens=9 delims=/" %%a in ("%%s") do (
			echo %%a|findstr ".php" > nul
			if !errorlevel! equ 0 (
				svn export %%s !dir_name! --force
			) else (
				set dir_name=!dir_name!\%%a 
				if not exist !dir_name! (md !dir_name!)
			)
		)
	)
	if 10 equ !num! (
		for /f "tokens=9,10 delims=/" %%a in ("%%s") do (
			set dir_name=!dir_name!\%%a
			if not exist !dir_name! (md !dir_name!)
			echo %%b|findstr ".php" > nul
			if !errorlevel! equ 0 (
				svn export %%s !dir_name! --force
			) else (
				set dir_name=!dir_name!\%%b
				if not exist !dir_name! (md !dir_name!)
			)
		)	
	)
	if 11 equ !num! (
		for /f "tokens=9,10,11 delims=/" %%a in ("%%s") do (
			set dir_name=!dir_name!\%%a
			if not exist !dir_name! (md !dir_name!)
			set dir_name=!dir_name!\%%b
			if not exist !dir_name! (md !dir_name!)
			echo %%c|findstr ".php" > nul
			if !errorlevel! equ 0 (
				svn export %%s !dir_name! --force
			) else (
				set dir_name=!dir_name!\%%c
				if not exist !dir_name! (md !dir_name!)
			)
		)	
	)
	if 12 equ !num! (
		for /f "tokens=9,10,11,12 delims=/" %%a in ("%%s") do (
			set dir_name=!dir_name!\%%a
			if not exist !dir_name! (md !dir_name!)
			set dir_name=!dir_name!\%%b
			if not exist !dir_name! (md !dir_name!)
			set dir_name=!dir_name!\%%c
			if not exist !dir_name! (md !dir_name!)
			echo %%d|findstr ".php" > nul
			if !errorlevel! equ 0 (
				svn export %%s !dir_name! --force
			) else (
				set dir_name=!dir_name!\%%d
				if not exist !dir_name! (md !dir_name!)
			)
		)	
	)
		
)

set /a next_sp_number=next_sp_number+1
echo !next_sp_number! %date:~0,4%-%date:~5,2%-%date:~8,2%>%Web_Next_sp_number_Last_sp_date_file_name%
if exist b.txt del /q /s b.txt
) else (
	echo "svn diff error!!!"
)


set application_database_config_dir=%sp_dir_name%\application\config
set application_database_config_ceshi_dir=%application_database_config_dir%\ceshi-config
set application_database_config_songshen_dir=%application_database_config_dir%\songshen-config
set application_database_config_shangxian_dir=%application_database_config_dir%\shangxian-config

if exist %application_database_config_ceshi_dir%\database.php (
	echo F| xcopy /Y /F %application_database_config_ceshi_dir%\database.php %application_database_config_dir%
)

if exist %application_database_config_ceshi_dir% (
	rd /s /q %application_database_config_ceshi_dir%
)
if exist %application_database_config_songshen_dir% (
	rd /s /q %application_database_config_songshen_dir%
)
if exist %application_database_config_shangxian_dir% (
	rd /s /q %application_database_config_shangxian_dir%
)


set award_send_database_config_dir=%sp_dir_name%\award_send
set award_send_database_config_ceshi_dir=%award_send_database_config_dir%\ceshi-config
set award_send_database_config_songshen_dir=%award_send_database_config_dir%\songshen-config
set award_send_database_config_shangxian_dir=%award_send_database_config_dir%\shangxian-config

if exist %award_send_database_config_ceshi_dir%\database_config.php (
	echo F| xcopy /Y /F %award_send_database_config_ceshi_dir%\database_config.php %award_send_database_config_dir%	
)

if exist %award_send_database_config_ceshi_dir% (
	rd /s /q %award_send_database_config_ceshi_dir%
)
if exist %award_send_database_config_songshen_dir% (
	rd /s /q %award_send_database_config_songshen_dir%
)
if exist %award_send_database_config_shangxian_dir% (
	rd /s /q %award_send_database_config_shangxian_dir%
)



set ggb_database_config_dir=%sp_dir_name%\ggb
set ggb_database_config_ceshi_dir=%ggb_database_config_dir%\ceshi-config
set ggb_database_config_songshen_dir=%ggb_database_config_dir%\songshen-config
set ggb_database_config_shangxian_dir=%ggb_database_config_dir%\shangxian-config

if exist %ggb_database_config_ceshi_dir%\config.php (
	echo F| xcopy /Y /F %ggb_database_config_ceshi_dir%\config.php %ggb_database_config_dir%	
)

if exist %ggb_database_config_ceshi_dir% (
	rd /s /q %ggb_database_config_ceshi_dir%
)
if exist %ggb_database_config_songshen_dir% (
	rd /s /q %ggb_database_config_songshen_dir%
)
if exist %ggb_database_config_shangxian_dir% (
	rd /s /q %ggb_database_config_shangxian_dir%
)


set unity_database_config_dir=%sp_dir_name%\unity
set unity_database_config_ceshi_dir=%unity_database_config_dir%\ceshi-config
set unity_database_config_songshen_dir=%unity_database_config_dir%\songshen-config
set unity_database_config_shangxian_dir=%unity_database_config_dir%\shangxian-config

if exist %unity_database_config_ceshi_dir%\self_config.php (
	echo F| xcopy /Y /F %unity_database_config_ceshi_dir%\self_config.php %unity_database_config_dir%
)

if exist %unity_database_config_ceshi_dir% (
	rd /s /q %unity_database_config_ceshi_dir%
)
if exist %unity_database_config_songshen_dir% (
	rd /s /q %unity_database_config_songshen_dir%
)
if exist %unity_database_config_shangxian_dir% (
	rd /s /q %unity_database_config_shangxian_dir%
)


set www_wassabii_pay_unity_database_config_dir=%sp_dir_name%\www_wassabii_pay\unity
set www_wassabii_pay_unity_database_config_ceshi_dir=%www_wassabii_pay_unity_database_config_dir%\ceshi-config
set www_wassabii_pay_unity_database_config_songshen_dir=%www_wassabii_pay_unity_database_config_dir%\songshen-config
set www_wassabii_pay_unity_database_config_shangxian_dir=%www_wassabii_pay_unity_database_config_dir%\shangxian-config

if exist %www_wassabii_pay_unity_database_config_ceshi_dir%\self_config.php (
	echo F| xcopy /Y /F %www_wassabii_pay_unity_database_config_ceshi_dir%\self_config.php %www_wassabii_pay_unity_database_config_dir%
)

if exist %www_wassabii_pay_unity_database_config_ceshi_dir% (
	rd /s /q %www_wassabii_pay_unity_database_config_ceshi_dir%
)
if exist %www_wassabii_pay_unity_database_config_songshen_dir% (
	rd /s /q %www_wassabii_pay_unity_database_config_songshen_dir%
)
if exist %www_wassabii_pay_unity_database_config_shangxian_dir% (
	rd /s /q %www_wassabii_pay_unity_database_config_shangxian_dir%
)	


pause

