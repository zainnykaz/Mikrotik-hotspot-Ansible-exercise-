## Project Workflow

# Step 1: Virtual Environment Setup (ESXi)
### CHR Acquisition:
Downloaded the official MikroTik CHR OVA image from the MikroTik Download Page.
### VM Deployment: 
Imported the OVA into an existing ESXi server. Assigned a standard VM Network adapter for initial management.
### Initialization: 
Booted the VM and accessed the console. Logged in with the default admin user (no password) and updated the password to admin. 

# Step 2: Firewall Management via Winbox
### Connectivity: 
Connected to the CHR using Winbox via the MAC address discovery feature in the "Neighbors" tab.
### Initial Provisioning: 
Configured basic networking, including static IP assignment to the management interface and DNS settings.
### Security Rule Creation: 
Navigated to IP > Firewall > Filter Rules and implemented a drop rule:

- Chain: forward
- Dst. Address: 1.1.1.1
- Protocol: 6 (tcp)
- Dst. Port: 443
- Action: drop
- Evidence: Captured the configuration as Firewall.png.

# Step 3: Ansible Automation
### Environment Setup: 
Installed Ansible on a Ubuntu-based Linux machine following the Official Installation Guide.
### Inventory Management: 
Defined the CHR’s IP address and credentials within the Ansible hosts file.
### Playbook Development: 
Authored RADIUS.yml to automate the RADIUS client setup.
### Target Parameters: 
Server 35.227.71.209, Secret testing123, and Service hotspot.
### Deployment: 
Executed ansible-playbook RADIUS.yml and confirmed the task status returned "changed".

# Step 4: Verification & Documentation
### Logs: 
Captured the terminal output of the playbook execution as Ansible.png.
### UI Validation: 
Verified the new RADIUS entry within the Winbox Radius menu. Documentation saved as RADIUS.png.

# Step 5: Network Expansion & Hotspot Configuration
### Hardware Expansion: 
Added a secondary Network Adapter to the VM settings in ESXi to act as the Local Area Network (LAN).
### Network Addressing: 
- **Assigned 10.10.10.0/24** to the new interface (ether2).
- Configured a DHCP Server on ether2 to provide leases to hotspot clients.
- Added a Source NAT (Masquerade) rule in the Firewall to allow internet traffic for the hotspot network.
  
### Hotspot Deployment: 
- Ran the Hotspot Setup Wizard under IP > Hotspot on the ether2 interface.
- Functional Testing: Attached a separate Virtual Machine to the same port group as ether2 to verify the captive portal redirection and connectivity.
### Configuration Export: Generated a full configuration backup via the terminal:
- /export file=chr.rsc
### Data Retrieval: 
Exported the chr.rsc file from the MikroTik "Files" directory to the local workstation.

### References:

- https://mikrotik.com/download/chr
- https://docs.ansible.com/projects/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu
- https://docs.ansible.com/projects/ansible/latest/collections/community/routeros/index.html
