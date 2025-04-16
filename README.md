<h1>Security Analytics</h1>

<p>Repository for Bluecoat/Symantec/Broadcom Security Analytics (SSA) guides. Guides are based on personal experiences with the Security Analytics software. I hope that my troubleshooting saves someone else some headache.</p>

<h1>Table of Contents</h1>
<h2>Guides</h2>
<table>
  <tbody>
    <tr>
      <td>
        <a href="https://github.com/PudgyDragon/Security_Analytics/blob/main/Installation_Guide.md">Installation Guide</a>
      </td>
      <td>This is an installation guide for installing Broadcom Security Analytics software on your own Dell asset. Current online guides only seem to be available for virtual appliances, and there weren't any that I could find for installing on your own appliance.</td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/PudgyDragon/Security_Analytics/blob/main/eth0_Mapping.md">Mapping eth0</a>
      </td>
      <td>This is a guide for mapping eth0 (your management interface) to another port on your NIC.</td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/PudgyDragon/Security_Analytics/blob/main/Extra_Storage.md">New Storage Device Added</a>
      </td>
      <td>This is a guide for extending your storage into a new physical volume that you've added to your SSA device.</td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/PudgyDragon/Security_Analytics/blob/main/SSA_Proxmox.md">Proxmox SSA Installation Guide</a>
      </td>
      <td>This is another installation guide for installing SSA software on Proxmox. You will need to use the original installation guide in my other repo as a supplement.</td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/PudgyDragon/Security_Analytics/blob/main/vacuumdb.md">Vacuum DB</a>
      </td>
      <td>Quick and easy way of using vacuumdb on Security Analytics.</td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/PudgyDragon/Security_Analytics/blob/main/yum_updates.md">Yum Updates</a>
      </td>
      <td>Quick guide for changing yum repo to reference the correct baseurl for grabbing updates from. The previous mirrorlist is no longer supported.</td>
    </tr>
  </tbody>
</table>

<h2>Troubleshooting</h2>
<table>
  <tbody>
    <tr>
      <td>
        <a href="https://github.com/PudgyDragon/Security_Analytics/blob/main/Internal_Server_Error.md">Internal Server Error</a>
      </td>
      <td>This guide was created after the appliance kept getting an Internal Server Error, and it was determined that the partitioning was not correct. This walks you through the correct partitioning and how to do it.</td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/PudgyDragon/SecurityAnalytics/blob/main/Follow%20TCP%20Stream">Follow TCP Stream Issues</a>
      </td>
      <td>This guide was made for correcting an issue preventing Follow TCP Stream from working properly.</td>
    </tr>
  </tbody>
</table>

<h2>Extras</h2>
<table>
  <tbody>
    <tr>
      <td>
        <a href="https://github.com/PudgyDragon/Security_Analytics/blob/main/solera-iso-to-usb.sh">solera-iso-to-usb</a>
      </td>
      <td>Contents of the solera-iso-to-usb.sh file. It looks like it's no longer available on their website.</td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/PudgyDragon/Security_Analytics/blob/main/SearchQueries.md">Search Queries</a>
      </td>
      <td>Common search queries used for Security Analytics best practice.</td>    
    </tr>
    <tr>
      <td>
        <a href="https://github.com/PudgyDragon/Security_Analytics/blob/main/CLICommands.md">CLI Commands</a>
      </td>
      <td>Repository of commands used within Security Analytics with explanations of their funtion.</td>
    </tr>
  </tbody>
</table>
