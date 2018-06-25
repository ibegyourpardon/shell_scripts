@echo off  
@echo  修改 star_0001.png 为 1.png
@echo 系统自从排序，然后从1开始重新命名
@echo 只针对 png 如果是jpg需要适当修改脚本
set /a j=1
setlocal enabledelayedexpansion
for %%i in (*.png) do (
ren "%%i" !j!.png
set /a j+= 1
)
pause  