#taking ownship of files to change permission
echo "Taking Ownership of files"
takeown /f "C:\Windows\System32\mstsc.exe"
takeown /f "C:\Windows\System32\mstscax.dll"


#Applying permission changed to rename file.
echo "Giving permission over files"
$rule=new-object System.Security.AccessControl.FileSystemAccessRule ("$env:userdomain\$env:username","FullControl","Allow")
$acl = Get-ACL C:\Windows\System32\mstsc.exe
$acl.SetAccessRule($rule)
Set-ACL -Path C:\Windows\System32\mstsc.exe -AclObject $acl


$rule=new-object System.Security.AccessControl.FileSystemAccessRule ("$env:userdomain\$env:username","FullControl","Allow")
$acl = Get-ACL C:\Windows\System32\mstscax.dll
$acl.SetAccessRule($rule)
Set-ACL -Path C:\Windows\System32\mstscax.dll -AclObject $acl

#Rename Files
ren C:\Windows\System32\mstsc.exe mstsc.exe.1703
ren C:\Windows\System32\mstscax.dll mstscax.dll.1703

#Rename Files
ren C:\Windows\System32\mstsc.exe.bak mstsc.exe
ren C:\Windows\System32\mstscax.dll.bak mstscax.dll

#Giving Ownership back to file.
icacls "C:\Windows\System32\mstsc.exe" /setowner "NT Service\TrustedInstaller"
icacls "C:\Windows\System32\mstscax.dll" /setowner "NT Service\TrustedInstaller"
