## Setup Instructions (for Windows)


- Open powershell as an administrator and then run `Set-ExecutionPolicy RemoteSigned` (Answer `Y` to the Prompt).

- Open the folder containing this README file in windows file explorer. Right-click the file `create_server.ps1` and choose `run with powershell`. This will take a while to download all the required content.

- Close Steam if it is running and navigate to the newly created sub folder `.\
csgo\steamapps\csgo_ds`. Right Click on the file `start_server.bat` and choose `Run as Administrator` to launch your dedicated server.

### Caveats:

- Each time Step 2 is repeated, the server is **upgraded** and config is re-applied (overwritten) from the local config directory. So it's a good idea to use the local versions as the "master copies".

- Steps 1/2 may fail if you do not have powershell installed. Grab it from the [Microsoft](https://docs.microsoft.com/en-us/powershell/?view=powershell-6) website. Most newer versions of Windows ship with Powershell by default.

- Clients will need to add the server manually to their favourites by using the IP address of the server. From then on, they will be able to see it in their "Favourites" tab in the steam server browser.

- For good performance and lower VAR, you must have the server plugged ino power (if it is a laptop) and select **"Perormance Mode"** in your Windows power settings. You can also set the process priority to **"High"** using task manager. You can also adjust windows settings for best performance. Close all other applications while the server is running.

- You will need to open ports in the windows firewall to allow clients to connect. Both TCP and UDP ports 27015. Alternatively, if this is too complicated, you can just disable the firewall entirely for the duration of your scrim.

- The server will start in classic competitive mode and warmod will be enabled. You can disable warmod by using the `!admin` command and then execute the practice config (`exec practice.cfg`) from the console to go into practice mode. Practice mode will not work while warmod is active because warmod will stop you from buying grenades while in "warmup mode"


