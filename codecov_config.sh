$CODECOV_TOKEN=550e9816-7716-4683-ae17-5dee6cb27593
Invoke-WebRequest -Uri https://uploader.codecov.io/latest/windows/codecov.exe 
-Outfile codecov.exe
.\codecov.exe -t 550e9816-7716-4683-ae17-5dee6cb27593

