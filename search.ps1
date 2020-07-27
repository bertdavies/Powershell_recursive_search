<#
Script searches for strings within files (logs etc) in the current directory and its children


The script will generate a "searchResults_***Current Date***'.txt" in the Dir where it's executed
and will show if and where search terms were located and any errors thrown.

By Albert Davies 27/07/202020
#>


<# Setup file name #>
$filePrefix = 'searchResults_'
$this_date = Get-Date -Format "MM-dd-yyyy"
$file = -join($filePrefix,$this_date,".txt");
write-Output $FILE


<# Takes search term, checks for it in file contents #>
Function SearchFunction($term){
		try
			{
				$term | Add-Content $FILE
				<# If string occures, write path to log file #>
				Get-ChildItem -recurse | Select-String -pattern $term | group path | select name | Add-Content $FILE
			}
		catch
			{
				<# Output errors to log file #>
				"Caught an exception:" | Add-Content $FILE
				"Exception Type: $($_.Exception.GetType().FullName)" | Add-Content $FILE
				"Exception Message: $($_.Exception.Message)" | Add-Content $FILE

				<# Output errors to terminal #>
				write-host "Exception Type: $($_.Exception.GetType().FullName)"
				write-host "Exception Message: $($_.Exception.Message)"
			}
		finally
			{
				$finished = -join("Completed search for : ",$term);
				write-host $finished
				$finished | Add-Content $FILE
			}
		}


<# Search Terms #>
SearchFunction "Fubar"
SearchFunction "foo"
SearchFunction "503"




