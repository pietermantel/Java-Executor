@echo off
set path=C:\Program Files\Java\jdk1.8.0_101\bin
set /p directory=Directory: 
set /p main=Class with main method: 
if %main%=="" (
	set main=Main
)

REM Add imports
cd %directory%
if not exist Imports (
	mkdir Imports
)

for /r %%i in (*) do (
	ECHO filename=%%~ni
	echo import java.util.regex.*; > Imports/%%~ni.java
	echo import java.util.*; >> Imports/%%~ni.java
	echo import java.text.*; >> Imports/%%~ni.java
	echo import java.io.*; >> Imports/%%~ni.java
	echo import javax.swing.*; >> Imports/%%~ni.java
	echo import java.awt.event.*; >> Imports/%%~ni.java
	echo import java.awt.*; >> Imports/%%~ni.java
	echo import java.awt.image.*; >> Imports/%%~ni.java
	type %%~ni.java >> Imports/%%~ni.java
)
cd Imports

javac -cp ".;Libraries/*" *.java && (
	if not exist classFiles (
		mkdir classFiles
	)
	move *.class classFiles
	cd classFiles
	
	REM Setting up manual executor
	echo java %main% > run.bat
	echo echo. > run.bat
	echo pause > run.bat
	
	cls
	java %main%
	echo.
	pause
	exit
) || (
	pause
)