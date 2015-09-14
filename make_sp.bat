
set next_sp_number=""
set last_sp_date=""
set Next_sp_number_Last_sp_date_file_name=Next_sp_number_Last_sp_date.txt

if exist %Next_sp_number_Last_sp_date_file_name% for /f "tokens=1 delims= " %%i in (%Next_sp_number_Last_sp_date_file_name%) do set next_sp_number=%%i

if exist %Next_sp_number_Last_sp_date_file_name% for /f "tokens=2 delims= " %%i in (%Next_sp_number_Last_sp_date_file_name%) do set last_sp_date=%%i


set current_date=%date:~0,4%%date:~5,2%%date:~8,2%
set sp_dir_name=sp%next_sp_number%-%current_date%
set pre_dir=%cd%\%sp_dir_name%

md %pre_dir%\sql
md %pre_dir%\sql\z_gamedb
md %pre_dir%\sql\z_gamelog

md %pre_dir%\Zgs
md %pre_dir%\Zgs\config
md %pre_dir%\Zgs\script
md %pre_dir%\Zgs\share_config

md %pre_dir%\Zlg
md %pre_dir%\Zlg\config
md %pre_dir%\Zlg\share_config


for /f "delims=" %%t in ('svn diff -r {%last_sp_date%} --summarize https://58.215.172.114:448/svn/SanGuo/trunk/mini-server/server_release_branch/v1.0.0.1_ios/Zgs/config') do echo %%t >>a.txt
if exist a.txt for /f "tokens=2 delims= " %%i in (a.txt) do svn export %%i ./%sp_dir_name%/Zgs/config --force
if exist a.txt del /q /s a.txt

for /f "delims=" %%t in ('svn diff -r {%last_sp_date%} --summarize https://58.215.172.114:448/svn/SanGuo/trunk/mini-server/server_release_branch/v1.0.0.1_ios/Zgs/script') do echo %%t >>a.txt
if exist a.txt for /f "tokens=2 delims= " %%i in (a.txt) do svn export %%i ./%sp_dir_name%/Zgs/script --force
if exist a.txt del /q /s a.txt

for /f "delims=" %%t in ('svn diff -r {%last_sp_date%} --summarize https://58.215.172.114:448/svn/SanGuo/trunk/mini-server/server_release_branch/v1.0.0.1_ios/Zgs/share_config') do echo %%t >>a.txt
if exist a.txt for /f "tokens=2 delims= " %%i in (a.txt) do svn export %%i ./%sp_dir_name%/Zgs/share_config --force
if exist a.txt del /q /s a.txt



for /f "delims=" %%t in ('svn diff -r {%last_sp_date%} --summarize https://58.215.172.114:448/svn/SanGuo/trunk/mini-server/server_release_branch/v1.0.0.1_ios/Zlg/config') do echo %%t >>a.txt
if exist a.txt for /f "tokens=2 delims= " %%i in (a.txt) do svn export %%i ./%sp_dir_name%/Zlg/config --force
if exist a.txt del /q /s a.txt

for /f "delims=" %%t in ('svn diff -r {%last_sp_date%} --summarize https://58.215.172.114:448/svn/SanGuo/trunk/mini-server/server_release_branch/v1.0.0.1_ios/Zlg/share_config') do echo %%t >>a.txt
if exist a.txt for /f "tokens=2 delims= " %%i in (a.txt) do svn export %%i ./%sp_dir_name%/Zlg/share_config --force
if exist a.txt del /q /s a.txt


for /f "delims=" %%t in ('svn diff -r {%last_sp_date%} --summarize https://58.215.172.114:448/svn/SanGuo/trunk/mini-server/server_release_branch/v1.0.0.1_ios/sql/z_gamedb') do echo %%t >>a.txt
if exist a.txt for /f "tokens=2 delims= " %%i in (a.txt) do svn export %%i ./%sp_dir_name%/sql/z_gamedb --force
if exist a.txt del /q /s a.txt

for /f "delims=" %%t in ('svn diff -r {%last_sp_date%} --summarize https://58.215.172.114:448/svn/SanGuo/trunk/mini-server/server_release_branch/sql_update/1.0.0.1_ios/z_gamedb') do echo %%t >>a.txt
if exist a.txt for /f "tokens=2 delims= " %%i in (a.txt) do svn export %%i ./%sp_dir_name%/sql/z_gamedb --force
if exist a.txt del /q /s a.txt

for /f "delims=" %%t in ('svn diff -r {%last_sp_date%} --summarize https://58.215.172.114:448/svn/SanGuo/trunk/mini-server/server_release_branch/v1.0.0.1_ios/sql/z_gamelog') do echo %%t >>a.txt
if exist a.txt for /f "tokens=2 delims= " %%i in (a.txt) do svn export %%i ./%sp_dir_name%/sql/z_gamelog --force
if exist a.txt del /q /s a.txt

for /f "delims=" %%t in ('svn diff -r {%last_sp_date%} --summarize https://58.215.172.114:448/svn/SanGuo/trunk/mini-server/server_release_branch/sql_update/1.0.0.1_ios/z_gamelog') do echo %%t >>a.txt
if exist a.txt for /f "tokens=2 delims= " %%i in (a.txt) do svn export %%i ./%sp_dir_name%/sql/z_gamelog --force
if exist a.txt del /q /s a.txt


net use \\GONGSI-NEIWANG\ipc$ 201309161510/user:administrator

xcopy \\GONGSI-NEIWANG\build\zhs\1.0\v1.0.0.1_ios\last-build\Zgs\gameserverx64.exe %pre_dir%\Zgs /Y
xcopy \\GONGSI-NEIWANG\build\zhs\1.0\v1.0.0.1_ios\last-build\Zgs\gameserverx64.pdb %pre_dir%\Zgs /Y


xcopy \\GONGSI-NEIWANG\build\zhs\1.0\v1.0.0.1_ios\last-build\Zlg\loginserverx64.exe %pre_dir%\Zlg /Y
xcopy \\GONGSI-NEIWANG\build\zhs\1.0\v1.0.0.1_ios\last-build\Zlg\loginserverx64.pdb %pre_dir%\Zlg /Y


echo %next_sp_number% %date:~0,4%-%date:~5,2%-%date:~8,2%>%Next_sp_number_Last_sp_date_file_name%

zhengshu_automation.exe

set /a next_sp_number=next_sp_number+1
echo %next_sp_number% %date:~0,4%-%date:~5,2%-%date:~8,2%>%Next_sp_number_Last_sp_date_file_name%


pause