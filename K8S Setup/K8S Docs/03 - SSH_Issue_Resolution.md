
# SSH Issue Resolution – Root Login & Password Authentication on Linux

## Step 1: Check SSH Effective Settings
```bash
sshd -T | grep -E "permitrootlogin|passwordauthentication"
```

**Note:** If the above does NOT show:
```
permitrootlogin yes
passwordauthentication yes
```
then edit the SSH config file:
```bash
vi /etc/ssh/sshd_config
```

Inside the file, ensure these lines are present and uncommented:
```
PermitRootLogin yes
PasswordAuthentication yes
PermitEmptyPasswords yes
```

## Step 2: Reload and Restart SSH Services
```bash
systemctl daemon-reload
systemctl restart ssh
systemctl restart ssh.socket
```

## Step 3: Verify SSH Effective Settings Again
```bash
sshd -T | grep -E "permitrootlogin|passwordauthentication"
```

## Step 4: Check Root Account Status
```bash
sudo passwd -S root
```

**If the root account is locked (shows 'L'), unlock it:**
```bash
sudo passwd -u root       # unlock root
sudo passwd root          # set a new root password
```

## Step 5: Restart SSH Daemon
```bash
systemctl restart sshd
```

✅ After this, root login and password authentication should work over SSH.
