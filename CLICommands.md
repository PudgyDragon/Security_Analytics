# CLI Commands
Repository of commands and what they're used for in SSA.
## Security Analytics Specific Commands
<table>
  <tr>
    <td>
      <h2>Command</h2>
    </td>
    <td>
      <h2>Use</h2>
    </td>
    <td>
      <h2>sudo</h2>
    </td>
  </tr>
  <tr>
    <td>
      <p>atpsa-reserve-cpus</p>
    </td>
    <td>
      <p>Not applicable to virtual machines.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>build-ds-capture</p>
    </td>
    <td>
      <p>Constructions capture file system (partition, format, filesystem, fstab, mount, etc.). Ruby script. Uses a config file.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>build-ds-extras</p>
    </td>
    <td>
      <p>Constructs database/home-apache for JBOD systems (format, filesystem, fstab, mount, etc.). Ruby script.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>build-ds-index</p>
    </td>
    <td>
      <p>Constructs index file system (partition, format, filesystem, fstab, mount, etc.). Ruby script. Uses a config file. Replaces build-deepsee-index.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>carve-lsi</p>
    </td>
    <td>
      <p>Sets up both capture and index on JBODs. For LSI-based systems (carve and other options). Ruby script. Valid in versions 4.1.2+ and later.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>cfg_bond_interface.py</p>
    </td>
    <td>
      <p>A script to set the IP address of bond0.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>check-services</p>
    </td>
    <td>
      <p>Displays the status of known and expected services.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>check_slot_files</p>
    </td>
    <td>
      <p>Replaces dsfsck. Checks the DPDK file system and does limited repairs. Use when directed by Symantec Support.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>csr.sh</p>
    </td>
    <td>
      <p>Collects and concatenates log/config/status files into a single output tarball (Customer Service Report). Used for troubleshooting an appliance. BASH script</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsadduser</p>
    </td>
    <td>
      <p>Creates a new user on the appliance.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dmidecode</p>
    </td>
    <td>
      <p>Intel-based hardware only. Runs to see the appliance serial number or asset tag.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dscapture</p>
    </td>
    <td>
      <p>Instructs the appliance to capture network data.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsfilter</p>
    </td>
    <td>
      <p>Displays filters assigned to a specified interface.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsfirewall</p>
    </td>
    <td>
      <p>Toggles the IPv4 firewall on and off.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsfirewall6</p>
    </td>
    <td>
      <p>Toggles the IPv6 firewall on and off.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsfsck</p>
    </td>
    <td>
      <p>Check the DSFS file system and do limited repairs. Used when directed by Security Analytics Support.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dslc</p>
    </td>
    <td>
      <p>Configures the logging mechanisms (syslog, SNMP, email).</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dslicenseinfo</p>
    </td>
    <td>
      <p>Displays the license key and the features that are enabled on this appliance.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dslogdump</p>
    </td>
    <td>
      <p>Displays the events captured by the system log.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsmigrate</p>
    </td>
    <td>
      <p>Migrates capture data from a 7.x or 8.x appliance to an 8.x appliance.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsmigratedata</p>
    </td>
    <td>
      <p>Migrates capture data from one appliance to another. Not for migration to 8.x.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsmon</p>
    </td>
    <td>
      <p>Monitors the appliance in real time.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsmon-text</p>
    </td>
    <td>
      <p>Text-based specialization of dsmon.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dspcapimport</p>
    </td>
    <td>
      <p>Import PCAP files.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsportmapping</p>
    </td>
    <td>
      <p>Customizes your port-to-application mapping.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsregen</p>
    </td>
    <td>
      <p>Retransmits captured network traffic from a virtual network interface to a physical network interface.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsremoteimport</p>
    </td>
    <td>
      <p>Exists in the CLI; document DE-24421.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsrinfo</p>
    </td>
    <td>
      <p>Lightweight utility for capture file system config data (number of slots, recycle head location, etc.)(.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsseed</p>
    </td>
    <td>
      <p>Generate the weed file used for the license.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsstats</p>
    </td>
    <td>
      <p>Saves statistical information to a specified file.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsview</p>
    </td>
    <td>
      <p>Displays live statistics of your appliance</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsview-text</p>
    </td>
    <td>
      <p>Text-based specialization of dsview.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dsvmswitch</p>
    </td>
    <td>
      <p>Switches VM capture configuration: 2 sizes (1 large, 1 small). For the Security Analytics Virtual Appliance only.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>dszap</p>
    </td>
    <td>
      <p>Deletes ALL captured data (including indexes and reports) and reinitializes the data storage. Destroys all existing capture and index data.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  
  <tr>
    <td>
      <p>fix-iosched</p>
    </td>
    <td>
      <p>Script. Sets I/O scheduler options. Called in first boot.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>getpmap.sh</p>
    </td>
    <td>
      <p>Used by csr.sh. BASH script.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  
  <tr>
    <td>
      <p>lru_calc.sh</p>
    </td>
    <td>
      <p>Determine the size of the slot cache. BASH script.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>lsi-classify</p>
    </td>
    <td>
      <p>Wrapper around the LSI RAID controller classification scheme. Ruby script.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>lsi-make-good</p>
    </td>
    <td>
      <p>Helper utility to set physical disk state back to "good" in an LSI JBOD. BASH script</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>lsi-rate-tool</p>
    </td>
    <td>
      <p>Sets, resets, or shows rates as a percentage of CPU load for RAID manipulations such as background initialization, foreground initialization, consistency check, reconstructions, etc. BASH script.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>lsi-show</p>
    </td>
    <td>
      <p>Shows LSI RAID controller data in a condensed and summarized form. Ruby script.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  
  <tr>
    <td>
      <p>megacli / MegaCli</p>
    </td>
    <td>
      <p>LSI CLI tool</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>mkdsfs</p>
    </td>
    <td>
      <p>Builds a DSFS file system.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>mkfs.dsfs</p>
    </td>
    <td>
      <p>File-system-creation utility for the capture file system.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>mkfs.dsfs.vmware</p>
    </td>
    <td>
      <p>File-system-creation utility for the capture file system, used by the Security Analytics Virtual Appliance.</p>
    </td>
    <td>
      <p>Yes</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>oomstat.sh</p>
    </td>
    <td>
      <p>Handles out-of-memory conditions. BASH script.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>parted-report</p>
    </td>
    <td>
      <p>Wraps the parted output system-processing for partition size info. Ruby script.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>product-matrix-lookup</p>
    </td>
    <td>
      <p>Drive localization file names for the Security Analytics Appliance only (not VM or third-party installations); control product/model-based settings such as IRQ balance, serial-line name, X desktop support, management interface.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  
  <tr>
    <td>
      <p>scm pivot_only_provider</p>
    </td>
    <td>
      <p>Adds a reputation provider to use for manual submission.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>scm solera_acl elevate</p>
    </td>
    <td>
      <p>Restores a GUI account to admin status.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>scm solera_acl shell_only</p>
    </td>
    <td>
      <p>Creates a shell-only user.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>scm tally</p>
    </td>
    <td>
      <p>Enables user accounts, clears session controls.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  
  <tr>
    <td>
      <p>scotus</p>
    </td>
    <td>
      <p>Gracefully stop system-related services prior to performing other tasks.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>scsi-devices</p>
    </td>
    <td>
      <p>Wrapper around the SCSI-to-device-name mapping. Ruby script.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>solera_enet_config.py</p>
    </td>
    <td>
      <p>Orders Ethernet interfaces during first boot. Python script.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>solera-affinity</p>
    </td>
    <td>
      <p>Sets CPU affinities. Called from startup on boot for every boot. BASH script.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>update-sysctl</p>
    </td>
    <td>
      <p>Tune SYSCTL settings for optimal performance. BASH script.</p>
    </td>
    <td>
      <p>No</p>
    </td>
  </tr>
</table>

## Supported Linux Commands
<table>
  <tr>
    <td>
      <p>awk</p>
    </td>
    <td>
      <p>Combines the functions of grep and sed; allows substitution items from an input file's lines for items in a template, or performs calculations on numbers within a file.</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>cat</p>
    </td>
    <td>
      <p>Concatenates files and prints to the standard output.</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>chkconfig</p>
    </td>
    <td>
      <p>Updates and queries runlevel information for system services.</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>cp</p>
    </td>
    <td>
      <p>Copies files and directories.</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>date</p>
    </td>
    <td>
      <p>Prints or sets the system date and time.</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>ethtool</p>
    </td>
    <td>
      <p>Queries settings of an Ethernet device and changes them.</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>grep</p>
    </td>
    <td>
      <p>Searches files for lines containing specified criteria.</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>head</p>
    </td>
    <td>
      <p>Prints the first n lines of files to the standard output (default = 10 lines).</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>hwclock</p>
    </td>
    <td>
      <p>Queries and sets the hardware clock.</p>
    </td>
  </tr>
  <tr>
    <td>
      <p>ifconfig</p>
    </td>
    <td>
      <p></p>
    </td>
  </tr>
  <tr>
    <td>
      <p></p>
    </td>
    <td>
      <p></p>
    </td>
  </tr>
</table>
