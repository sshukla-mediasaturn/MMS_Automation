set TestCaseDirectory=%1
set ExTestDirectory=%2
echo $$$$$$$@@@@@ %2
for %%a in ("%TestCaseDirectory:#=" "%") do ( 
echo Processing DIR %%a
cd /d %%a
	For /R %%G in ("*.jmx") do (
	echo ######## %ExTestDirectory%
	cd /d %ExTestDirectory%
	extest.bat -n -t %%G -l %~dp0Report\ExTestResults.jtl
	echo =====================================
	echo Execution completed for %%G
	echo =====================================
	)
	REM uncomment below if delay is required after each group
	REM PING localhost -n 300 >NUL
)

