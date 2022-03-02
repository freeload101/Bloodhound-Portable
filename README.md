# Bloodhound-Portable
Bloodhound Portable for Windows (You can run this without local admin. No Administrator required ! )

1) Download the .bat file
2) start new command prompt
3) run as target domain user OR runas /netonly /user:"US.COMPANY.DOMAIN.COM\UESERNAME@COMPANY.COM" cmd  for or try /user:"DOMAIN\USERNAME" to run SharpHound.exe Reference: https://bloodhound.readthedocs.io/en/latest/data-collection/sharphound.html?highlight=netonly#running-sharphound-from-a-non-domain-joined-system 



** You may need to whitelist or disable Bloodhound/Sharphound in your Endpoint Security Software ( Or just obfucate it if your lucky... Resource Hacker or echo '' >> Sharphound.exe etc  ...  ) **

** Last tested Bloodhound 4.1.0 **


![image](https://user-images.githubusercontent.com/4307863/153485618-6bf743af-b5a9-4f88-b0ab-0ad24fed4556.png)

Credit: 
https://bloodhound.readthedocs.io/en/latest/_images/SharpHoundCheatSheet.png

![image](https://user-images.githubusercontent.com/4307863/156181140-951cc25d-d6f7-4385-8520-9980869a7ee2.png)
