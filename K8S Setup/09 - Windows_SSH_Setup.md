
# Step-by-Step: Enable SSH Server on Windows and Connect from Ubuntu

## ✅ Step 1 — Install OpenSSH Server on Windows
1. Login to Windows → open **PowerShell as Administrator** and run:
```powershell
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```
2. Start the SSH service:
```powershell
Start-Service sshd
```
3. Enable automatic startup:
```powershell
Set-Service -Name sshd -StartupType 'Automatic'
```

## ✅ Step 2 — Allow SSH through Firewall
```powershell
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
```

## ✅ Step 3 — Check sshd Status
```powershell
Get-Service sshd
```
- If status is **Running**, continue.

## ✅ Step 4 — Connect from Ubuntu Master
- On Ubuntu master (e.g., `172.16.106.41`) connect to Windows:
```bash
ssh Administrator@172.16.106.46
```
- Or use another Windows user account.  
- You will be prompted to enter the password → authenticate → logged in.

### 💡 Optional: Use SSH Keys Instead of Password
1. From Ubuntu master, generate SSH key pair:
```bash
ssh-keygen
```
2. Copy SSH public key to Windows:
```bash
ssh-copy-id Administrator@172.16.106.46
```
- Or manually paste the key into:
```
C:\Users\Administrator\.ssh\authorized_keys
```

### 🟢 Done
- After this, you can run all Windows commands from the Ubuntu master terminal.
