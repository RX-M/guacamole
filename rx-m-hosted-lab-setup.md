![RX-M LLC][RX-M LLC]


## RX-M Hosted Lab Environment

The RX-M hosted training lab allows students to access a lab environment over the internet using a web browser. The lab
environment is pre-configured to provide virtual machines that have unfettered access to cloud resources (GitHub repos,
cloud storage, RPMs, etc.) required for training. Each student is provided with a unique login and their own lab
environment in an Amazon Web Services (AWS) regional datacenter.


### RX-M hosted lab network requirements

Students will need access to https://lab.rx-m.net/guacamole/ which is a clientless remote desktop gateway powered by the
open source Apache Guacamole project and backed by an AWS Elastic Compute Cloud (EC2) virtual machine instance. From
this gateway, students will have access to the lab environment and any related resources associated with the training
class.

**NOTE**: The Guacamole gateway has been assigned a static IP address for stability but may change if the AWS region
where the lab is hosted needs to be changed. For example, the IP address normally used for the gateway is assigned to
the Ohio AWS region but if the class is held on another continent, say Europe, then the latency introduced by the
distance between the student(s) and the AWS Ohio datacenter may be too great, impacting student experience and
satisfaction. In such a case, the gateway would likely be moved to a datacenter more adjacent to students, changing the
IP (if required, the new IP would be provided to customers and/or partners for whitelisting and testing prior to
commencement of class).


### Connectivity testing

It’s highly recommended that students who plan to attend a training using the RX-M hosted lab test connectivity to the
lab environment prior to the start of class. To make sure that there is connectivity between the training site and the
hosted lab, students should run a connectivity test using the URL in these instructions. _This is the only setup
required_. The test will ensure that firewalls/proxies/filters/etc are not blocking your access to the remote lab
environment. If issues do arise, steps to remediate can be undertaken prior to the start of class.

The web gateway can be available for student system testing 5 business days prior to a class start date (Additional time
can be allowed upon request by customers/partners.)


#### Test steps

To access the RX-M hosted lab environment, use an HTML5-compatible browser, such as Firefox, Internet Explorer 10 or
higher, or Google Chrome

1. Open your Internet browser and go to https://lab.rx-m.net/guacamole/

![Access https://lab.rx-m.net/guacamole](./images/01-login-page.png)

2. Log in with the username and password provided by RX-M for the test.

![Log in](./images/02-login.png)

3. Under the "All Connections" section, click on `student01-lab`. If somebody has performed the test already, you may
see a picture of a desktop under the "Recent Connections" section above.

![Click on the lab VM entry](./images/03-VM-select.png)

4. This will take you to a desktop, indicating a successful test. You may also try opening a terminal and running a
simple command such as: `ping -c 4 google.com` but it is not necessary to do so.

![Resulting view](./images/04-desktop.png)


### Accessing the lab environment during class

On the first day of class the instructor will assign each student access credentials to log in to the virtual
environment.


### Disabling Websocket Connections

If students are having trouble accessing their lab system after logging in to Guacamole, they can try the following
steps to avoid using a websocket connection.

5. **Open Firefox browser** and type `about:config` in the Address Bar:

![Access Firefox's advanced config page](./images/05-config-firefox.png)

6. Firefox displays a warning about the risks of changing the settings. Click **Accept the Risk and Continue**:

![Accept the risks and continue](./images/06-accept-risk.png)

7. Type `websocket` in the Search bar at the top of the Advanced Configuration page. This shows several
websocket-related options:

![Search for websocket in the search bar](./images/07-search-websocket.png)

8. Find `network.websocket.max-connections` and click the **Edit** button with the pencil icon:

![Click Edit to change the websocket max connections setting](./images/08-edit-websocket-max-connections.png)

9. Set the value of `network.websocket.max-connections` to `0` and click **Save**:

![Set websocket max connections to 0](./images/09-set-websocket-max-connection-0.png)

After saving the change, students should log out of their accounts, log back in, and try to use the student VM.
Guacamole will automatically fall back to using http when using the Student VM. Accessing a student VM after making
these changes results in a noticeably slower experience but should work if infrastructure does not allow for websocket
connections.

10. Users can reverse the changes by clicking the rightmost **Reset** button next to `network.websocket.max-connections`
on the Firefox advanced configuration page:

![Reset the changes](./images/10-reset-websocket-max-connections.png)

<br>

_Copyright (c) 2020 RX-M LLC, Cloud Native Consulting, all rights reserved_

[RX-M LLC]: https://rx-m.io/rxm-cnc.svg "RX-M LLC"
